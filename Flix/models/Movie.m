//
//  Movie.m
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@implementation Movie
@synthesize movieImage, title, descriptionMovie, arrayGenres,status, votes;



-(instancetype) init{
    self = [self initWith:[UIImage imageNamed:@"launch_image"] :[NSMutableArray  :<#(NSMutableString *)#> :<#(NSMutableString *)#> :<#(BOOL)#> :<#(double)#>]
}

-(instancetype) initWith:(UIImage *)image :(NSMutableArray *)genres :(NSMutableString *)title :(NSMutableString *)descriptionMovie :(BOOL)status :(double)votes{
    self = [super init];
    if (self) {
        self.movieImage = image;
        self.title = title;
        self.arrayGenres = genres;
        self.status = status;
        self.votes = votes;
        
        
    }
    
}


@end
