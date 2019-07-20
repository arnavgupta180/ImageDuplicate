//
//  AssetDuplicateFinderViewController.swift
//  ImageDuplicate
//
//  Created by Arnav on 29/06/19.
//

import UIKit

public class AssetDuplicateFinder: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    internal var tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    internal var navigationView = UIView(frame: .zero)
    private var  duplicateName: [[String : [String]]] = []
    private var duplicateImage: [[String : [String]]] = []
    override public func loadView() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
        settingNavigationView()
        duplicateName = duplicateNames()
        duplicateImage = duplicateImages()
    }
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            navigationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.navigationView.bottomAnchor, constant: 0),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func settingTableView(){
        tableView.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseableIdentifier")
        tableView.rowHeight = UITableView.automaticDimension
    }
    private func settingNavigationView(){
        navigationView = UIView(frame: .zero)
        navigationView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80
        )
        let title = UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - 80, y: 30, width: 200, height: 40))
        title.text = "Asset Duplicate Finder"
        title.backgroundColor = .clear
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 16)
        let button = UIButton(frame: CGRect(x: 16, y: 30, width: 40, height: 40))
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        navigationView.backgroundColor = .white
        navigationView.addSubview(button)
        navigationView.addSubview(title)
    }
    
    @objc  func buttonTapped(sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc public class func findDuplicates() {
        if let topViewController = UIApplication.getTopViewControllerForAssetDup() {
            let openDuplicates = AssetDuplicateFinder()
            topViewController.present(openDuplicates, animated: true, completion: nil)
        }
    }
}

extension AssetDuplicateFinder{
    // MARK: - Table view data source
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseableIdentifier", for: indexPath)
        cell.selectionStyle = .none
        if indexPath.row == 0{
            cell.textLabel?.text = "Duplicate images(same data)"
        }else{
            cell.textLabel?.text = "Duplicate image names(multiple bundles)"
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            findDuplicates(imageDuplicates: duplicateImage)
        }else{
            findDuplicates(imageDuplicates: duplicateName)
        }
    }
}

extension AssetDuplicateFinder {
    
    private func findDuplicates(imageDuplicates: [[String : [String]]]) {
        let openDuplicates = ShowDuplicatesTableViewController()
        openDuplicates.showDuplicates = imageDuplicates
        self.present(openDuplicates, animated: true, completion: nil)
    }
    
    private func duplicateNames() -> [[String: [String]]]{
        var images = AVImageConstants.imageNames
        images = Array(Set(images))
        var duplicates: [[String: [String]]] = []
        for image in images {
            var name = image
            name = "/" + image + ".imageset"
            let containingNames = AVImageConstants.imagePaths.filter({ $0.contains(name) })
            if containingNames.count > 1 {
                duplicates.append([image : containingNames])
            }
        }
        return duplicates
    }
    
    private func duplicateImages() -> [[String: [String]]]{
        var images = AVImageConstants.imageNames
        images = Array(Set(images))
        var asset: [(data: Data?, name: String)] = []
        var duplicates: [[String: [String]]] = []
        for imageName in images {
            let name = imageName
            var image: UIImage?
            image = UIImage(named: name)
            if image == nil {
                for bundle in Bundle.allBundles {
                    image = UIImage(named: name, in: bundle, compatibleWith: nil)
                    if image != nil {
                        break
                    }
                }
            }
            if let image = image {
                let data = image.pngData()
                asset.append((data: data, name: name))
            }
        }
        var arrComp: [String] = []
        for data in asset {
            for image in asset {
                if data.name != image.name
                    && !arrComp.contains("\(data.name) is equal to \(image.name)")
                    && data.data?.count == image.data?.count
                    && data.data == image.data {
                    duplicates.append(self.findPathOfDuplicates(firstImage: image.name, secondImage: data.name))
                    arrComp.append("\(image.name) is equal to \(data.name)")
                }
            }
        }
        return duplicates
    }
    
    private func findPathOfDuplicates(firstImage: String, secondImage: String) -> [String: [String]]{
        var firstName = firstImage
        firstName = "/" + firstImage + ".imageset"
        var secondName = secondImage
        secondName = "/" + secondImage + ".imageset"
        let firstNames = AVImageConstants.imagePaths.filter({ $0.contains(firstName)})
        let secondNames = AVImageConstants.imagePaths.filter({ $0.contains(secondName)})
        let paths =  ["paths of \(firstImage)"] + firstNames + ["paths of \(secondImage)"] + secondNames
        return ["\(firstImage) == \(secondImage)" : paths]
    }
}
