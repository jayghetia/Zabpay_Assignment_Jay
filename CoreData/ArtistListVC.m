//
//  ViewController.m
//  CoreData
//
//  Created by Jay on 10/5/17.
//  Copyright © 2017 Jay. All rights reserved.
//

#import "ArtistListVC.h"

#import "Artist+CoreDataProperties.h"
#import "Artist+CoreDataClass.h"

#import "APICall.h"
#import "CoreDataManager.h"

#import "ArtistUI1Cell.h"
#import "ArtistUI2Cell.h"
#import "ArtistFullDetailCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ArtistListVC () {
    NSArray *arrArtistList;
    
}

@end

@implementation ArtistListVC

#pragma mark - Life cycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self callAPIForGetArtistList];
    [self registerCellForCollectionList];
}

- (void)registerCellForCollectionList {
    [self.cvArtistListing registerNib:[UINib nibWithNibName:@"ArtistUI1Cell" bundle:nil] forCellWithReuseIdentifier:@"ArtistUI1Cell"];
    [self.cvArtistListing registerNib:[UINib nibWithNibName:@"ArtistUI2Cell" bundle:nil] forCellWithReuseIdentifier:@"ArtistUI2Cell"];
    [self.cvArtistListing registerNib:[UINib nibWithNibName:@"ArtistFullDetailCell" bundle:nil] forCellWithReuseIdentifier:@"ArtistFullDetailCell"];
}

- (void)callAPIForGetArtistList {
    
    [[APICall alloc] getListOfArtistFromServerWithSucess:^(id responseData) {
        
        [[CoreDataManager sharedInstance] insertArtistListInDB:responseData];
        arrArtistList = [[CoreDataManager sharedInstance] getArtistListFromDB:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.cvArtistListing reloadData];
        });
        
    } Failure:^(id responseData) {
        
        arrArtistList = [[CoreDataManager sharedInstance] getArtistListFromDB:nil];
        
        if(arrArtistList.count == 0) {
            
            UIAlertController *errorAlert = [UIAlertController
                                         alertControllerWithTitle:@"Error"
                                         message:responseData
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* btnOk = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                        }];
            
            [errorAlert addAction:btnOk];
            [self presentViewController:errorAlert animated:YES completion:nil];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cvArtistListing reloadData];
            });
        }
    }];
}

#pragma mark - Collection View Data Source and Delegate Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return arrArtistList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Artist *obj = arrArtistList[section];
    return obj.genres.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Artist *artist = arrArtistList[indexPath.section];
    Genres *genre = [artist genres].allObjects[indexPath.row];
    
    if (artist.genres.count % 2 == 0) {
        ArtistUI2Cell *cell = (ArtistUI2Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ArtistUI2Cell" forIndexPath:indexPath];
        cell.lblArtistName.text = artist.artistName;
        cell.lblGenresName.text = genre.name;
        [cell.ivImage sd_setImageWithURL:[NSURL URLWithString:artist.artworkUrl100] placeholderImage:[UIImage imageNamed:@"PlaceHolder_Artist"]];
        return cell;
    }
    else {
        if(indexPath.row == 0) {
            ArtistUI1Cell *cell = (ArtistUI1Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ArtistUI1Cell" forIndexPath:indexPath];
            cell.lblArtistName.text = artist.artistName;
            cell.lblGenresName.text = genre.name;
            [cell.ivImage sd_setImageWithURL:[NSURL URLWithString:artist.artworkUrl100] placeholderImage:[UIImage imageNamed:@"PlaceHolder_Artist"]];
            return cell;
        }
        else {
            ArtistFullDetailCell *cell = (ArtistFullDetailCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ArtistFullDetailCell" forIndexPath:indexPath];
            cell.lblArtistName.text = artist.artistName;
            cell.lblGenresName.text = genre.name;
            [cell.ivImage sd_setImageWithURL:[NSURL URLWithString:artist.artworkUrl100] placeholderImage:[UIImage imageNamed:@"PlaceHolder_Artist"]];
            [cell.ivBgImage sd_setImageWithURL:[NSURL URLWithString:artist.artworkUrl100] placeholderImage:[UIImage imageNamed:@"PlaceHolder_Artist"]];
            return cell;
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Artist *artist = arrArtistList[indexPath.section];
    
    if (artist.genres.count % 2 == 0) {
        return CGSizeMake((self.view.frame.size.width - 30)/2, (self.view.frame.size.width - 30)/2 * 1.1);
    }
    else {
        if(indexPath.row == 0) {
            return CGSizeMake(self.view.frame.size.width - 20, 70);
        }
        else {
            return CGSizeMake(self.view.frame.size.width - 20, 202);
        }
    }
}


@end

