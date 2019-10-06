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

    @IBOutlet weak var tile1: UIView!
    @IBOutlet weak var tile2: UIView!
    @IBOutlet weak var tile3: UIView!
    @IBOutlet weak var tile4: UIView!
    @IBOutlet weak var tile5: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    var userUID = ""
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        super.viewDidLoad()
        let db = Firestore.firestore()
        let ref = db.collection("users").document(userUID)
        if userUID == "" {
            let uid = defaults.string(forKey: "uid")
            if uid == nil {
                let alertUser = UIAlertController(title: "Give us a name!", message: "We'll save your score for you!", preferredStyle: .alert)
                alertUser.addTextField()
                let submit = UIAlertAction(title: "Submit", style: .default) { (alert) in
                    let text = alertUser.textFields![0]
                }
                alertUser.addAction(submit)
                present(alertUser, animated: true)
            } else {
                userUID = uid!
                defaults.set(uid, forKey: "uid")
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func playButtonTouch(_ sender: Any) {
    }
}
