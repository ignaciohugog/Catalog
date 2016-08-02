# Catalog

This is a Core Data basic app, that shows a list of all articles. 
They are displayed in a tablew view and in a collection view and all the articles are fetched from a web service that returns
them as JSON objects. 
The web service used was https://market.mashape.com/devru/instructables. This is unofficial API of Instructables.com.

##Dependencies
**AFNetworking:** https://github.com/AFNetworking/AFNetworking <br /><br />
**UICollectionView+NSFetchedResultsController:** https://github.com/radianttap/UICollectionView-NSFetchedResultsController

##Installation
This project use CocoaPods to manage dependecies, you must install it before proceeding.<br/>
CocoaPods installation: https://guides.cocoapods.org/using/getting-started.html#toc_3. <br/>
Once installed run, into the project directory, the command **pod install**. <br/>

##Architecture
The architecture was based on a basic Model View Controller (MVC).
The main thing was to put Objects into Core Data store. For this I create an **Importer** and a **UpdateArticleEntities**
objects. The first one calls the web service and creates or updates objects calling UpdateArticleEntities's find or create method.
Doing this I wrap the logic into a performBlock:, the context makes sure that everything happens on the correct thread.<br/>
<br/>
To import data efficiently I batch up the articles and find all of them at the same time. For this I use a combination of an
IN predicate and sorting to reduce the use of Core Data to a single fetch request regardless of how many IDs, and then it was
just walking the result set.
<br/>
Another important approach used to boost core data performance was to use a **Separate Background Stack** <br/>
To set up a managed object context, we use the following code:<br/>
```objective-c
- (NSManagedObjectContext *)setupManagedObjectContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    managedObjectContext.persistentStoreCoordinator =
            [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError* error;
    [managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
                                                                  configuration:nil 
                                                                            URL:self.storeURL 
                                                                        options:nil 
                                                                          error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    return managedObjectContext;
}
```
Then we call this method twice — once for the main managed object context, and once for the background managed object context:

```objective-c
self.managedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSMainQueueConcurrencyType];
self.backgroundManagedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSPrivateQueueConcurrencyType];
```
