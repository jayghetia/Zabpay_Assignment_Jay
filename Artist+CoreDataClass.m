//
//  Artist+CoreDataClass.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "Artist+CoreDataClass.h"
#import "Genres+CoreDataClass.h"

@implementation Artist

// Insert data in database
+(void)insertRows:(NSArray *)dataArray inContext:(NSManagedObjectContext *)context {
    
    for (NSDictionary *discArtistData in dataArray) {
        
        if (![Artist isExistuId:[discArtistData objectForKey:@"id"] inContext:context]) {
            
            Artist *objArtist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:context];
            
            objArtist.uId           = [discArtistData objectForKey:@"id"];
            objArtist.artistName    = [discArtistData objectForKey:@"artistName"];
            objArtist.artworkUrl100 = [discArtistData objectForKey:@"artworkUrl100"];
            objArtist.artistId      = [discArtistData objectForKey:@"artistId"];
            
            NSArray *arrGenres = [discArtistData objectForKey:@"genres"];
            NSMutableArray *arrAllRecored = [[NSMutableArray alloc] init];
            
            for (NSDictionary *discGenresData in arrGenres) {
                
                Genres *objGenres = [NSEntityDescription insertNewObjectForEntityForName:@"Genres" inManagedObjectContext:context];
                
                objGenres.genreId = [discGenresData objectForKey:@"genreId"];
                objGenres.name = [discGenresData objectForKey:@"name"];
                objGenres.url = [discGenresData objectForKey:@"url"];
                objGenres.uId = [discArtistData objectForKey:@"id"];
                
                [arrAllRecored addObject:objGenres];
            }
            
            NSSet *distinctSet = [NSSet setWithArray:arrAllRecored];
            objArtist.genres = distinctSet;
        }
    }
    
    if ([context hasChanges]) {
        NSError *error;
        [context save:&error];
    }
    
}

+(BOOL)isExistuId:(NSString *)uId inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Artist class])];
    NSError *error = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uId == %@", uId];
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (results.count > 0) {
        return true;
    }
    
    return false;
}

@end

