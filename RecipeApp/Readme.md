#  <#Recipe App#>
- Coredata is Object graph Management and Persistence framework in macos and iOS sdks
- That means Core Data can store and retrieve data, but it isn’t a relational database like MySQL or SQLite. Although it can use SQLite as the data store behind the scenes, you don’t think about Core Data in terms of tables and rows and primary keys.
- CoreData Stack : A ManagedObject Model , An NSPersistenceStoreCoordinator , An NSMAnagedObjectContext
- A ManagedObject Model : which defines model objects , called entities , and their relationships with other entities . Think of it as database Scheme . We will use NSManagedObjectModel class to access your managed object model in the code
- An  NSPerisitenceStoreCoordinator , which manages the actual database 
- An NSAnagedObjectContext , which is an in - memory scratchpad that lets you create , edit , delete or retrieve , entities . Usually we will work with the managed object context when interacting with coredata 
- s
