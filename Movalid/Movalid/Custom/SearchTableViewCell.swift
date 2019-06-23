//
//  SearchTableViewCell.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgFilm: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    func setupByContent(by item: Film) {
        self.imgFilm.cacheImage(urlString: WebService.urlImage + item.poster_path!)
        self.lblTitle.text = item.title
        self.lblDate.text = item.release_date
    }
    
}
