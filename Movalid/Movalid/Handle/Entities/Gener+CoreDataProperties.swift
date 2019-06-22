//
//  Gener+CoreDataProperties.swift
//  
//
//  Created by Carlos Parada on 6/22/19.
//
//

import Foundation
import CoreData


extension Gener {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gener> {
        return NSFetchRequest<Gener>(entityName: "Gener")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

    func update(with genLcl : StandarModel) throws{
        guard let idLocal =  Int32(Int(genLcl.id)) as? Int32 ,
            let nameLocal = genLcl.name
            else{
                 throw NSError(domain: "", code: 100, userInfo: nil)
        }
        
        self.id = idLocal
        self.name  = nameLocal
    }
}
