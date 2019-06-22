//
//  Movalid+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/22/19.
//
//

import Foundation
import CoreData


extension Movalid {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movalid> {
        return NSFetchRequest<Movalid>(entityName: "Movalid")
    }

    @NSManaged public var vote_count: Int32
    @NSManaged public var id: Int32
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Int32
    @NSManaged public var title: String?
    @NSManaged public var popularity: Int32
    @NSManaged public var poster_path: String?
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var genre_ids: [Int32]?
    @NSManaged public var backdrop_path: String?
    @NSManaged public var overview: String?
    @NSManaged public var release_date: String?
    @NSManaged public var category: String?

}
