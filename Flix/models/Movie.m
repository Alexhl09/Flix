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
@synthesize movieImage, title, descriptionMovie, arrayGenres, votes, idMovie;




-(instancetype) init{
    
    self = [self initWith:[NSURL URLWithString:@"https://image.tmdb.org/t/p/w500/sJWwkYc9ajwnPRSkqj8Aue5JbKz.jpg"] :[NSMutableArray new] : [NSMutableString string] :[NSMutableString string]  :0.0 : 0 : [NSURL URLWithString:@"https://image.tmdb.org/t/p/w500/sJWwkYc9ajwnPRSkqj8Aue5JbKz.jpg"]];
    return self;
}

-(instancetype) initWith:(NSURL *)image :(NSMutableArray *)genres :(NSMutableString *)title :(NSMutableString *)descriptionMovie :(double)votes : (int) idMovie : (NSURL *) backdrop {
    self = [super init];
    if (self) {
        self.movieImage = image;
        self.title = title;
        self.descriptionMovie = descriptionMovie;
        self.arrayGenres = genres;
        self.backdrop = backdrop;
        self.votes = votes;
        self.idMovie = idMovie;
    }
    return self;
}


@end
