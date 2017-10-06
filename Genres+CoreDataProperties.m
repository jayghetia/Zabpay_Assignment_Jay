//
//  Genres+CoreDataProperties.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Genres+CoreDataProperties.h"

@implementation Genres (CoreDataProperties)

@dynamic genreId;
@dynamic name;
@dynamic url;
@dynamic uId;
@dynamic artist;

+ (NSFetchRequest<Genres *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Genres"];
}

@end

