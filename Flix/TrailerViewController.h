//
//  TrailerViewController.h
//  Flix
//
//  Created by alexhl09 on 6/27/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TrailerViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *webViewTrailer;

@property (strong, nonatomic) NSString *productURL;
@property int idMovie;
@end

NS_ASSUME_NONNULL_END
