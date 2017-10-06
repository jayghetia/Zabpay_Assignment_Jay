//
//  Artist+CoreDataClass.h
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Genres;

NS_ASSUME_NONNULL_BEGIN

@interface Artist : NSManagedObject {
    
}

+(void)insertRows:(NSArray *)dataArray inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Artist+CoreDataProperties.h"

