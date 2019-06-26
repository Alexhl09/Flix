//
//  DetailMovie.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import "DetailMovie.h"
@import AFNetworking;
@interface DetailMovie ()

@end

@implementation DetailMovie
@synthesize backImage, mainImage, titleMovie, movieDescription;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backImage setImageWithURL:_myMovie.backdrop];
    [self.mainImage setImageWithURL:_myMovie.movieImage];
    self.titleMovie.text = _myMovie.title;
    self.movieDescription.text = _myMovie.descriptionMovie;
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews {
    [self.movieDescription setContentOffset:CGPointZero animated:NO];
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
