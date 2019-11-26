//
//  MenuViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/6/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MenuViewController: UIViewController {
    
    // filtered words from name
    private var inputFilter = ["fuck","pussy","shit","crap"]
    
    @IBOutlet weak var tile1: UIView!
    @IBOutlet weak var tile2: UIView!
    @IBOutlet weak var tile3: UIView!
    @IBOutlet weak var tile4: UIView!
    @IBOutlet weak var tile5: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    var userUID = ""
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        tile1.alpha = 0
        tile2.alpha = 0
        tile3.alpha = 0
        tile4.alpha = 0
        tile5.alpha = 0
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(flashTiles)), userInfo: nil, repeats: true)
        let defaults = UserDefaults.standard
        userUID = defaults.string(forKey: "uid") ?? ""
        super.viewDidLoad()
        flashTiles()
        // Do any additional setup after loading the view.
    }
    
    //  MARK: - Tile Animation
    
    @objc func flashTiles() {
        var tiles = [tile1, tile2, tile3, tile4, tile5]
        if tile1.alpha == 1 {
            if let idx = tiles.firstIndex(of: tile1){
                tiles.remove(at: idx)
            }
        }
        if tile2.alpha == 1 {
            if let idx = tiles.firstIndex(of: tile2){
                tiles.remove(at: idx)
            }
        }
        if tile3.alpha == 1 {
            if let idx = tiles.firstIndex(of: tile3){
                tiles.remove(at: idx)
            }
        }
        if tile4.alpha == 1 {
            if let idx = tiles.firstIndex(of: tile4){
                tiles.remove(at: idx)
            }
        }
        if tile5.alpha == 1 {
            if let idx = tiles.firstIndex(of: tile5){
                tiles.remove(at: idx)
            }
        }
        var tilesShuffled = tiles.shuffled()
        var tile = tilesShuffled.randomElement()
        tile??.alpha = 1
        if tile1.alpha == 1, tile2.alpha == 1, tile3.alpha == 1, tile4.alpha == 1, tile5.alpha == 1 {
            let timer2 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                self.tile1.alpha = 0
                self.tile2.alpha = 0
                self.tile3.alpha = 0
                self.tile4.alpha = 0
                self.tile5.alpha = 0
            }
        }
    }
    
    // MARK: - Prompt Phone
    func promptAnswer(completion: @escaping () -> ()) {
        let alertUser = UIAlertController(title: "Give us a name!", message: "We'll save your score for you!", preferredStyle: .alert)
        alertUser.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [unowned alertUser] _ in
            let text = alertUser.textFields![0].text
            let db = Firestore.firestore()
            let ref = db.collection("users").addDocument(data: ["name" : text, "highScore" : "0", "highscoreINT" : 0 as Int])
            let docID = ref.documentID
            self.userUID = docID 
            completion()
        }
        alertUser.addAction(submit)
        present(alertUser, animated: true)
    }
    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "play" {
            //on click of play button, prompt user for name if doesnt already exist.
            let db = Firestore.firestore()
            let defaults = UserDefaults.standard
            let newVC = segue.destination as? gameViewController
            newVC!.modalPresentationStyle = .fullScreen
            if userUID == "" {
                let uid = defaults.string(forKey: "uid")
                if uid == nil {
                    promptAnswer {
                        let defaults = UserDefaults.standard
                        defaults.set(self.userUID, forKey: "uid")
                        self.present(newVC!, animated: true)
                    }
                } else {
                    userUID = uid!
                    defaults.set(uid, forKey: "uid")
                    newVC!.modalPresentationStyle = .fullScreen
                    self.present(newVC!, animated: true)
                }
            }
        } 
    }
}
