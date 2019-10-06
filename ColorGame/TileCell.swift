//
//  TileCell.swift
//  ColorGame
//
//  Created by Charles Oxendine on 10/3/19.
//  Copyright © 2019 Charles Oxendine. All rights reserved.
//

import Foundation
import UIKit

struct TileCell: UICollectionViewCell {
    
    var color = ""
    
    mutating func setCell(hex: String){
        self.color = hex
    }
}
