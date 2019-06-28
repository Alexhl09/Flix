//
//  DetailMovie.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import "DetailMovie.h"
#import "Movie.h"
#import "movieCellCollectionViewCell.h"
#import "DetailMovie.h"
#import "TrailerViewController.h"
@import AFNetworking;
@interface DetailMovie ()

@end

@implementation DetailMovie
@synthesize backImage, mainImage, titleMovie, movieDescription;

///Here I use the information of the object Movie that the previuos view controller sent me and I change the properties with the info I got.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backImage setImageWithURL:_myMovie.backdrop];
    [self.mainImage setImageWithURL:_myMovie.movieImage];
    self.titleMovie.text = _myMovie.title;
    [self setTitle:_myMovie.title];
    self.movieDescription.text = _myMovie.descriptionMovie;
    _trailerButton.layer.cornerRadius = 15;
    [_trailerButton setClipsToBounds:YES];
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews {
    [self.movieDescription setContentOffset:CGPointZero animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"trailer"]){
        TrailerViewController * vc = [segue destinationViewController];
        [vc setIdMovie:_myMovie.idMovie];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
