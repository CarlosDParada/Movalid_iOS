//
//  GenersCollectionViewCell.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class GenersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewNormal: UIView!
    
    func setupByContent(by item: Int) {
        lblTitle.layer.cornerRadius = 1
        lblTitle.layer.borderWidth = 1
        lblTitle.layer.borderColor = UIColor.lightBlue.cgColor
        
        self.lblTitle.text = HandlerData.getGenerById(by: item)
    }
}
