//
//  ContentHomeTableViewCell.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit

class ContentHomeTableViewCell: UITableViewCell  {

    weak var itemFilm: Film!
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var collectGeners: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSumary: UILabel!
    
    func setupByContent(by item: Film) {
        self.imgContent.cacheImage(urlString: WebService.urlImage + item.poster_path!)
        if (item.title == nil) {
            self.lblTitle.text = item.name
        }else{
            self.lblTitle.text = item.title
        }
        self.lblDate.text = Date.getFormattedDate(string:item.release_date ?? "2001-10-2")
        self.lblSumary.text = item.overview
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectGeners.delegate = dataSourceDelegate
        collectGeners.dataSource = dataSourceDelegate
        collectGeners.tag = row
        collectGeners.setContentOffset(collectGeners.contentOffset, animated:false) 
        collectGeners.reloadData()
    }
    
}


