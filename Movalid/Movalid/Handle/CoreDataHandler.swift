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
    
    
    /// Save All geners in CoreData
    ///
    /// - Parameter singleGen: Model of Geners
    static func saveGeners(singleGen : StandarModel)  {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let generSmp = Gener(context: managedContext)
        let int32: Int32 = Int32(Int(singleGen.id))
        generSmp.id = int32
        generSmp.name = singleGen.name
        managedContext.insert(generSmp)
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    /// Save Movies/Series in Coredata, dependen for parameters
    ///
    /// - Parameters:
    ///   - singleFilm: Object General
    ///   - category: can Top/Popular/Upcomming
    ///   - type: movie/tv
    static func saveFilm(singleFilm : Film , category:String , type:String)  {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let filmSmpl = Movalid(context: managedContext)
        filmSmpl.vote_count = Int32(Int(singleFilm.vote_count!))
        filmSmpl.id = Int32(Int(singleFilm.id!))
        filmSmpl.video = singleFilm.video ?? false
        filmSmpl.title = singleFilm.title ?? ""
        if (singleFilm.title == nil) {
            filmSmpl.title = singleFilm.name ?? ""
            filmSmpl.name = singleFilm.name ?? ""
        }
        filmSmpl.type = type
        filmSmpl.poster_path = singleFilm.poster_path  ?? ""
        filmSmpl.original_language = singleFilm.original_language  ?? ""
        filmSmpl.original_title = singleFilm.original_title  ?? ""
        filmSmpl.genre_ids = singleFilm.genre_ids! as [NSNumber]
        filmSmpl.backdrop_path = singleFilm.backdrop_path  ?? ""
        filmSmpl.overview = singleFilm.overview
        filmSmpl.release_date = singleFilm.release_date
        filmSmpl.category = category
        managedContext.insert(filmSmpl)
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    
    
    
    /// Return Geners on CoreData in Array Objects
    ///
    /// - Returns: Array StandarModel of Generes
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
    
    
    /// Get Movie/Serie in Array the Codeable Objects
    ///
    /// - Parameters:
    ///   - category: search in three forms
    ///   - type: movie or tv
    /// - Returns: Array with Object by parameters
    static func getAllMovalid(by category: String, type : String) -> [Film]{
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        var arrayGeners : [Film] = []
        do {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Movalid")
            
            let typeKeyPredicate = NSPredicate(format: "type contains[c] %@", type )
            let categoryKeyPredicate = NSPredicate(format: "category contains[c] %@", category)
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [typeKeyPredicate, categoryKeyPredicate])
            fetchRequest.predicate = andPredicate
            
            let filmsDB = try context.fetch(fetchRequest) as! [Movalid]
            
            for data in filmsDB as [NSManagedObject] {
                let filmLcl : Film = Film.init(by: data as! Movalid , category: category)
                arrayGeners.append(filmLcl)
            }
        } catch {
            print("Failed")
        }
        return arrayGeners
    }
    
    /// Method for search Movie/Series by category and letter in Title
    ///
    /// - Parameters:
    ///   - category:
    ///   - string: can Top/Popular/Upcomming
    /// - Returns: Array with Object Film by parameters
    static func getAllMovalid(by category: String, string:String) -> [Film]{
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        
        var arrayGeners : [Film] = []
        do {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Movalid")
            
            let titleKeyPredicate = NSPredicate(format: "title contains[c] %@", string )
            let categoryKeyPredicate = NSPredicate(format: "category contains[c] %@", category)
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [titleKeyPredicate, categoryKeyPredicate])
            fetchRequest.predicate = andPredicate
            
            let filmsDB = try context.fetch(fetchRequest) as! [Movalid]
            
            for data in filmsDB as [NSManagedObject] {
                let filmLcl : Film = Film.init(by: data as! Movalid , category: category)
                arrayGeners.append(filmLcl)
            }
            
        } catch {
            print("Failed")
        }
        return arrayGeners
    }
    
    
    /// Search and return geners name by id
    ///
    /// - Parameter byId: id of generes inside the Object Film
    /// - Returns: array of geners
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
    static func deleteMovalid(by type:String, category:String ) {
        deleteData(entity: "Movalid" ,category: category, type:type)
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
    /// YOu can delete Data in CoreData with this has some parameters
    ///
    /// - Parameters:
    ///   - entity: is de CoreData Objects
    ///   - category: search in three forms
    ///   - type: movie or tv
    static func deleteData(entity : String , category: String, type:String) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let typeKeyPredicate = NSPredicate(format: "type contains[c] %@", type )
        let categoryKeyPredicate = NSPredicate(format: "category contains[c] %@", category)
        
        fetchRequest.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [typeKeyPredicate, categoryKeyPredicate])
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
