//
//  CatalogViewController.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import "CatalogViewController.h"
#import "Genre.h"
#import "cell/catalogTableViewCell.h"
#import "models/Movie.h"
#import "DetailMovie.h"


@interface CatalogViewController ()

@end

@implementation CatalogViewController
@synthesize tableView, myCategories,arrayMoviesNowPlaying;
static  Movie * mySelectedMovie;
/// This methods are the setter and getter of my static variable that staores the movie selected in the collection view
+ (Movie *) mySelectedMovie { return mySelectedMovie; }
+ (void) setMySelectedMovie : (Movie *) myMovie {  mySelectedMovie = myMovie;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    myCategories = [[NSMutableArray alloc] init];
    [self getGenres];
    self.arrayMoviesNowPlaying = [NSMutableArray new];

    [self getMoviesNowPlaying];
    // Do any additional setup after loading the view.
}

/// This method help me to get all the data and store it in the array of movies that i have
-(void) getMoviesNowPlaying{
    [self.arrayMoviesNowPlaying removeAllObjects];
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        
                                                        
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
                                                            
                                                            
                                                        
                                                            
                                                            int idMovie = [[movie objectForKey:@"id"] intValue];
                                                            int rateMovie = [[movie objectForKey:@"vote_average"] doubleValue];
                                                            Movie * myMovie = [[Movie alloc] initWith:posterURL :genresArray :movie[@"title"] : movie[@"overview"]  : rateMovie : idMovie : posterURL] ;
                                                            NSLog(@"%@",posterURL);
                                                  
                                                                [self.arrayMoviesNowPlaying addObject:myMovie];
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            //                                                            Movie * myMovieToBeAdded = [Movie init]
                                                            
                                                        }
                                                        
                                                        
                                                        //                                                         [self.collectionView reloadData];
                                                        
                                                        
                                                        
                                                    }
                                                }];
    
    
    [dataTask resume];
    
}

///Here i got the names of the genre and the id because with that information i can filter the movies
-(void) getGenres{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/genre/movie/list?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];

    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        NSArray *genres = dataDictionary[@"genres"];
                                                        for(NSDictionary * valuesGenres in genres){
                                                            int idGenre = [[valuesGenres objectForKey:@"id"] intValue];
                                                            Genre * myGenre = [[Genre alloc] initWith: valuesGenres[@"name"] :idGenre];
                                                            [self->myCategories addObject: myGenre];
                                                        
                                                        }
                                                   
                                                    }
                                                    [tableView reloadData];
                                                }];
    [dataTask resume];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

///Here the information that my table view cell needs in order to populate all the collection view cells,
///I filter everything with a predicate that helps to get the movies that belong to certain genre.
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     catalogTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Movie *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject.arrayGenres containsObject: @([self->myCategories[indexPath.section] idGenre])];
    }];
  
    cell.arrayMoviesNowPlaying = [NSArray new];
    cell.myController = self;
    cell.arrayMoviesNowPlaying = [self.arrayMoviesNowPlaying filteredArrayUsingPredicate:predicate];
    NSLog(@"%lu",cell.arrayMoviesNowPlaying.count);


    [cell.collectionView reloadData];

    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
return [myCategories[section] name];
}
/// I prepare the data that i am going to send to the other view, but the information that i stored in my static variable
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"info"])
    {
        DetailMovie * vc = [segue destinationViewController];
        [vc setMyMovie: mySelectedMovie];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return myCategories.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return 1;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder { 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
    
}



- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
    return CGSizeMake(parentSize.width, parentSize.width);
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
