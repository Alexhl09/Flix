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

@interface NowPlayingViewController ()

@end

@implementation NowPlayingViewController
@synthesize collectionView, arrayMoviesNowPlaying;





- (void)viewDidLoad {
    [super viewDidLoad];
    
    // This View controller is going to be the delegate and data source of my collection view
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?language=en-US&api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"]
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
                                                            NSLog(@"%@",movie[@"title"]);
                                                            NSLog(@"%@",movie[@"original_language"]);
                                                            NSLog(@"%@",movie[@"title"]);
                                                            NSLog(@"%@",movie[@"vote_average"]);
                                                            NSLog(@"%@",movie[@"overview"]);
                                                            NSLog(@"%@",movie[@"poster_path"]);
                                                            NSArray *genres = movie[@"genre_ids"];
                                                              for (NSString *genre in genres){
                                                                  NSLog(@"%@",genre);
                                                            }
                                                            
                                                            
                                                        }
                                                        
                                           
                                                    }
                                                }];
    [dataTask resume];
    
    // Do any additional setup after loading the view.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    movieCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
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
