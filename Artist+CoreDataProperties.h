//
//  Artist+CoreDataProperties.h
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Artist+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Artist (CoreDataProperties)

+ (NSFetchRequest<Artist *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *artistName;
@property (nullable, nonatomic, copy) NSString *artworkUrl100;
@property (nullable, nonatomic, copy) NSString *uId;
@property (nullable, nonatomic, copy) NSString *artistId;
@property (nullable, nonatomic, retain) NSSet<Genres *> *genres;

@end

NS_ASSUME_NONNULL_END

