//
//  NowPlayingViewController.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "Movie.h"
#import "movieCellCollectionViewCell.h"
#import "DetailMovie.h"
@import AFNetworking;
@interface NowPlayingViewController ()

@end

@implementation NowPlayingViewController

/// Synthesize my properties in order to get setters and getters
@synthesize collectionView, arrayMoviesNowPlaying, myMovieSelected;



- (void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    /// My collection view delegate and data source is going to be this view

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    /// I had a problem; I didn't know that before using a NSMutableArray we have to allocate it and initialize it

    self.arrayMoviesNowPlaying = [NSMutableArray new];
    self.arrayMoviesNowPlayingFiltered = [NSMutableArray new];
    self.myMovieSelected = [Movie new];
    
    /// Set my activityView to be visible and start animating

    [_activityView setHidden:NO];
    
    [_activityView startAnimating];
    
    /// Fetch all the data and store it in my own array of objects of type Movie

    [self getMoviesNowPlaying];


    
    
    /// I create a refresh Control

    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(getMoviesNowPlaying) forControlEvents:UIControlEventValueChanged];
    
    ///Use the refresh control in the collection view

    [self.collectionView addSubview:self.refreshControl];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    
        ///The delegate of the search bar is this view controller
    _searchBar.delegate = self;
    
    

    // Do any additional setup after loading the view.
}


/// This method shows the cancel button
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

/// This method makes the search bar first responder

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}


/// getMoviesNowPlaying
/// This function fetch all the data from the API and store it in my Array arrayMoviesNowPlaying

/// -Parameters:
///     -None
///

-(void) getMoviesNowPlaying{
    [self.arrayMoviesNowPlaying removeAllObjects];
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:5.0];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:postData];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Fail" message:@"Please check your network" preferredStyle:(UIAlertControllerStyleAlert)];
                                                        UIAlertAction * action = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleCancel) handler:nil];
                                                        [alert addAction:action];
                                                        [self presentViewController:alert animated:YES completion:nil];
                                                        
                                                    } else {
                                                        NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        NSArray *movies = dataDictionary[@"results"];
                                                        
                                                        for (NSDictionary *movie in movies){
                                                            NSMutableArray * genresArray = [NSMutableArray new];
                                                            
                                                            NSArray *genres = movie[@"genre_ids"];
                                                            for (NSString *genre in genres){
                                                                [genresArray addObject:genre];
                                                                
                                                            }
                                                            NSString * baseURLString = @"https://image.tmdb.org/t/p/w500";
                                                            NSString * posterURLString= movie[@"poster_path"];
                                                            NSString * fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
                                                            NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
                                                            
                                                            
                                                            NSString * posterURLStringBack = movie[@"backdrop_path"];
                                                            NSString * fullPosterURLStringBack = [baseURLString stringByAppendingString:posterURLStringBack];
                                                            NSURL *posterURLBack = [NSURL URLWithString:fullPosterURLStringBack];
                                                            
                                                            int idMovie = [[movie objectForKey:@"id"] intValue];
                                                            int rateMovie = [[movie objectForKey:@"vote_average"] doubleValue];
                                                            NSLog(@"%@",movie[@"overview"] );
                                                            Movie * myMovie = [[Movie alloc] initWith:posterURL :genresArray :movie[@"title"] : movie[@"overview"]  : rateMovie : idMovie : posterURLBack] ;
                                                            NSLog(@"%@",posterURL);
                                                            
                                                            [self.arrayMoviesNowPlaying addObject:myMovie];
                                                            
                                                            
                                                           
                                                            //                                                            Movie * myMovieToBeAdded = [Movie init]
                                                           
                                                        }

                                                        
//                                                         [self.collectionView reloadData];
                                                        
                                                        
                                                       
                                                    }
                                                    
                                                    [self.refreshControl endRefreshing];
                                                    [self->_activityView stopAnimating];

                                                    [self->_activityView setHidden:YES];
                                                    
                                                    self.arrayMoviesNowPlayingFiltered = self.arrayMoviesNowPlaying;
                                                    [self.collectionView reloadData];

                                                }];
 

    [dataTask resume];
    
}
/**
 This function get the information of each movie that is now playing and store the information in an array of Movies
 - parameters:
 - None
 */




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

///Here I use the information in my array arrayMoviesNowPlaying and use that information to populate all my cells in the collection view
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *celldentifier = @"cell";
    
    movieCellCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:celldentifier forIndexPath:indexPath];
    if (!myCell) {
    }



    NSURLRequest *request = [NSURLRequest requestWithURL:[_arrayMoviesNowPlayingFiltered[indexPath.row] movieImage]];

    [myCell.imageMovie setImageWithURLRequest:request placeholderImage:nil
                                    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
                                        
                                        [UIView transitionWithView:myCell.imageMovie duration:2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                            [myCell.imageMovie setImage:image];
                                        } completion:nil];
                                        
                                        // imageResponse will be nil if the image is cached
//                                        if (imageResponse) {
//                                            NSLog(@"Image was NOT cached, fade in image");
//                                            myCell.imageMovie.alpha = 0.0;
//                               
//                                            myCell.imageMovie.image = image;
//                                            
//                                            //Animate UIImageView back to alpha 1 over 0.3sec
//                                            [UIView animateWithDuration:0.3 animations:^{
//                                                 myCell.imageMovie.alpha = 1.0;
//                               
//                                            }];
//                                        }
//                                        else {
//                                            NSLog(@"Image was cached so just update the image");
//                                            myCell.imageMovie.image = image;
//                                        }
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
                                        // do something for the failure condition
                                    }];
    myCell.imageMovie.layer.cornerRadius = 15;

    [myCell.imageMovie setClipsToBounds:YES];

    return myCell;
}



///This method filters all the movies using my array and creating a new one that is used to populate the cells
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Movie *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.title containsString:searchText];
        }];
        self.arrayMoviesNowPlayingFiltered = [self.arrayMoviesNowPlaying filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.arrayMoviesNowPlayingFiltered);
        
    }
    else {
        self.arrayMoviesNowPlayingFiltered = self.arrayMoviesNowPlaying;
    }
    
    [self.collectionView reloadData];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.myMovieSelected = _arrayMoviesNowPlayingFiltered[indexPath.row];
    NSLog(@"%@",myMovieSelected.title);
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"info" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"info"]){
        DetailMovie * vc = [segue destinationViewController];
        [vc setMyMovie:myMovieSelected];
      
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_arrayMoviesNowPlayingFiltered count];
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeMake(parentSize.width, parentSize.height);
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
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
