//
//  ViewController.swift
//  ImageDuplicate
//
//  Created by codegeeker180 on 06/24/2019.
//  Copyright (c) 2019 codegeeker180. All rights reserved.
//

import UIKit
import ImageDuplicate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        AssetDuplicateFinder.findDuplicates()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

