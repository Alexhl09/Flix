//
//  NowPlayingViewController.h
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface NowPlayingViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property NSMutableArray * arrayMoviesNowPlaying;

@end

NS_ASSUME_NONNULL_END
