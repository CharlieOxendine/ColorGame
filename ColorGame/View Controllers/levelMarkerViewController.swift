//
//  levelMarkerViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 11/26/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit

class levelMarkerViewController: UIViewController {

    var score = ""
    var scoreNum = 0
    var nxtLevel = 0
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var quote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatView()
    }
    
    func formatView() {
        levelLabel.text = "Level \(nxtLevel)"
        if self.nxtLevel == 3 {
            quote.text = "Don't get confused..."
        } else if self.nxtLevel == 2 {
            quote.text = "Tall Boi"
        }
        
        var VCTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
            if self.nxtLevel == 3 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = storyboard.instantiateViewController(identifier: "thirdLevel") as! Level3ViewController
                newVC.scoreNum = self.scoreNum
                newVC.modalPresentationStyle = .fullScreen
                self.present(newVC, animated: true)
            } else if self.nxtLevel == 2 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newVC = storyboard.instantiateViewController(identifier: "secondLevel") as! Level2ViewController
                newVC.scoreNum = self.scoreNum
                newVC.modalPresentationStyle = .fullScreen
                self.present(newVC, animated: true)
            } else {
                return
            }
        }
    }
    
}
