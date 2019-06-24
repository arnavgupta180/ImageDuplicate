//
//  DupicateAssets.swift
//  abc
//
//  Created by Arnav on 20/06/19.
//  Copyright © 2019 Tokopedia. All rights reserved.
//

import Foundation
import UIKit

public class DuplicateAssets{
    
    @objc  public func findDuplicates() {
        var asset: [(data: Data?, name: String)] = []
        
        var duplicateNames: [[String: [String]]] = []
        var duplicateImages: [[String: [String]]] = []
        
        var images = ImageConstants.imageNames
        images = Array(Set(images))
        
        for image in images {
            var name = image
            name = "/" + image + ".imageset"
            let containingNames = ImageConstants.imagePaths.filter({ $0.contains(name) })
            if containingNames.count > 1 {
                duplicateNames.append([image : containingNames])
            }
        }
        
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
                    duplicateImages.append(self.findPathOfDuplicates(firstImage: image.name, secondImage: data.name))
                    arrComp.append("\(image.name) is equal to \(data.name)")
                }
            }
        }
        
        if let vc = UIApplication.getTopViewControllerForAssetDup() {
            let openDuplicates = ShowDuplicatesTableViewController()
            openDuplicates.showDuplicates = duplicateImages
            vc.present(openDuplicates, animated: true, completion: nil)
        }
    }
    
   public  func findPathOfDuplicates(firstImage: String, secondImage: String) -> [String: [String]]{
        var firstName = firstImage
        firstName = "/" + firstImage + ".imageset"
        var secondName = secondImage
        secondName = "/" + secondImage + ".imageset"
        let firstNames = ImageConstants.imagePaths.filter({ $0.contains(firstName)})
        let secondNames = ImageConstants.imagePaths.filter({ $0.contains(secondName)})
        let paths =  ["paths of \(firstImage)"] + firstNames + ["paths of \(secondImage)"] + secondNames
        return ["\(firstImage) == \(secondImage)" : paths]
    }
}

extension UIApplication {
    
    class func getTopViewControllerForAssetDup(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewControllerForAssetDup(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewControllerForAssetDup(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewControllerForAssetDup(base: presented)
        }
        return base
    }
}
