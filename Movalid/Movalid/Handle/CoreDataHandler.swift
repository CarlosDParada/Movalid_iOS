//
//  CoreDataHandler.swift
//  Movalid
//
//  Created by Carlos Parada on 6/22/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler : UIViewController{
    static func saveGeners(singleGen : StandarModel)  {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        
        let generSmp = Gener(context: context)
        let int32: Int32 = Int32(Int(singleGen.id))
        generSmp.id = int32
        generSmp.name = singleGen.name
        context.insert(generSmp)
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func getAllGeners() -> [StandarModel]{
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        
        var arrayGeners : [StandarModel] = []
        do {
            let generDB = try context.fetch(Gener.fetchRequest() as NSFetchRequest<Gener>)
            for data in generDB as! [NSManagedObject] {
                let gener : StandarModel = StandarModel.init(
                    id: data.value(forKey: "id") as! Int ,
                    name: data.value(forKey: "name") as! String)
                arrayGeners.append(gener)
            }
        } catch {
            print("Failed")
        }
        return arrayGeners
    }
    
    static func findGeners(byId: Int32) -> [Gener]{
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Gener")
         fetchRequest.predicate = NSPredicate(format: "id == %@", byId)
        var generos : [Any] = []
         do {
            generos = try managedContext.fetch(fetchRequest) }
         catch {
                print("Failed")
        }
        return generos as! [Gener]
    }
    
    static func deleteGeners() {
        deleteData(entity: "Gener")
    }
    
    static func deleteData(entity : String) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
