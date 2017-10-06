//
//  APICall.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//


#import "APICall.h"

@implementation APICall {
    
}

#define g_BaseURL @"https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/100/non-explicit.json"

-(void)getListOfArtistFromServerWithSucess:(WebMasterSuccessBlock)successBlock Failure:(WebMasterSuccessBlock)failureBlock {
    
    NSURL *URL = [NSURL URLWithString:g_BaseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData* data, NSURLResponse* response, NSError *error) {
                                      
                                      if(error == nil) {
                                          NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                          
                                          if([dictionary valueForKey:@"feed"]){
                                                                                            
                                              if([[dictionary valueForKey:@"feed"] valueForKey:@"results"]){
                                                  successBlock([[dictionary valueForKey:@"feed"] valueForKey:@"results"]);
                                              }
                                          }
                                      }
                                      else {
                                          failureBlock(error.localizedDescription);
                                      }
                                      
                                  }];
    [task resume];
}

@end

