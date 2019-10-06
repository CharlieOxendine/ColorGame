//
//  HighscoresViewController.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/6/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import UIKit

class HighscoresViewController: UIViewController {

    @IBOutlet weak var Highscores: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
