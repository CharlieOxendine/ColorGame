//
//  ViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/2/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FirebaseFirestore

class gameViewController: UIViewController {
    
    @IBOutlet weak var mainTile: UIButton!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var StartGame: UIButton!
    
    var userID = ""
    var scoreNum = 0
    
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
        getName()
        super.viewDidLoad()
    }
    
    func getName() {
        let defaults = UserDefaults.standard
        self.userID = defaults.string(forKey: "uid")!
    }
    
    func formatView() {
        mainTile.alpha = 0
        button1.alpha = 0
        button2.alpha = 0
        button3.alpha = 0
        button4.alpha = 0
        button5.alpha = 0
        button6.alpha = 0
        button7.alpha = 0
        button8.alpha = 0
        button9.alpha = 0
        self.StartGame.alpha = 1

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
    
    @objc func saveData(){
        
    }
    // MARK: - Start
    func start() {
        var halt = false
        let timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { timer in
            self.mainTile.alpha = 0
            self.button1.alpha = 0
            self.button2.alpha = 0
            self.button3.alpha = 0
            self.button4.alpha = 0
            self.button5.alpha = 0
            self.button6.alpha = 0
            self.button7.alpha = 0
            self.button8.alpha = 0
            self.button9.alpha = 0
            self.StartGame.alpha = 0
            var finalScore = self.score.text as! String
            self.scoreNum = Int(finalScore)!
            self.score.text = "0"
            let db = Firestore.firestore()
            let ref = db.collection("users").document(self.userID)
            ref.getDocument { (snap, err) in
                if let err = err {
                    print("Error: \(err)")
                } else {
                    var highscoreString = snap?.data()!["highScore"] as! String
                    var highscore = Int(highscoreString)
                    var currentScore = Int(finalScore)
                    
                    if currentScore! > highscore! {
                        let highAlert = UIAlertController(title: "New High Score", message: finalScore, preferredStyle: .alert)
                        let close = UIAlertAction(title: "close", style: .default) { (alert) in
                            print("closed")
                            self.mainTile.alpha = 0
                            self.button1.alpha = 0
                            self.button2.alpha = 0
                            self.button3.alpha = 0
                            self.button4.alpha = 0
                            self.button5.alpha = 0
                            self.button6.alpha = 0
                            self.button7.alpha = 0
                            self.button8.alpha = 0
                            self.button9.alpha = 0
                            self.StartGame.alpha = 1
                        }
                        highAlert.addAction(close)
                        self.present(highAlert, animated: true)
                        ref.updateData(["highScore" : finalScore])
                        self.scoreNum = 0
                    } else if  currentScore! == highscore! {
                        let almostAlert = UIAlertController(title: "New High Score", message: finalScore, preferredStyle: .alert)
                        let close = UIAlertAction(title: "close", style: .default) { (alert) in
                            print("closed")
                            self.mainTile.alpha = 0
                            self.button1.alpha = 0
                            self.button2.alpha = 0
                            self.button3.alpha = 0
                            self.button4.alpha = 0
                            self.button5.alpha = 0
                            self.button6.alpha = 0
                            self.button7.alpha = 0
                            self.button8.alpha = 0
                            self.button9.alpha = 0
                            self.StartGame.alpha = 1
                        }
                        almostAlert.addAction(close)
                        self.present(almostAlert, animated: true)
                        ref.updateData(["highScore" : finalScore])
                        self.scoreNum = 0
                    } else if currentScore! < highscore! {
                        self.mainTile.alpha = 0
                        self.button1.alpha = 0
                        self.button2.alpha = 0
                        self.button3.alpha = 0
                        self.button4.alpha = 0
                        self.button5.alpha = 0
                        self.button6.alpha = 0
                        self.button7.alpha = 0
                        self.button8.alpha = 0
                        self.button9.alpha = 0
                        self.StartGame.alpha = 1
                    }
                }
            }
        }
        toggleColors()
        toggleMainColor()
    }
    
    // MARK: - Button Functions
    @IBAction func startGameTouch(_ sender: Any) {
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
        self.StartGame.alpha = 0
        start()
    }
    
    @IBAction func button1Touch(_ sender: Any) {
        var color = button1.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button2Touch(_ sender: Any) {
        var color = button2.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button3Touch(_ sender: Any) {
        var color = button3.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button4Touch(_ sender: Any) {
        var color = button4.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button5Touch(_ sender: Any) {
        var color = button5.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button6Touch(_ sender: Any) {
        var color = button6.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button7Touch(_ sender: Any) {
        var color = button7.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button8Touch(_ sender: Any) {
        var color = button8.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
    }
    
    @IBAction func button9Touch(_ sender: Any) {
        var color = button9.backgroundColor
        var rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleMainColor()
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
        }
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


