//
//  ZSSHomeNavViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/20/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSHomeNavViewController: UIViewController {

    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var schoolButton: UIButton!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var appsButton: UIButton!
    @IBOutlet weak var sportsButton: UIButton!
    @IBOutlet weak var pixableButton: UIButton!
    @IBOutlet weak var nycButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileWrapperView : UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var hiImZachLabel: UILabel!
    @IBOutlet weak var clickTheButtonsLabel: UILabel!
    
    var animator : UIDynamicAnimator!
    var initialAnimationCompleted : Bool = false
    
    var buttons : [UIButton]!
    var subjects = [String: ZSSSubject]()

    init() {
        super.init(nibName: "ZSSHomeNavViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubjects()
        configureViews()
        configureInitialAnimation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.alpha = 0.0
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 1.0
        })
    }
    
    func configureViews() {
        self.buttons = [coffeeButton, schoolButton, pixableButton, sportsButton,nycButton, appsButton, appsButton]
        for button in self.buttons {
            button.transform = CGAffineTransformMakeScale(0.4, 0.4)
            button.layer.cornerRadius = 35
            button.layer.shadowColor = UIColor.blackColor().CGColor
            button.layer.shadowOffset = CGSizeMake(1, 1)
            button.layer.zPosition = 1
            button.layer.shadowOpacity = 1.0
        }
        
        self.view.sendSubviewToBack(self.backgroundImageView)
        profileImageView.layer.cornerRadius = 50
//        profileImageView.layer.shadowColor = UIColor.blackColor().CGColor
//        profileImageView.layer.shadowOffset = CGSizeMake(5, 5)
        profileImageView.layer.zPosition = 1
//        profileImageView.layer.shadowOpacity = 1.0
        profileImageView.backgroundColor = UIColor.redColor()
        profileImageView.frame = CGRectMake(0, 0, 100, 100)

        profileWrapperView.backgroundColor = UIColor.orangeColor()
        profileWrapperView.layer.cornerRadius = 50.0
        profileWrapperView.layer.shadowColor = UIColor.blackColor().CGColor
        profileWrapperView.layer.shadowOffset = CGSizeMake(5,5)
        profileWrapperView.layer.zPosition = 1
        profileWrapperView.layer.shadowOpacity = 1.0
        profileWrapperView.layer.masksToBounds = true
        
        runSpinAnimation(2.0)
        
        hiImZachLabel.layer.shadowOffset = CGSizeMake(1,1)
        hiImZachLabel.layer.shadowColor = UIColor.blackColor().CGColor
        hiImZachLabel.layer.masksToBounds = false
        hiImZachLabel.layer.shadowOpacity = 1.0
        hiImZachLabel.alpha = 0.0
        
        clickTheButtonsLabel.layer.shadowOffset = CGSizeMake(1,1)
        clickTheButtonsLabel.layer.shadowColor = UIColor.blackColor().CGColor
        clickTheButtonsLabel.layer.masksToBounds = false
        clickTheButtonsLabel.layer.shadowOpacity = 1.0
        clickTheButtonsLabel.alpha = 0
        
        configureAnimators()
    }
    
    func configureAnimators() -> Void {
        self.animator = UIDynamicAnimator(referenceView: self.view)

    }
    
    func configureInitialAnimation() -> Void{
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "showHi", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "showClickTheButtons", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(4.5, target: self, selector: "showButtons", userInfo: nil, repeats: false)
    }
    
    func showHi() -> Void {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
                self.hiImZachLabel.alpha = 1.0
            }) { (completed: Bool) -> Void in
                
        }
    }
    
    func showClickTheButtons() -> Void {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
            self.clickTheButtonsLabel.alpha = 1.0
            }) { (completed: Bool) -> Void in
                
        }
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
        UIView.animateWithDuration(30.0, animations: { () -> Void in
            self.backgroundImageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: nil)
        var timerInterval : NSTimeInterval = 0.1
        for button in self.buttons {
            NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector: "animateButtonAppearence:", userInfo: button, repeats: false)
            timerInterval += 0.4
        }
        self.initialAnimationCompleted = true
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
    
    func setUpSubjects() -> Void {
        var coffeeSubject = ZSSSubject()
        self.subjects["coffee"] = coffeeSubject
        coffeeSubject.titleText = "I LOVE Coffee"
        coffeeSubject.label1Text = "Coffee is one of those things I could not live without. Aside from its delicious bitter flavor, the exquisite drink can completely alter my mood. If I'm having a bad day, a nice cup of coffee can change everything. Coffee is crucial to my daily routine. It helps me get up at 6AM to go to the gym, it helps me finish my research essay, it helps me be exciting and energetic. Some of my friends say I have a problem because I drink so much coffee. If there were such a thing as a coffee chugging contest, I would probably come close to winning."
        coffeeSubject.label2Text = "Dunkin Donut's motto is 'America Runs on Dunkin'. I certainly run on Dunkin. 'Xtra Large with Milk and Sugar, Extra Milk'. That's my order, every single time. I love Dunkin and I love coffee."
        coffeeSubject.backgroundImage = UIImage(named: "FlatironFilterWide.jpeg")
        coffeeSubject.iconImage = UIImage(named: "Mug")
        coffeeSubject.backgroundColor = coffeeButton.backgroundColor!
        coffeeSubject.presentSelf = {(animated: Bool) in
            let civ = ZSSCoffeeInfoViewController()
            civ.subject = self.subjects["coffee"]
            self.presentViewController(civ, animated: animated, completion:nil)
        }
        
        

        var schoolSubject = ZSSSubject()
        self.subjects["school"] = schoolSubject
        schoolSubject.titleText = "My Education"
        schoolSubject.label1Text = "After being rejected from Brown, Cornell, Tufts, and Johns Hopkins, I ended up at Stevens Institute of Technology. Although the rejections were emotional, they were the best thing that happened to me. I have arguably one of the best views from my dorm--the NYC skyline. Being in Hoboken, I have very easy and quick access to the city. "
        schoolSubject.label2Text = "I have the flexibility to see my family frequently and glean skills and wisdom from the diverse offerings of the city. I've made incredible friends here who have similar interests to mine. My room mate next year is a Web legend. We frequently show eachother cool new technologies and even build things together."
        schoolSubject.backgroundImage = UIImage(named: "NYCSunset.jpg")
        schoolSubject.iconImage = UIImage(named: "School")
        schoolSubject.backgroundColor = schoolButton.backgroundColor!
        schoolSubject.presentSelf = {(animated: Bool) in
            let civ = ZSSSchoolViewController()
            civ.subject = self.subjects["school"]
            self.presentViewController(civ, animated: animated, completion:nil)
        }
        
        
        
        var pixableSubject = ZSSSubject()
        self.subjects["pixable"] = pixableSubject
        pixableSubject.titleText = "Pixable Intern"
        pixableSubject.label1Text = "Being close to NYC, I'm able to attend meetups very frequently. My favorite meetup is iOS Side Projects where I met an amazing self-taught iOS developer named Eugene. He quickly became my mentor and my go-to person with any questions, career-related, iOS-related, etc."
        pixableSubject.label2Text = "I told Eugene I was looking for an internship to get even better at iOS and he quickly introduced me to some of his iOS friends. I successfully interviewed at a small start-up called Pixable where I'll be working over the summer. I'll likely be working on an Apple Watch app for the company which I am super excited about!"
        pixableSubject.iconImage = UIImage(named: "Work")
        pixableSubject.backgroundImage = UIImage(named: "BridgeSky.jpeg")
        pixableSubject.backgroundColor = pixableButton.backgroundColor!
        pixableSubject.presentSelf = {(animated: Bool) in
            let civ = ZSSPixableViewController()
            civ.subject = self.subjects["pixable"]
            self.presentViewController(civ, animated: animated, completion:nil)
        }

        
        var sportsSubject = ZSSSubject()
        self.subjects["sports"] = sportsSubject
        sportsSubject.titleText = "I like Sports"
        sportsSubject.label1Text = "One of my favorite ways to enjoy nice weather is to play some golf. In high school, I was on the golf team for two years. I love the sport! It is so relaxing and fun."
        sportsSubject.label2Text = "Now that the weather is nice in Hoboken, NJ, my friends and I like to toss around the pigskin (football) on campus. Unfortunately, I can't really play golf here at Stevens, but at least I can toss the pig with my buds!"
        sportsSubject.iconImage = UIImage(named: "Sports")
        sportsSubject.backgroundImage = UIImage(named: "Bridge.jpeg")
        sportsSubject.backgroundColor = sportsButton.backgroundColor!
        sportsSubject.presentSelf = {(animated: Bool) in
            let civ = ZSSSportsViewController()
            civ.subject = self.subjects["sports"]
            self.presentViewController(civ, animated: animated, completion:nil)
        }

        
        var nycSubject = ZSSSubject()
        self.subjects["nyc"] = nycSubject
        nycSubject.titleText = "New York, NY"
        nycSubject.label1Text = "I've always found New York City to be so inspiring. It's impossible to be at my desk, look at that skyline and waste time. The view makes me realize how amazing life is."
        nycSubject.label2Text = "New York City has helped me so much with my iOS skills. Without all the meetups I've attended, it would've been much harder for me to be where I am today, a skilled iOS developer with 4 published iPhone apps. Also, it would've been much more difficult to find an internship if I wasn't so close."
        nycSubject.iconImage = UIImage(named: "NYC")
        nycSubject.backgroundImage = UIImage(named: "NYCNight.jpeg")
        nycSubject.backgroundColor = nycButton.backgroundColor!
        nycSubject.presentSelf = {(animated: Bool) in
            let civ = ZSSNYCViewController()
            civ.subject = self.subjects["nyc"]
            self.presentViewController(civ, animated: animated, completion:nil)
        }

        
        var appsSubject = ZSSSubject()
        self.subjects["apps"] = appsSubject
        appsSubject.titleText = "MyApps"
        appsSubject.label1Text = "A year ago, I was just beginning to learn Objective - C. I bought the Big Nerd Ranch book for Objective - C and found myself buried in it after high school every day. At the time I didn't have a Mac, so I would drive to my friends house early in the AM, borrow his Mac, code for 3 or 4 hours, and then bring it back. I'd take a bus into NYC where my sister lives and spend an entire weekend there programming. Finally, I bought myself a Mac."
        appsSubject.label2Text = "From there, I made it my goal to publish an app by the end of the summer. I did indeed publish an app at the end of August called 'Productiv', a simple task management app that gives you graphical feedback. Today, I have 3 more apps in addition to Productiv. Learn more below."
        appsSubject.iconImage = UIImage(named: "iPhone")
        appsSubject.backgroundImage = UIImage(named: "Hudson.jpeg")
        appsSubject.backgroundColor = appsButton.backgroundColor!
        appsSubject.presentSelf = {(animated: Bool) in
            let civ = ZSSAppsInfoViewController()
            civ.subject = self.subjects["apps"]
            self.presentViewController(civ, animated: animated, completion:nil)
        }
        
        appsSubject.presentTellMeMore = {(animated: Bool) in
            let appList = ZSSAppListViewController()
            self.presentViewController(appList, animated: true, completion: nil)
        }
    

        coffeeSubject.nextSubject = schoolSubject
        schoolSubject.nextSubject = pixableSubject
        pixableSubject.nextSubject = sportsSubject
        sportsSubject.nextSubject = nycSubject
        nycSubject.nextSubject = appsSubject
        appsSubject.nextSubject = coffeeSubject
    }
    
    
    

    @IBAction func coffeeButtonTapped(sender: AnyObject) {
        let civ = ZSSInfoViewController()
        civ.subject = subjects["coffee"]
        civ.subject.presentSelf(animated: true)
    }
    
    @IBAction func schoolButtonTapped(sender: AnyObject) {
        let civ = ZSSSchoolViewController()
        civ.subject = subjects["school"]
        civ.subject.presentSelf(animated: true)
    }

    @IBAction func pixableButtonTapped(sender: AnyObject) {
        let civ = ZSSPixableViewController()
        civ.subject = subjects["pixable"]
        civ.subject.presentSelf(animated: true)
    }
    
    @IBAction func sportsButtonTapped(sender: AnyObject) {
        let civ = ZSSSportsViewController()
        civ.subject = subjects["sports"]
        civ.subject.presentSelf(animated: true)
    }
    
    @IBAction func nycButtonPressed(sender: AnyObject) {
        let civ = ZSSNYCViewController()
        civ.subject = subjects["nyc"]
        civ.subject.presentSelf(animated: true)
    }
    
    @IBAction func appsButtonTapped(sender: AnyObject) {
        let civ = ZSSInfoViewController()
        civ.subject = subjects["apps"]
        civ.subject.presentSelf(animated: true)
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
    @IBAction func attributesButtonPressed(sender: AnyObject) {
        let avc = ZSSAttributeViewController()
        let nav = UINavigationController(rootViewController: avc)
        self.presentViewController(nav, animated: false, completion: nil)
    }
}
