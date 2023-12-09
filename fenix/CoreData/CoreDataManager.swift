//
//  CoreDataManager.swift
//  fenix
//
//  Created by Ismail Tever on 3.12.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    //MARK: - Properties
    static let shared = CoreDataManager()
    
    //MARK: - Functions
    
    func fetchAllMovieItems() -> [MovieItems] {
        var coreDataItems = [MovieItems]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MovieItems>(entityName: "MovieItems")
        
        do {
            coreDataItems = try managedObjectContext!.fetch(fetchRequest)
        } catch {
            print("Fetching from Core Data failed: \(error)")
        }
        return coreDataItems
    }
    
    func saveMovieToCoreData(data: Movie?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "MovieItems", in: managedObjectContext!),
           let taskItem = NSManagedObject(entity: entity, insertInto: managedObjectContext!) as? MovieItems {
            
            taskItem.title = data?.title
            taskItem.backdropPath = data?.backdropPath
            taskItem.overview = data?.overview
            taskItem.posterPath = data?.posterPath
            taskItem.voteAverage = data?.voteAverage ?? 1.1
            taskItem.releaseDate = data?.releaseDate
            if let movieID = data?.id {
                taskItem.id = Int32(movieID)
            }
            do {
                try managedObjectContext?.save()
                print("Saved to Core Data")
            } catch let error {
                print("Saving to Core Data failed: \(error.localizedDescription)")
            }
        }
    }
    
    func isMovieSaved(id: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("AppDelegate not found")
            return false
        }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MovieItems>(entityName: "MovieItems")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            return result.count > 0
        } catch {
            print("Error checking if movie is saved: \(error)")
            return false
        }
    }
    
    func removeMovieItemFromCoreData(id: Int) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MovieItems>(entityName: "MovieItems")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let result = try managedObjectContext?.fetch(fetchRequest).first {
                managedObjectContext?.delete(result)
                try managedObjectContext?.save()
                print("Removed from Core Data")
            } else {
                print("Movie not found in Core Data")
            }
        } catch let error {
            print("Removing from Core Data failed: \(error.localizedDescription)")
        }
    }
    
    func deleteAllCoreDataObjects(context: NSManagedObjectContext) {
        do {
            let fetchRequest = NSFetchRequest<MovieItems>(entityName: "MovieItems")
            let objects = try context.fetch(fetchRequest)
            _ = objects.map({context.delete($0)})
            try context.save()
        } catch {
            print("Deleting error: \(error)")
        }
    }
}


