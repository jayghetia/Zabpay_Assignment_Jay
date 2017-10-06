//
//  CoreDataManager.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager {
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

+ (CoreDataManager *)sharedInstance {
    
    static CoreDataManager *objCoreDataManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        objCoreDataManager = [[CoreDataManager alloc] init];
    });
    
    return objCoreDataManager;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    
    NSLog(@"storeURL URL PATH::: %@",storeURL);
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        
        NSMutableDictionary *dictErrorDesc = [NSMutableDictionary dictionary];
        dictErrorDesc[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dictErrorDesc[NSLocalizedFailureReasonErrorKey] = failureReason;
        dictErrorDesc[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dictErrorDesc];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    
    managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    [managedObjectContext performBlockAndWait:^{
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }];
    
    return managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    
    if (self.managedObjectContext) {
        
        [self.managedObjectContext performBlockAndWait:^{
            NSError *error = nil;
            
            if (self.managedObjectContext.hasChanges) {
                
                BOOL saved = [self.managedObjectContext save:&error];
                
                if (!saved) {
                    NSLog(@"Could not save master context due to %@", error);
                }
            }
        }];
    }
}

- (NSURL *)applicationDocumentsDirectory {
    
    NSLog(@"DB PATH::: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Insert Data

- (void)insertArtistListInDB:(NSArray *)arrArtists {
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = self.managedObjectContext;
    
    [context performBlockAndWait:^{
        [Artist insertRows:arrArtists inContext:context];
        [self saveContext];
    }];
}

- (NSArray *)getArtistListFromDB:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Artist class])];
    NSError *error = nil;
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (results.count > 0) {
        return results;
    }
    
    return nil;
}

@end

