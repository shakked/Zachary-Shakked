//
//  ZSSNYCMoreViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSNYCMoreViewController: UIViewController, UIScrollViewDelegate {

    var height : CGFloat!
    var width : CGFloat!
    var scrollView : UIScrollView!
    var backButton : UIButton!
    var bigImagesView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.alpha = 0.0
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.alpha = 1.0
        })
    }
    
    func configureViews() -> Void {
        configureImageViews()
        configureScrollView()
        configureBackButton()
        configureLabels()
    }
    
    func configureScrollView() -> Void {
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(11 * width, height)
        scrollView.delegate = self
    }
    
    func configureImageViews() -> Void {
        self.height = self.view.frame.size.height
        self.width = self.view.frame.size.width
        bigImagesView = UIView(frame: CGRectMake(0,0, 6 * width, height))
        self.view.addSubview(bigImagesView)
        
        let tunnelImageView = UIImageView(frame: CGRectMake(0,0, 2 * width, height))
        tunnelImageView.contentMode = .ScaleAspectFill
        tunnelImageView.image = UIImage(named: "tunnel.jpg")
        bigImagesView.addSubview(tunnelImageView)
        
        let icerinkImageView = UIImageView(frame: CGRectMake(2 * width,0, 2 * width, height))
        icerinkImageView.contentMode = .ScaleAspectFill
        icerinkImageView.image = UIImage(named: "icerink.jpg")
        bigImagesView.addSubview(icerinkImageView)
        
        let grandcentralImageView = UIImageView(frame: CGRectMake(4 * width,0, 2 * width, height))
        grandcentralImageView.contentMode = .ScaleAspectFill
        grandcentralImageView.image = UIImage(named: "grandcentral.jpg")
        bigImagesView.addSubview(grandcentralImageView)
    }
    
    func configureLabels() -> Void {
        let suchBeautyLabel = UILabel(frame: CGRectMake(width, 50, width - 16, 220))
        suchBeautyLabel.text = "There is so much beauty in New York."
        suchBeautyLabel.numberOfLines = 3
        suchBeautyLabel.font = UIFont(name: "Avenir-Light", size: 48.0)
        suchBeautyLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(suchBeautyLabel)
        
        let opportunityLabel = UILabel(frame: CGRectMake(3 * width, 350, width, 220))
        opportunityLabel.text = "Abundant with opportunity and diversity"
        opportunityLabel.numberOfLines = 3
        opportunityLabel.font = UIFont(name: "Avenir-Light", size: 48.0)
        opportunityLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(opportunityLabel)
        
        let nycHasHelpedLabel = UILabel(frame: CGRectMake(5 * width, 50, width, 220))
        nycHasHelpedLabel.text = "NYC has truly helped me get to where I am today"
        nycHasHelpedLabel.numberOfLines = 3
        nycHasHelpedLabel.font = UIFont(name: "Avenir-Light", size: 48.0)
        nycHasHelpedLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(nycHasHelpedLabel)
        
        let andIKnowLabel = UILabel(frame: CGRectMake(9 * width, 350, width, 220))
        andIKnowLabel.text = "And I know it will continue to help me"
        andIKnowLabel.numberOfLines = 3
        andIKnowLabel.font = UIFont(name: "Avenir-Light", size: 48.0)
        andIKnowLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(andIKnowLabel)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let imageFrame = self.bigImagesView.frame
        let newFrame = CGRectMake(0 - (0.5 * scrollView.contentOffset.x ), 0, imageFrame.size.width, imageFrame.size.height)
        self.bigImagesView.frame = newFrame
    }
    
    func configureBackButton() -> Void {
        backButton = UIButton(frame: CGRectMake(8, height - 58, 50, 50))
        backButton.setImage(UIImage(named: "ZachIcon"), forState:.Normal)
        backButton.layer.zPosition = 1
        backButton.addTarget(self, action: "dismissAndFadeView", forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBackButton", userInfo: backButton, repeats: true)
        
    }
    
    func dismissAndFadeView() -> Void {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (completed: Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func rotateBackButton() -> Void {
        runSpinAnimation(self.backButton, duration:1.0)
    }
    
    func runSpinAnimation(view: UIView, duration: CGFloat) -> Void {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(float: Float(M_PI * 2.0))
        rotationAnimation.duration = CFTimeInterval(duration)
        rotationAnimation.cumulative = true
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }

    
    
    

}
