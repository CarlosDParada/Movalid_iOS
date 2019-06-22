//
//  ContentHomeTableViewCell.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class ContentHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var collectGeners: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSumary: UILabel!
    
    func setupByContent(by item: Film , imgLoad:UIImage) {
        self.imgContent.image = imgLoad
        self.lblTitle.text = item.title
        self.lblDate.text = item.release_date
        self.lblSumary.text = item.overview
        
    }

}
