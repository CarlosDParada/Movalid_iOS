//
//  GenersCollectionViewCell.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class GenersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnGener: UIButton!
    
    func setupByContent(by item: Int) {
        self.btnGener.setTitle(HandlerData.getGenerById(by: item), for: .normal)
    }
}
