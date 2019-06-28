//
//  Genre.m
//  Flix
//
//  Created by alexhl09 on 6/27/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Genre.h"
@implementation Genre
@synthesize name, idGenre;




-(instancetype) init{
    
    self = [self initWith:@"" :0];
    return self;
}

- (instancetype) initWith : (NSString *) name : (int) idGenre{
    self = [super init];
    if (self) {
    self->name = name;
    self->idGenre = idGenre;
    }
    return self;
        
}
@end
