//
//  ZSSPixableMoreViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import MapKit

class ZSSPixableMoreViewController: UIViewController {

    var height : CGFloat!
    var width : CGFloat!
    var scrollView: UIScrollView!
    var mapView : MKMapView!
    var backButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.alpha = 0.0
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.view.alpha = 1.0
        })
    }
    
    func configureViews() -> Void {
        self.view.backgroundColor = UIColor(red: 207/255.0, green: 53/255.0, blue: 111/255.0, alpha: 1.0)
        configureScrollView()
        configureOtherViews()
        configureBackButton()
        configureMap()
    }
    
    func configureScrollView() -> Void {
        self.height = self.view.frame.size.height
        self.width = self.view.frame.size.width
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(width, height * 1.5)
    }
    
    func configureOtherViews() -> Void {
        let pixableIsLabel = UILabel(frame: CGRectMake(8, 8, width - 16, 220))
        pixableIsLabel.text = "Pixable is in a beautiful part of New York."
        pixableIsLabel.numberOfLines = 3
        pixableIsLabel.font = UIFont(name: "Avenir-Light", size:48.0)
        pixableIsLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(pixableIsLabel)
        
        let roomLabel = UILabel(frame: CGRectMake(8, 544, width - 16, 200))
        roomLabel.text = "There's a room with a view of the Brooklyn Bridge."
        roomLabel.numberOfLines = 3
        roomLabel.font = UIFont(name: "Avenir-Light", size: 40.0)
        roomLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(roomLabel)
        
        let brooklynBridgeImageView = UIImageView(frame: CGRectMake(0, 800, width, width / 3.0))
        brooklynBridgeImageView.image = UIImage(named: "BrooklynBridge.jpeg")
        brooklynBridgeImageView.contentMode = .ScaleAspectFill
        self.scrollView.addSubview(brooklynBridgeImageView)
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
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureMap() -> Void {
        mapView = MKMapView(frame: CGRectMake(0, 236, width, 300))
        self.scrollView.addSubview(mapView)
        let initialLocation = CLLocation(latitude: 40.704747, longitude: -74.0069)
        centerMapOnLocation(initialLocation)
        let pixablePin = Artwork(title: "Pixable", locationName: "105 Wallstreet", discipline: "WorkPlace", coordinate: CLLocationCoordinate2D(latitude: 40.704747, longitude: -74.0069))
        mapView.addAnnotation(pixablePin)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
}
