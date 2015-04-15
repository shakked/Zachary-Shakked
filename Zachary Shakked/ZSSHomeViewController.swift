//
//  ZSSHomeViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/14/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingBalls()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoadingBalls() -> Void {
        let greenBall = ZSSBall(radius: 10, center: CGPointMake(50, 50), color: UIColor.greenColor())
        let blueBall = ZSSBall(radius: 25, center: CGPointMake(200, 200), color: UIColor.blueColor())
        blueBall.interactivityEnabled = true
        view.addSubview(greenBall)
        view.addSubview(blueBall)
    }

}
