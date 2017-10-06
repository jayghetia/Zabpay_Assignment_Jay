//
//  APICall.h
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WebMasterSuccessBlock)(id responseData);
typedef void(^WebMasterFailureBlock)(id responseData);

@interface APICall : NSObject

-(void)getListOfArtistFromServerWithSucess:(WebMasterSuccessBlock)successBlock Failure:(WebMasterSuccessBlock)failureBlock;

@end

