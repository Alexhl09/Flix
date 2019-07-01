//
//  Upcoming.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import "Upcoming.h"
#import "Movie.h"
#import "movieCellCollectionViewCell.h"
#import "DetailMovie.h"
@import AFNetworking;
@interface Upcoming ()

@end

@implementation Upcoming
@synthesize collectionView, arrayMoviesNowPlaying, myMovieSelected;



- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // This View controller is going to be the delegate and data source of my collection view
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.arrayMoviesNowPlaying = [NSMutableArray new];
    self.arrayMoviesNowPlayingFiltered = [NSMutableArray new];
    self.myMovieSelected = [Movie new];
    [self getMoviesNowPlaying];
    [_activityView setHidden:NO];
    
    [_activityView startAnimating];
    

    
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(getMoviesNowPlaying) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    _searchBar.delegate = self;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}
-(void) getMoviesNowPlaying{
    [self.arrayMoviesNowPlaying removeAllObjects];
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/upcoming?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
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
                                                        
                                                        
                                                        [self->_activityView setHidden:YES];
                                                        [self->_activityView stopAnimating];
                                                    }
                                                    [self.collectionView reloadData];
                                                    self.arrayMoviesNowPlayingFiltered = self.arrayMoviesNowPlaying;
                                                }];
    [self.refreshControl endRefreshing];
    [self->_activityView setHidden:YES];
    [self->_activityView stopAnimating];
    
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *celldentifier = @"cell";
    
    movieCellCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:celldentifier forIndexPath:indexPath];
    if (!myCell) {
    }
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[_arrayMoviesNowPlayingFiltered[indexPath.row] movieImage]];
    
    [myCell.imageMovie setImageWithURLRequest:request placeholderImage:nil
                                      success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
                                          
                                          [UIView transitionWithView:myCell.imageMovie duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                              [myCell.imageMovie setImage:image];
                                          } completion:nil];
                                          
                        
                                      }
                                      failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
                                          // do something for the failure condition
                                      }];
  
    myCell.imageMovie.layer.cornerRadius = 15;
    [myCell.imageMovie setClipsToBounds:YES];
    return myCell;
}
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
