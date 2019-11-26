//
//  Level2ViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/16/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import FirebaseFirestore

class Level2ViewController: UIViewController {

    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var plusThree: UILabel!
    @IBOutlet weak var plusThree2: UILabel!
    
    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var MainTile: UIButton!
    @IBOutlet weak var tile1: UIButton!
    @IBOutlet weak var tile2: UIButton!
    @IBOutlet weak var tile3: UIButton!
    @IBOutlet weak var tile4: UIButton!
    @IBOutlet weak var tile5: UIButton!
    @IBOutlet weak var tile6: UIButton!
    @IBOutlet weak var tile7: UIButton!
    @IBOutlet weak var tile8: UIButton!
    @IBOutlet weak var tile9: UIButton!
    @IBOutlet weak var tile10: UIButton!
    @IBOutlet weak var tile11: UIButton!
    @IBOutlet weak var tile12: UIButton!

    
    var plusCount = 0
    var scoreNum = 0
    var timerSecond: Timer = Timer.init()
    var timeCounter = 0
    var userID = ""
    var colors = [UIColor.white, UIColor.black, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.cyan, UIColor.orange, UIColor.gray, UIColor.red, UIColor.brown, UIColor.magenta, UIColor.systemTeal]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        plusThree.alpha = 0
        plusThree2.alpha = 0
        overrideUserInterfaceStyle = .light
        getName()
        super.viewDidLoad()
        formatView()
    }
    
    func getName() {
        let defaults = UserDefaults.standard
        self.userID = defaults.string(forKey: "uid")!
        populateHighScore()
    }
        
    func formatView() {
        MainTile.alpha = 1
        tile1.alpha = 1
        tile2.alpha = 1
        tile3.alpha = 1
        tile4.alpha = 1
        tile5.alpha = 1
        tile6.alpha = 1
        tile7.alpha = 1
        tile8.alpha = 1
        tile9.alpha = 1
        tile10.alpha = 1
        tile11.alpha = 1
        tile12.alpha = 1
        self.timer.alpha = 1
    }
    
    // MARK: - Start
    func start() {
        timeManage()
        toggleColors()
    }
    
    func populateHighScore() {
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userID)
        ref.getDocument { (snap, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                let score = snap?.data()!["highScore"] as! String
                self.highscore.text = score
                self.start()
            }
        }
    }

        // MARK: Time Manager
    func timeManage() {
        timeCounter = 30
        timerSecond = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timerSecond in
            self.updateTimer()
            if self.scoreNum >= 200 { // MARK: Score Threshold
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = storyboard.instantiateViewController(identifier: "levelMarker") as! levelMarkerViewController
                newVC.modalPresentationStyle = .fullScreen
                newVC.nxtLevel = 3
                newVC.score = self.currentScoreLabel.text!
                newVC.scoreNum = self.scoreNum
                self.present(newVC, animated: true)
                timerSecond.invalidate()
            }
        }
    }
    
    func updateTimer(){
        if timeCounter > 0 {
            timeCounter -= 1
            self.timer.text = String(self.timeCounter)
        }
        
        if timeCounter == 0 {
            endGame()
        }
    }
    
    // MARK: - Toggle Tile colors
    //Call self.viewDidLoad() after calling this function
    
    func toggleColors() {
        var count = 0
        let tiles = [tile1, tile2, tile3, tile4, tile5, tile6, tile7, tile8, tile9, tile10, tile11, tile12]
        let randomColor = colors.shuffled()
        
        for button in tiles{
            let color = randomColor[count]
            button?.backgroundColor = color
            count += 1
        }
        
        let randomColorMain = colors.randomElement()
        self.MainTile.backgroundColor = randomColorMain
        count = 0
        
        //Add to counter
        plusCount += 1
        
        //When counter equals 5, add two second to timer
        if plusCount == 10 {
            timeCounter += 6
            plusCount = 0
            UIView.animate(withDuration: 1) {
                self.plusThree2.alpha = 1
                self.plusThree.alpha = 1
                self.plusThree2.alpha = 0
                self.plusThree.alpha = 0
            }
        }
    }
    
    // MARK: Button Outlets
    @IBAction func tile1Clicked(_ sender: Any) {
        let color = tile1.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile2Clicked(_ sender: Any) {
        let color = tile2.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile3Clicked(_ sender: Any) {
        let color = tile3.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile4Clicked(_ sender: Any) {
        let color = tile4.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile5Clicked(_ sender: Any) {
        let color = tile5.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile6Clicked(_ sender: Any) {
        let color = tile6.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile7Clicked(_ sender: Any) {
        let color = tile7.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile8Clicked(_ sender: Any) {
        let color = tile8.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile9Clicked(_ sender: Any) {
        let color = tile9.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile10Clicked(_ sender: Any) {
        let color = tile10.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile11Clicked(_ sender: Any) {
        let color = tile11.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    @IBAction func tile12Clicked(_ sender: Any) {
        let color = tile12.backgroundColor
        let rightColor = MainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScoreLabel.text = String(scoreNum)
        } else {
            endGame()
        }
    }
    
    // MARK: End Game
    func endGame() {
        timerSecond.invalidate()
        
        self.MainTile.alpha = 0
        self.tile1.alpha = 0
        self.tile2.alpha = 0
        self.tile3.alpha = 0
        self.tile4.alpha = 0
        self.tile5.alpha = 0
        self.tile6.alpha = 0
        self.tile7.alpha = 0
        self.tile8.alpha = 0
        self.tile9.alpha = 0
        self.tile10.alpha = 0
        self.tile11.alpha = 0
        self.tile12.alpha = 0

        let finalScore = self.currentScoreLabel.text!
        self.scoreNum = Int(finalScore)!
        self.currentScoreLabel.text = "0"
        
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
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let newVC = storyboard.instantiateViewController(identifier: "mainGame")
                        newVC.modalPresentationStyle = .fullScreen
                        self.present(newVC, animated: true)
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
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let newVC = storyboard.instantiateViewController(identifier: "mainGame")
                        newVC.modalPresentationStyle = .fullScreen
                        self.present(newVC, animated: true)
                    }
                    
                    almostAlert.addAction(close)
                    self.present(almostAlert, animated: true)
                    ref.updateData(["highScore" : finalScore])
                    self.scoreNum = 0
                } else if currentScore! < highscore! {
                    let nopeAlert = UIAlertController(title: "Not Quite", message: finalScore, preferredStyle: .alert)
                    let close = UIAlertAction(title: "close", style: .default) { (alert) in
                        print("closed")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let newVC = storyboard.instantiateViewController(identifier: "mainGame")
                        newVC.modalPresentationStyle = .fullScreen
                        self.present(newVC, animated: true)
                    }
                    nopeAlert.addAction(close)
                    self.present(nopeAlert, animated: true)
                }
            }
        }
    }
}
