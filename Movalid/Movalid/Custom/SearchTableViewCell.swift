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
        self.lblTitle.text = item.title
        self.lblDate.text = Date.getFormattedDate(string:item.release_date ?? "2001-10-2")
        let urlimg = "\(WebService.urlImageSearch)\(item.poster_path ?? "/4Lwmsz1qQ0fNBLf5KBBrlzsozee.jpg")"
        self.imgFilm.cacheImage(urlString: urlimg)
    }
    
}
