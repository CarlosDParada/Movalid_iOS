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
    
    static var lightBlue = UIColor.init(red: 91.0/255.0, green: 121.0/255.0, blue: 245.0/255.0, alpha: 1)
    
      static var backgroundColor = UIColor.init(red: 29.0/255.0, green: 29.0/255.0, blue: 39.0/255.0, alpha: 1)
}


extension UICollectionViewCell{
    static let homeCollectIdentifier = "homeCollentItemCell"
    static let detailCollectIdentifier = "detailCollentItemCel"
}

extension UITableViewCell{
    static let homeCellIdentifier = "homeItemCell"
    static let searchCellIdentifier = "searchItemCell"
    static let emptyCell = "emptyCell"
}


//Extension used for image cache
//let imageCache = NSCache<AnyObject, AnyObject>()
//extension UIImageView {
//    func cacheImage(urlString: String){
//        let url = URL(string: urlString)
//
//        image = nil
//
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
//
//        self.autoresizingMask = [.flexibleTopMargin,.flexibleHeight,.flexibleWidth]
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.contentMode = .scaleAspectFill
//
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url!) {
//            data, response, error in
//            if data != nil {
//                DispatchQueue.main.async {
//                    let imageToCache = UIImage(data: data!)
//                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
//                    self.image = imageToCache
//                }
//            }
//            }.resume()
//    }
//}

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        print(">> \(urlString)")
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
}

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func mainFontRegular(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Symbol", size: size)
    }
}

extension UIImage {
    private static func customImage(name: String) -> UIImage {
        let image = UIImage(named: name)
        assert(image != nil, "Can't load font: \(name)")
        return image ?? UIImage.init()
    }
    
    static func navLogo () -> UIImage {
        return customImage(name: "logo-top")
    }
    static func navSearchIcon () -> UIImage {
        return customImage(name: "search")
    }
}
extension Date {
    static func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        var temData = string
        if(temData == ""){temData = "2010-08-12"}
        let date: Date? = dateFormatterGet.date(from: temData)
//        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}
