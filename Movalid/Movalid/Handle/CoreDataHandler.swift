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
        
        let generos = try context.fetch(fetchRequest)
        return generos
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
                dataController.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    static func updateGener(by newGener: StandarModel){
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Gener")
        fetchRequest.predicate = NSPredicate(format: "id == %@", newGener.id)
        
        do
        {
            let generDBCore = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = generDBCore[0] as! NSManagedObject
            objectUpdate.setValue(newGener.id, forKey: "id")
            objectUpdate.setValue(newGener.name, forKey: "name")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
    }
    /*
    private func syncGeners(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Gener")
        request.predicate = NSPredicate(format: "id in %@", "1")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
            
            if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                    into: [self.persistentContainer.viewContext])
            }
        } catch {
            print("Error: \(error)\nCould not batch delete existing records.")
            
        }
    }
    
    private func syncFilms(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
            let episodeIds = jsonDictionary.map { $0["episode_id"] as? Int }.compactMap { $0 }
            matchingEpisodeRequest.predicate = NSPredicate(format: "episodeId in %@", argumentArray: [episodeIds])
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            // Create new records.
            for filmDictionary in jsonDictionary {
                
                guard let film = NSEntityDescription.insertNewObject(forEntityName: "Film", into: taskContext) as? Film else {
                    print("Error: Failed to create a new Film object!")
                    return
                }
                
                do {
                    try film.update(with: filmDictionary)
                } catch {
                    print("Error: \(error)\nThe quake object will be deleted.")
                    taskContext.delete(film)
                }
            }
            
            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
            }
            successfull = true
        }
        return successfull
    }
    */
}
