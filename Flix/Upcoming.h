//
//  Upcoming.h
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface Upcoming : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UIRefreshControl * refreshControl;
@property NSMutableArray * arrayMoviesNowPlaying;
@property NSArray * arrayMoviesNowPlayingFiltered;
@property Movie * myMovieSelected;

-(void) getMoviesNowPlaying;
@end

NS_ASSUME_NONNULL_END
