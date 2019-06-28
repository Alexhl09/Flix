//
//  DetailMovie.h
//  Flix
//
//  Created by alexhl09 on 6/26/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailMovie : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleMovie;
@property (weak, nonatomic) IBOutlet UITextView *movieDescription;
@property (weak, nonatomic) IBOutlet UIButton *trailerButton;
@property Movie * myMovie;
@end

NS_ASSUME_NONNULL_END
