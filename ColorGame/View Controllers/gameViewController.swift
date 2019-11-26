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
    
    // MARK: - Class Vars
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var mainTile: UIButton!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var StartGame: UIButton!
    @IBOutlet weak var timerUI: UILabel!
    
    @IBOutlet weak var bonusTimeNotif2: UILabel!
    @IBOutlet weak var bonusTimeNotif: UILabel!
    
    var plusCount = 0
    var timeCounter = 0
    var userID = ""
    var scoreNum = 0
    var timerSecond: Timer = Timer.init()
    
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
        bonusTimeNotif.alpha = 0
        bonusTimeNotif2.alpha = 0
        overrideUserInterfaceStyle = .light
        getName()
        super.viewDidLoad()
        formatView()
    }

    func populateHighScore() {
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userID)
        ref.getDocument { (snap, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                let score = snap?.data()!["highScore"] as! String
                self.highScoreLabel.text = score
            }
        }
    }
    
    func getName() {
        let defaults = UserDefaults.standard
        self.userID = defaults.string(forKey: "uid")!
        populateHighScore()
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
        bannerView.adUnitID = "ca-app-pub-6584468447012164/3823460675"
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
        timeManage()
        toggleColors()
    }
    
    func updateTimer(){
        //example functionality
        if timeCounter > 0 {
            timeCounter -= 1
            self.timerUI.text = String(self.timeCounter)
        }
        
        if timeCounter == 0 {
            endGame()
        }
    }

    // MARK: Time Manager
    func timeManage() {
        timeCounter = 30
        timerSecond = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timerSecond in
            self.updateTimer()
            if self.scoreNum >= 50 { // MARK: Score Threshold
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = storyboard.instantiateViewController(identifier: "levelMarker") as! levelMarkerViewController
                newVC.modalPresentationStyle = .fullScreen
                newVC.nxtLevel = 2
                newVC.score = self.score.text!
                newVC.scoreNum = self.scoreNum
                self.present(newVC, animated: true)
                timerSecond.invalidate()
            }
        }
    }
    
    // MARK: End Game
    func endGame() {
        timerSecond.invalidate()
        
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
        let finalScore = self.score.text!
        self.scoreNum = Int(finalScore)!
        self.score.text = "0"
        let db = Firestore.firestore()
        let ref = db.collection("users").document(self.userID)
        ref.getDocument { (snap, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                let highscoreString = snap?.data()!["highScore"] as! String
                let highscore = Int(highscoreString)
                let currentScore = Int(finalScore)
                
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
                        self.timerUI.alpha = 0
                        self.StartGame.alpha = 1
                        self.self.populateHighScore()
                        self.highScoreLabel.setNeedsDisplay()
                    }
                    highAlert.addAction(close)
                    self.present(highAlert, animated: true)
                    ref.updateData(["highScore" : finalScore])
                    ref.updateData(["highscoreINT" : Int(finalScore)])
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
                        self.timerUI.alpha = 0
                        self.StartGame.alpha = 1
                    }
                    almostAlert.addAction(close)
                    self.present(almostAlert, animated: true)
                    ref.updateData(["highScore" : finalScore])
                    self.scoreNum = 0
                } else if currentScore! < highscore! {
                    let nopeAlert = UIAlertController(title: "Not Quite", message: finalScore, preferredStyle: .alert)
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
                        self.timerUI.alpha = 0
                        self.StartGame.alpha = 1
                    }
                    nopeAlert.addAction(close)
                    self.present(nopeAlert, animated: true)
                }
            }
        }
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
        self.timerUI.alpha = 1
        self.StartGame.alpha = 0
        start()
    }
    
    @IBAction func button1Touch(_ sender: Any) {
        let color = button1.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button2Touch(_ sender: Any) {
        let color = button2.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button3Touch(_ sender: Any) {
        let color = button3.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button4Touch(_ sender: Any) {
        let color = button4.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button5Touch(_ sender: Any) {
        let color = button5.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button6Touch(_ sender: Any) {
        let color = button6.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button7Touch(_ sender: Any) {
        let color = button7.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button8Touch(_ sender: Any) {
        let color = button8.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func button9Touch(_ sender: Any) {
        let color = button9.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            score.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    
    
    // MARK: - Toggle Tile colors
    //Call self.viewDidLoad() after calling this function
    
    func toggleColors() {
        var count = 0
        let tiles = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
        let randomColor = colors.shuffled()
        
        for button in tiles{
            let color = randomColor[count]
            button?.backgroundColor = color
            count += 1
        }
        
        let randomColorMain = colors.randomElement()
        self.mainTile.backgroundColor = randomColorMain
        count = 0
        
        //Add to counter
        plusCount += 1
        
        //When counter equals 5, add two second to timer
        if plusCount == 10 {
            timeCounter += 3
            plusCount = 0
            UIView.animate(withDuration: 1) {
                self.bonusTimeNotif.alpha = 1
                self.bonusTimeNotif2.alpha = 1
                self.bonusTimeNotif.alpha = 0
                self.bonusTimeNotif2.alpha = 0
            }
        }
    }
  
    // MARK: - Segue Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backMenu" {
            timeCounter = 0
            scoreNum = 0
            timerSecond.invalidate()
            let menuVC = segue.destination as? MenuViewController
            menuVC!.userUID = userID
            menuVC!.modalPresentationStyle = .fullScreen
            self.present(menuVC!, animated: true)
        } else if segue.identifier == "highScoreSegue" {
            timeCounter = 0
            scoreNum = 0
            timerSecond.invalidate()
            let highScoreVC = segue.destination as? HighscoresViewController
            highScoreVC!.modalPresentationStyle = .fullScreen
            highScoreVC!.userID = userID
            self.present(highScoreVC!, animated: true)
        }
    }
}


