//
//  ViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/2/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTile: UIButton!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var StartGame: UIButton!
    
    var userID = ""
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    var bannerView: GADBannerView!
    var colors = [UIColor.white, UIColor.black, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.cyan, UIColor.orange, UIColor.gray, UIColor.red]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "uid") == nil {
            let getName = UIAlertController(title: "Give us a name!", message: "We'll save your score so you can brag a lil ;)", preferredStyle: .alert)
            getName.addTextField { (text) in print("Goofy") }
            let submit = UIAlertAction(title: "Submit", style: .default) { (alert) in
                var answer = getName.textFields![0]
                if answer == nil {
                    print("shit is empty homie")
                    //HANDLE THIS LATER PAPI
                } else {
                    let db = Firestore.firestore()
                    let newUser = db.collection("users")
                    var newDoc: DocumentReference? = nil
                    newDoc = newUser.addDocument(data: ["name" : answer, "highScore": 0]) { (err) in
                        if let err = err {
                            print("Error: \(err)")
                        } else {
                            defaults.set("UID", forKey: newDoc!.documentID)
                        }
                    }
                }
            }
        } else {
            //fetch uid
        }
        super.viewDidLoad()
        
        //ad stuff
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: bottomLayoutGuide,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }
    
    // MARK: - Start
    func start() {
        var halt = false
        let timer = Timer(timeInterval: 30, repeats: false) { _ in
            
        }
        timer.fire()
        toggleColors()
        toggleMainColor()
        while halt == false {
            mainTile.alpha = 1
            button1.alpha = 1
            button2.alpha = 1
            button3.alpha = 1
            button4.alpha = 1
            button5.alpha = 1
            button6.alpha = 1
            button7.alpha = 1
            button8.alpha = 1
            button9.alpha = 1
            if halt == true{
                var finalScore = score.text as! Int
                let db = Firestore.firestore()
                let userScoresRef = db.collection("users").document(userID)
                userScoresRef.getDocument { (snap, err) in
                    if let err = err {
                        print("Error: \(err)")
                    } else {
                        //if this score was higher then the users best score, then they get a UIAlert
                        var userHighScore = snap?.data()!["highScore"] as! Int
                        if finalScore > userHighScore {
                            let highScoreAlert = UIAlertController(title: "New High Score", message: "USER NEW SCORE", preferredStyle: .alert)
                            let close = UIAlertAction(title: "close", style: .default) { (aler) in
                                print("we out")
                            }
                            highScoreAlert.addAction(close)
                            self.present(highScoreAlert, animated: true)
                            userScoresRef.updateData(["highScore" : finalScore])
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Button Functions
    @IBAction func startGameTouch(_ sender: Any) {
    }
    
    @IBAction func button1Touch(_ sender: Any) {
        var color = button1.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            self.viewDidLoad()
        }
    }
    
    @IBAction func button2Touch(_ sender: Any) {
    
    }
    
    @IBAction func button3Touch(_ sender: Any) {
    
    }
    
    @IBAction func button4Touch(_ sender: Any) {
    
    }
    
    @IBAction func button5Touch(_ sender: Any) {
    
    }
    
    @IBAction func button6Touch(_ sender: Any) {
    
    }
    
    @IBAction func button7Touch(_ sender: Any) {
    
    }
    
    @IBAction func button8Touch(_ sender: Any) {
    
    }
    
    @IBAction func button9Touch(_ sender: Any) {
    
    }
    
    
    
    // MARK: - Toggle Tile colors
    //Call self.viewDidLoad() after calling this function
    func toggleColors() {
        var count = 0
        var tiles = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
        var randomColor = colors.shuffled()
        for button in tiles{
            let color = randomColor[count]
            button?.backgroundColor = color
            count += 1
        }
        count = 0
    }
    
    func toggleMainColor() {
        let randomColor = colors.randomElement()
        self.mainTile.backgroundColor = randomColor
    }
}


