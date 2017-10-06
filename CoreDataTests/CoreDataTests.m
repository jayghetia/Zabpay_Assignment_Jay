//
//  CoreDataTests.m
//  CoreDataTests
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArtistListVC.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataTests : XCTestCase

@end

@implementation CoreDataTests

ArtistListVC * viewController;


- (void)setUp {
    [super setUp];
    
    viewController = (ArtistListVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ArtistListVC"];

//    viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PeopleListViewController") as! PeopleListViewController
//
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void) testColletionViewBeforeLoading {
    XCTAssertNil(viewController.cvArtistListing, "Before loading the collection view should be nil");
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {

    XCTAssert(true, "Pass");
}

- (void)testPerformanceExample {
    [self measureBlock:^{

    }];
}

@end

@class Genres;

@interface MokeArtist : NSManagedObject

+(void)insertRows:(NSArray *)dataArray inContext:(NSManagedObjectContext *)context;

@end
