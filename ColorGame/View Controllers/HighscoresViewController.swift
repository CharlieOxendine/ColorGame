//
//  HighscoresViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/6/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HighscoresViewController: UIViewController {

    @IBOutlet weak var Highscores: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var doc: [QueryDocumentSnapshot]? = nil
    var docCount = 0
    var userID = ""
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        getData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getData() {
        let db = Firestore.firestore()
        let ref = db.collection("users").order(by: "highscoreINT", descending: true).limit(to: 10)
        ref.getDocuments { (snap, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                self.doc = snap!.documents
                self.docCount = snap!.count
                self.Highscores.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC = segue.destination as? gameViewController
        newVC!.userID = userID
        newVC?.modalPresentationStyle = .fullScreen
        self.present(newVC!, animated: true)
    }
}

extension HighscoresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = Highscores.dequeueReusableCell(withIdentifier: "scores")
        var name = doc![indexPath.row].data()["name"] as! String
        var score = doc![indexPath.row].data()["highScore"] as! String
        //Name(left)
        cell?.textLabel?.text = name
        //Score(right)
        cell?.detailTextLabel?.text = score
        return cell!
    }
}
