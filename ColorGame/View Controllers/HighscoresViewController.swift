//
//  HighscoresViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/6/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit
import FirebaseFirestore
import GoogleMobileAds

class HighscoresViewController: UIViewController {

    @IBOutlet weak var Highscores: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var doc: [QueryDocumentSnapshot]? = nil
    var docCount = 0
    var userID = ""
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        //Version Compatibility stuff
        overrideUserInterfaceStyle = .light
        
        //Init
        getData()
        super.viewDidLoad()
        
        //Ad Stuff
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-6584468447012164/2891508609"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    //more ad stuff
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
    
    //Retrieves user data as well as
    func getData() {
        let db = Firestore.firestore()
        let ref = db.collection("users").order(by: "highscoreINT", descending: true).limit(to: 15)
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
    
    // Override internal function to add these lines of code before
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC = segue.destination as? gameViewController
        newVC!.userID = userID
        newVC?.modalPresentationStyle = .fullScreen
        self.present(newVC!, animated: true)
    }
}

// MARK: - Extension
// gives the view controller class these inherited attributes(Table
// View delegate) allows for the class to have the functionality to take
// data and populate cells

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
