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
    
    static func saveFilm(singleFilm : Film , category:String , type:String)  {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let filmSmpl = Movalid(context: managedContext)
        filmSmpl.vote_count = Int32(Int(singleFilm.vote_count!))
        filmSmpl.id = Int32(Int(singleFilm.id!))
        filmSmpl.video = singleFilm.video ?? false
        filmSmpl.title = singleFilm.title ?? ""
        if (filmSmpl.title == nil) {
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
    
    
    static func getAllMovalid(by category: String, type : String) -> [Film]{
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        var arrayGeners : [Film] = []
        do {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Film")
            fetchRequest.predicate = NSPredicate(format: "type contains[c] %@", type )
            fetchRequest.predicate = NSPredicate(format: "category contains[c] %@", category)
            let filmsDB = try context.fetch(Movalid.fetchRequest() as NSFetchRequest<Movalid>)
            for data in filmsDB as [NSManagedObject] {
                let filmLcl : Film = Film.init(by: data as! Movalid , category: category)
                arrayGeners.append(filmLcl)
            }
        } catch {
            print("Failed")
        }
        return arrayGeners
    }
    
    static func getAllMovalid(by category: String, string:String) -> [Film]{
        
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        
        var arrayGeners : [Film] = []
        do {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Film")
            fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", string)
            let filmsDB = try context.fetch(fetchRequest as! NSFetchRequest<Movalid>)
            for data in filmsDB as [NSManagedObject] {
                let filmLcl : Film = Film.init(by: data as! Movalid , category: category)
                arrayGeners.append(filmLcl)
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
    static func deleteMovalid(by category:String) {
        deleteData(entity: "Movalid" ,category: category)
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
    static func deleteData(entity : String , category: String) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
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
