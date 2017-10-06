//
//  Artist+CoreDataProperties.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Artist+CoreDataProperties.h"

@implementation Artist (CoreDataProperties)

@dynamic artistName;
@dynamic artworkUrl100;
@dynamic uId;
@dynamic artistId;
@dynamic genres;

+ (NSFetchRequest<Artist *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
}

@end

