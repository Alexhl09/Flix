//
//  catalogTableViewCell.h
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../models/Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface catalogTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *arrayMoviesNowPlaying;
@property Movie * mySelectedMovie;
@property (weak,nonatomic) UIViewController * myController;
@property int idGenre;
@end

NS_ASSUME_NONNULL_END
