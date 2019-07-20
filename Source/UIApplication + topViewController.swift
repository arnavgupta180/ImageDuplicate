//
//  DupicateAssets.swift
//  abc
//
//  Created by Arnav on 20/06/19.
//  Copyright © 2019 Tokopedia. All rights reserved.
//

import Foundation
import UIKit

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
