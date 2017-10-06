//
//  CoreDataManager.h
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist+CoreDataClass.h"
#import "Genres+CoreDataClass.h"
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject {
    
}

+ (CoreDataManager *)sharedInstance;
- (void)insertArtistListInDB:(NSArray *)arrArtists;
- (NSArray *)getArtistListFromDB:(NSManagedObjectContext *)context;
- (NSManagedObjectContext *)managedObjectContext;

@end

