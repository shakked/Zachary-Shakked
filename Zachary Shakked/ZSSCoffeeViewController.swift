//
//  ZSSCoffeeViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import MapKit

class ZSSCoffeeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        let initialLocation = CLLocation(latitude: 40.744906, longitude: -74.028994)
        centerMapOnLocation(initialLocation)
        
        let artwork = Artwork(title: "Dunkin Donuts",
            locationName: "Heaven",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 40.744906, longitude: -74.028994))
        
        let chipotle = Artwork(title: "Chipotle", locationName: "Burritos galore",discipline: "Food Place", coordinate: CLLocationCoordinate2D(latitude: 40.739596, longitude: -74.029981))
        
        let castlePoint = Artwork(title: "Castle Point", locationName: "Best view of the City",discipline: "Lookout", coordinate: CLLocationCoordinate2D(latitude: 40.7442354, longitude: -74.0246408))
        
        let pathStation = Artwork(title: "Path Station", locationName: "How I get to the City",discipline: "Public Transportaiton", coordinate: CLLocationCoordinate2D(latitude: 40.7366517, longitude: -74.0294974))

        
        mapView.addAnnotation(artwork)
        mapView.addAnnotation(chipotle)
        mapView.addAnnotation(castlePoint)
        mapView.addAnnotation(pathStation)
    }

    init() {
        super.init(nibName: "ZSSCoffeeViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissAndFadeView()
    }
    
    func configureBackButton() -> Void {
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBackButton", userInfo: backButton, repeats: true)
    }
    
    func dismissAndFadeView() -> Void {
        UIView.animateWithDuration(1.5, animations: { () -> Void in
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
