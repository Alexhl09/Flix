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
@property UIImage * movieImage;
@property NSMutableArray * arrayGenres;
@property NSMutableString * title;
@property NSMutableString * descriptionMovie;
@property BOOL status;
@property double votes;

- (instancetype) initWith : (UIImage *) image : (NSMutableArray *) genres : (NSMutableString * ) title : (NSMutableString *) descriptionMovie : (BOOL) status : (double) votes;








@end

#endif /* Movie_h */
