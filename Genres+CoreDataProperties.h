//
//  Genres+CoreDataProperties.h
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Genres+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Genres (CoreDataProperties)

+ (NSFetchRequest<Genres *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *genreId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *uId;
@property (nullable, nonatomic, retain) Artist *artist;

@end

NS_ASSUME_NONNULL_END

