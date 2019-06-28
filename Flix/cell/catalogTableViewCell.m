//
//  catalogTableViewCell.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//
#import "Movie.h"
#import "catalogTableViewCell.h"
#import "movieCategoryCollectionViewCell.h"
#import "../CatalogViewController.h"

@import AFNetworking;

@implementation catalogTableViewCell
@synthesize arrayMoviesNowPlaying;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    ///Here i assign my collection view the data source and the delegate

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


///Here Populate the collection view depending on the array taht I received from the table view controller from the Catalog View Controller

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    movieCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    [cell setClipsToBounds:YES];
    if(arrayMoviesNowPlaying.count > 0){
        NSLog(@"%@",[arrayMoviesNowPlaying[indexPath.row] movieImage]);
         
         }
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[arrayMoviesNowPlaying[indexPath.row] movieImage]];
    
    [cell.imageMovie setImageWithURLRequest:request placeholderImage:nil
                                      success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
                                          
                                          // imageResponse will be nil if the image is cached
                                          [UIView transitionWithView:cell.imageMovie duration:2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                              [cell.imageMovie setImage:image];
                                          } completion:nil];
                                      }
                                      failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
                                          // do something for the failure condition
                                      }];
    cell.imageMovie.layer.cornerRadius = 15;
    
    [cell.imageMovie setClipsToBounds:YES];

    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrayMoviesNowPlaying.count;
}

/// Depending on the item select I cahnge my static variable and perform a segue to the Detail view
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Movie * myMovie = arrayMoviesNowPlaying[indexPath.row];
    [CatalogViewController setMySelectedMovie:myMovie];
    [self.myController performSegueWithIdentifier:@"info" sender:self];
    
}


- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}



- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}



- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}



@end
