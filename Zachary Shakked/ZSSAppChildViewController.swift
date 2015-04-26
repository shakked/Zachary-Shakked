//
//  ZSSAppChildViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSAppChildViewController: UIViewController {

    @IBOutlet weak var screenShotImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    var index : Int = 0
    var titleText : String!
    var backgroundColor : UIColor!
    var screenShot : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func viewWillAppear(animated: Bool) {
        self.screenShotImageView.image = screenShot
        self.view.backgroundColor = backgroundColor
        self.titleTextLabel.text = titleText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
