//
//  AppDelegate.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    NSPersistentContainer *persistentContainer;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark - Core Data stack

- (NSPersistentContainer *)persistentContainer {
    
    @synchronized (self) {
        
        if (persistentContainer == nil) {
            
            persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreData"];
            
            [persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

