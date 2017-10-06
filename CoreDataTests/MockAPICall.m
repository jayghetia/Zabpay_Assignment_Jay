//
//  MockAPICall.m
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

@interface MockAPICall : XCTestCase

@end


@implementation MockAPICall

#define g_Moke_BaseURL1 @"https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/100/non-explicit.json"

-(void)baseWscalldispatch1:(WebMasterSuccessBlock)successBlock Failure:(WebMasterSuccessBlock)failureBlock {

    NSURL *URL = [NSURL URLWithString:g_Moke_BaseURL1];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData* data, NSURLResponse* response, NSError *error) {
                                      NSLog(@"%@",response);
                                      NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                      NSLog(@"%@",dictionary);
                                      if([dictionary valueForKey:@"feed"]){
                                          if([[dictionary valueForKey:@"feed"] valueForKey:@"results"]){
                                             successBlock([[dictionary valueForKey:@"feed"] valueForKey:@"results"]);
                                          }else{
                                              failureBlock(@"Result not found");
                                          }
                                      }else{
                                          
                                          failureBlock(@"URL is not responding");
                                      }
                                  }];
    [task resume];
}

-(void)testGetDataFromWS {
    
    [self baseWscalldispatch1:^(id responseData) {
        XCTAssertTrue(true, @"response get successfully");
    } Failure:^(id responseData) {
        XCTAssertTrue(false, @"response fail");
    }];
}
@end
