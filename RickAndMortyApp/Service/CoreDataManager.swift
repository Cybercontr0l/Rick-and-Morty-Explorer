import CoreData

// MARK: - CoreDataManager
final class CoreDataManager {
    // MARK: - Singleton
    static let shared = CoreDataManager()

    // MARK: - Initializer
    private init() {}

    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CharacterModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
