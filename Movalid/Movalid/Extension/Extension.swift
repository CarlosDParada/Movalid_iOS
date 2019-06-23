//
//  Color.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
extension UIColor {
    static let tuyaLightGray = UIColor(red:  220.0/255.0,
                                       green:220/255.0 ,
                                       blue: 220.0/255.0 ,
                                       alpha:1.00)
    static let backCEnable = UIColor(red: 0/255.0,
                                     green: 0/255.0,
                                     blue: 0/255.0, alpha: 0)
    static var borderColorBtn = UIColor(red: 0/255.0,
                                        green: 122.0/255.0,
                                        blue: 1.0, alpha: 0)
}


extension UICollectionViewCell{
    static let homeCollectIdentifier = "homeCollentItemCell"
    static let detailCollectIdentifier = "detailCollentItemCel"
}

extension UITableViewCell{
    static let homeCellIdentifier = "homeItemCell"
    static let searchCellIdentifier = "searchItemCell"
}


//Extension used for image cache
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.autoresizingMask = [.flexibleTopMargin,.flexibleHeight,.flexibleWidth]
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}
