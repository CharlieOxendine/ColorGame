//
//  Level3ViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/16/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import FirebaseFirestore

class Level3ViewController: UIViewController {

    @IBOutlet weak var plus3Notif: UILabel!
    @IBOutlet weak var plus3Notif2: UILabel!
    
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var mainTile: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    
    var plusCount = 0
    var scoreNum = 0
    var timerSecond: Timer = Timer.init()
    var timeCounter = 0
    var userID = ""
    var colors = [UIColor.white,
                  UIColor.black,
                  UIColor.blue,
                  UIColor.green,
                  UIColor.yellow,
                  UIColor.cyan,
                  UIColor.orange,
                  UIColor.gray,
                  UIColor.red,
                  UIColor.brown,
                  UIColor.magenta,
                  UIColor.systemTeal,
                  UIColor.systemPink,
                  UIColor.systemIndigo,
                  UIColor.systemPurple,
                  UIColor.darkGray]
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        plus3Notif.alpha = 0
        plus3Notif2.alpha = 0
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
        button10.alpha = 1
        button11.alpha = 1
        button12.alpha = 1
        button13.alpha = 1
        button14.alpha = 1
        button15.alpha = 1
        button16.alpha = 1
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
                self.highScore.text = score
                self.start()
            }
        }
    }

        // MARK: Time Manager
    func timeManage() {
        timeCounter = 30
        timerSecond = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timerSecond in
            self.updateTimer()
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
        let tiles = [button1,
                     button2,
                     button3,
                     button4,
                     button5,
                     button6,
                     button7,
                     button8,
                     button9,
                     button10,
                     button11,
                     button12,
                     button13,
                     button14,
                     button15,
                     button16]
        
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
            timeCounter += 12
            plusCount = 0
            UIView.animate(withDuration: 1) {
                self.plus3Notif.alpha = 1
                self.plus3Notif2.alpha = 1
                self.plus3Notif.alpha = 0
                self.plus3Notif2.alpha = 0
            }
        }
    }
    
    // MARK: Button Outlets
    @IBAction func tile1Clicked(_ sender: Any) {
        let color = button1.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile2Clicked(_ sender: Any) {
        let color = button2.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile3Clicked(_ sender: Any) {
        let color = button3.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile4Clicked(_ sender: Any) {
        let color = button4.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile5Clicked(_ sender: Any) {
        let color = button5.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile6Clicked(_ sender: Any) {
        let color = button6.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile7Clicked(_ sender: Any) {
        let color = button7.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile8Clicked(_ sender: Any) {
        let color = button8.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile9Clicked(_ sender: Any) {
        let color = button9.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile10Click(_ sender: Any) {
        let color = button10.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile11Click(_ sender: Any) {
        let color = button11.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile12Click(_ sender: Any) {
        let color = button12.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile13Clicked(_ sender: Any) {
        let color = button13.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile14Clicked(_ sender: Any) {
        let color = button14.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile15Clicked(_ sender: Any) {
        let color = button15.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
        }
    }
    
    @IBAction func tile16Clicked(_ sender: Any) {
        let color = button16.backgroundColor
        let rightColor = mainTile.backgroundColor
        if color == rightColor {
            toggleColors()
            scoreNum += 1
            currentScore.text = String(scoreNum)
        } else {
            print("WRONG")
            endGame()
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
        self.button10.alpha = 0
        self.button11.alpha = 0
        self.button12.alpha = 0
        self.button13.alpha = 0
        self.button14.alpha = 0
        self.button15.alpha = 0
        self.button16.alpha = 0

        let finalScore = self.currentScore.text!
        self.scoreNum = Int(finalScore)!
        self.currentScore.text = "0"
        
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
