//
//  Movie.h
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#ifndef Movie_h
#define Movie_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Movie : NSObject
@property (strong, nonatomic)  NSURL * movieImage;
@property (strong, nonatomic)  NSURL * backdrop;
@property (strong, nonatomic)  NSMutableArray * arrayGenres;
@property (strong, nonatomic)  NSMutableString * title;
@property (strong, nonatomic)  NSMutableString * descriptionMovie;

@property double votes;
@property int idMovie;

- (instancetype) initWith : (NSURL *) image : (NSMutableArray *) genres : (NSMutableString * ) title : (NSMutableString *) descriptionMovie : (double) votes : (int) idMovie : (NSURL*) backdrop;








@end

#endif /* Movie_h */
