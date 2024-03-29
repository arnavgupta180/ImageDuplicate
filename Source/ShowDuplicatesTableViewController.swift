//
//  ShowDuplicatesTableViewController.swift
//  Affiliate
//
//  Created by Arnav on 13/06/19.
//

import UIKit

class ShowDuplicatesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    internal var showDuplicates: [[String : [String]]] = []
    internal var tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
    internal var navigationView = UIView(frame: .zero)
    override public func loadView() {
        self.view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
        settingNavigationView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            navigationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 0),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    private func settingTableView(){
        tableView.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.rowHeight = UITableView.automaticDimension
    }
    private func settingNavigationView(){
        navigationView = UIView(frame: .zero)
        navigationView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80
        )
        let title = UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - 80, y: 30, width: 200, height: 40))
        title.text = "Duplicate Images"
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
    @objc func buttonTapped(sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return showDuplicates.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showDuplicates[section].first?.value.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = showDuplicates[indexPath.section].first?.value[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = view as? UITableViewHeaderFooterView else { return UIView()}
        header.textLabel?.textAlignment = .center
        header.textLabel?.text = showDuplicates[section].first?.key
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return header
    }
    
    
    
}
