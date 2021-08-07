//
//  PersistenceController.swift
//  OurGames
//
//  Created by Dans Multipro on 01/08/21.
//

import CoreData

class PersistenceController {
  
  let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "GameData")
    container.loadPersistentStores { (description, error) in
      if let error = error {
        fatalError("Error: \(error.localizedDescription)")
      }
    }
  }
  
  private func gameMapping(_ game: Game) -> Games {
    let gameData = Games(context: container.viewContext)
    gameData.id = Int32(game.id)
    gameData.name = game.name
    gameData.released = game.released
    gameData.backgroundImage = game.backgroundImage
    gameData.rating = game.rating ?? 0
    gameData.ratingsCount = Int32(game.ratingsCount ?? 0)
    
    return gameData
  }
  
  func getGames() -> [Games] {
    let fetchRequest: NSFetchRequest<Games> = Games.fetchRequest()
    do {
      return try container.viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  func saveGame(_ game: Game, completion: @escaping(_ message: String) -> Void) {
    _ = gameMapping(game)
    
    do {
      try container.viewContext.save()
      completion("Game saved successfully!")
    } catch {
      print("Failed to save game: \(error)")
    }
  }
  
  func deleteGame(_ id: Int, completion: @escaping(_ message: String) -> Void) {
    let fetchRequest: NSFetchRequest<Games> = Games.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == \(id)")
    
    do {
      let results = try container.viewContext.fetch(fetchRequest)
      if results.count > 0 {
        for object in results {
          container.viewContext.delete(object as NSManagedObject)
        }
        completion("Game deleted successfully!")
      }
    } catch {
      print("Delete failed")
    }
  }
  
  func checkGameExist(_ id: Int) -> Bool {
    let fetchRequest: NSFetchRequest<Games> = Games.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "id == \(id)")
    
    do {
      let result = try container.viewContext.fetch(fetchRequest)
      return result.count > 0
    }
    catch {
      return false
    }
  }
}
