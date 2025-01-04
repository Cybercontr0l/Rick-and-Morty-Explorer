import Foundation
import CoreData

final class FavoriteCharacterService {
    static let shared = FavoriteCharacterService()

    private init() {}

    // MARK: - Core Data Context
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.context
    }

    // MARK: - Fetch Favorites
    func fetchFavorites() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteCharacter")
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Remove Character from Favorites
    func removeCharacterFromFavorites(character: NSManagedObject) {
        context.delete(character)
        saveContext()
    }

    // MARK: - Check if Character is Favorited
    func isFavorited(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteCharacter")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to check if favorited: \(error.localizedDescription)")
            return false
        }
    }

    // MARK: - Toggle Favorite
    func toggleFavorite(for character: RMCharacter, completion: @escaping (Bool) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteCharacter")
        fetchRequest.predicate = NSPredicate(format: "id == %d", character.id)

        do {
            let results = try context.fetch(fetchRequest)
            if let favorite = results.first {
                context.delete(favorite)
                saveContext()
                completion(false)
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "FavoriteCharacter", in: context)!
                let favorite = NSManagedObject(entity: entity, insertInto: context)
                favorite.setValue(character.id, forKey: "id")
                favorite.setValue(character.name, forKey: "name")
                favorite.setValue(character.status, forKey: "status")
                favorite.setValue(character.species, forKey: "species")
                favorite.setValue(character.gender, forKey: "gender")
                favorite.setValue(character.origin.name, forKey: "originName")
                favorite.setValue(character.location.name, forKey: "locationName")
                favorite.setValue(character.image, forKey: "image")
                favorite.setValue(character.created, forKey: "created")
                saveContext()
                completion(true)
            }
            postFavoritesUpdatedNotification()
        } catch {
            print("Failed to toggle favorite: \(error.localizedDescription)")
            completion(false)
        }
    }

    // MARK: - Save Context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }

    // MARK: - Post Favorites Updated Notification
    private func postFavoritesUpdatedNotification() {
        NotificationCenter.default.post(name: .favoritesDidUpdate, object: nil)
    }
}

// MARK: - Notification Name Extension
extension Notification.Name {
    static let favoritesDidUpdate = Notification.Name("favoritesDidUpdate")
}
