//
//  CatalogViewController.h
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "models/Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatalogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray * myCategories;
@property NSMutableArray * arrayMoviesNowPlaying;
///I have a varibale that helps to send the information of the selected movie to the following view controller
+ (Movie *) mySelectedMovie;

///I needed to create a static variable in order to access to it in the collection view controller that is inside the table view controller cell
+ (void) setMySelectedMovie : (Movie *) myMovie;
/// This method fetch all the movies from the API
-(void) getGenres;
@property NSMutableArray * myGenres;
@end

NS_ASSUME_NONNULL_END
