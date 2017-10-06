//
//  MokeArtist.m
//  CoreDataTests
//
//  Created by MAC on 06/10/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArtistListVC.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APICall.h"
#import "Artist+CoreDataClass.h"
#import "CoreDataManager.h"

@interface MockArtist : XCTestCase

@end



@implementation MockArtist

- (BOOL) testInsertDataInTable{
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = [[CoreDataManager sharedInstance] managedObjectContext];
    
    Artist *objArtist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
    
    objArtist.uId           = @"1";
    objArtist.artistName    = @"Jay";
    objArtist.artworkUrl100 = @"https://www.google.com";
    objArtist.artistId      = @"123";
    
    Genres *objGenres = [NSEntityDescription insertNewObjectForEntityForName:@"Genres" inManagedObjectContext:context];
    
    objGenres.genreId = @"11";
    objGenres.name = @"Test";
    objGenres.url = @"https://www.google.com";
    objGenres.uId = @"123456";
    
    NSMutableArray *arrAllRecored = [[NSMutableArray alloc] init];
    [arrAllRecored addObject:objGenres];
    NSSet *distinctSet = [NSSet setWithArray:arrAllRecored];
    
    objArtist.genres = distinctSet;
    
    if ([context hasChanges]) {
        NSError *error;
        [context save:&error];
        
        return true;
    } else {
        return false;
    }
}

- (BOOL)testIsExistuId:(NSString *)uId {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Artist class])];
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uId == %@", uId];
    request.predicate = predicate;
    
    NSArray *results = [[[CoreDataManager sharedInstance] managedObjectContext] executeFetchRequest:request error:&error];
    
    if (results.count > 0) {
        return true;
    }
    
    return false;
}

-(void) testInsertDataInDatabase {

    XCTAssertTrue([self testInsertDataInTable], "Data save successfully");
}

-(void) testToCheckIsRecordedExist {
    
    XCTAssertFalse([self testIsExistuId:@"2"], "Data not exits");
}


@end

