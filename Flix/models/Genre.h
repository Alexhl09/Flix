//
//  Genre.h
//  Flix
//
//  Created by alexhl09 on 6/27/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#ifndef Genre_h
#define Genre_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Genre : NSObject

@property NSString * name;
@property int idGenre;

- (instancetype) initWith : (NSString *) name : (int) idGenre;



@end


#endif /* Genre_h */
