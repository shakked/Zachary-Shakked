//
//  ZSSHomeNavViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/20/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSHomeNavViewController: ZSSPaintBallsViewController {

    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var schoolButton: UIButton!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var appsButton: UIButton!
    @IBOutlet weak var sportsButton: UIButton!
    @IBOutlet weak var pixableButton: UIButton!
    @IBOutlet weak var nycButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var buttonAnimator : UIDynamicAnimator!
    var buttonCollision : UICollisionBehavior!
    var buttonDynamics : UIDynamicItemBehavior!
    
    var buttons : [UIButton]!
    var subjects = [String: ZSSSubject]()

    init() {
        super.init(nibName: "ZSSHomeNavViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureButtonAnimators()
        super.viewDidLoad()
        setUpSubjects()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.alpha = 0.0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 1.0
        })
    }
    
    override func configureViews() {
        super.configureViews()
        self.buttons = [coffeeButton, schoolButton, pixableButton, sportsButton,nycButton, appsButton, appsButton]
        for button in self.buttons {
            button.transform = CGAffineTransformMakeScale(0.4, 0.4)
            button.layer.cornerRadius = 35
            button.layer.shadowColor = UIColor.blackColor().CGColor
            button.layer.shadowOffset = CGSizeMake(1, 1)
            button.layer.zPosition = 1
            button.layer.shadowOpacity = 1.0
        }
        
        profileButton.layer.masksToBounds = true
        profileButton.layer.cornerRadius = 50
        profileButton.layer.shadowColor = UIColor.blackColor().CGColor
        profileButton.layer.shadowOffset = CGSizeMake(1, 1)
        profileButton.layer.zPosition = 1
        profileButton.layer.shadowOpacity = 1.0
        
        
        runSpinAnimation(2.0)
        
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "showButtons", userInfo: nil, repeats: false)
        UIView.animateWithDuration(30.0, animations: { () -> Void in
            self.backgroundImageView.transform = CGAffineTransformMakeScale(2.0, 2.0)
        }, completion: nil)
    }
    
    func runSpinAnimation(duration: CGFloat) -> Void {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(float: Float(M_PI * 2.0))
        rotationAnimation.duration = CFTimeInterval(duration)
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 1.0
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        buttonsView.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func showButtons() -> Void {
        var timerInterval : NSTimeInterval = 0.1
        for button in self.buttons {
            NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector: "animateButtonAppearence:", userInfo: button, repeats: false)
            timerInterval += 0.4
        }
    }
    
    func animateButtonAppearence(timer: NSTimer) -> Void {
        let button = timer.userInfo! as! UIButton
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: 0.20,
            initialSpringVelocity: 6.00,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                button.transform = CGAffineTransformIdentity
            }, completion: {
                (value: Bool) in
        })
        
    }
    
    func configureButtonAnimators() -> Void {
        buttonAnimator = UIDynamicAnimator(referenceView: self.view)
        
        buttonCollision = UICollisionBehavior()
        buttonCollision.translatesReferenceBoundsIntoBoundary = true
        
        buttonDynamics = UIDynamicItemBehavior()
        buttonDynamics.elasticity = 0.9
        buttonDynamics.friction = 0.0
        buttonDynamics.allowsRotation = false
        
        buttonAnimator.addBehavior(buttonCollision)
        buttonAnimator.addBehavior(buttonDynamics)
    }
    
    func setUpSubjects() -> Void {
        var coffeeSubject = ZSSSubject()
        coffeeSubject.titleText = "I LOVE Coffee"
        coffeeSubject.label1Text = "Coffee is one of those things I could not live without. It can completely alter my mood. If I'm having a bad day, a nice cup of coffee can completely change my day. Some of my friends say I have a problem because I drink so much coffee. If there were such thing as a coffee chugging contest, I would probably come close to winning."
        coffeeSubject.label2Text = "Dunkin Donut's motto is 'America Runs on Dunkin'. My transmission NEEDS Dunkin to run. 'Xtra Large with Milk and Sugar, Extra Milk'. That's my order, every single time. I love Dunkin and I love coffee."
        coffeeSubject.backgroundImage = UIImage(named: "FlatironFilter.jpg")
        coffeeSubject.iconImage = UIImage(named: "Mug")
        coffeeSubject.backgroundColor = coffeeButton.backgroundColor!
        
        self.subjects["coffee"] = coffeeSubject

        var schoolSubject = ZSSSubject()
        schoolSubject.titleText = "My Education"
        schoolSubject.label1Text = "After being rejected from Brown, Cornell, Tufts, and Johns Hopkins, I ended up at Stevens Institute of Technology. Although the rejections were emotional, they were the best thing that happened to me. I have a million dollar view from my dorm room and get to go to the most amazing city in the world all the time. "
        schoolSubject.label2Text = "After a Computer Science class, I'll have dinner in the beautiful city of Hoboken with my dad and then attend an iOS meetup in the city. I've met many iOS developers who've helped me get to where I am today. None of this would've been possible if I wasnt by such a resourceful and diverse city."
        schoolSubject.backgroundImage = UIImage(named: "NYCSunset.jpg")
        schoolSubject.iconImage = UIImage(named: "School")
        schoolSubject.backgroundColor = schoolButton.backgroundColor!
        
        self.subjects["school"] = schoolSubject
        
        
        coffeeSubject.nextSubject = schoolSubject
        schoolSubject.nextSubject = coffeeSubject
        
    }
    

    @IBAction func coffeeButtonTapped(sender: AnyObject) {
        let civ = ZSSInfoViewController()
        civ.subject = subjects["coffee"]
        presentViewController(civ, animated: true, completion:nil)
    }
    
    @IBAction func schoolButtonTapped(sender: AnyObject) {
        let civ = ZSSInfoViewController()
        civ.subject = subjects["school"]
        presentViewController(civ, animated: true, completion:nil)
    }

    @IBAction func pixableButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func sportsButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func nycButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func appsButtonTapped(sender: AnyObject) {
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
      
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
