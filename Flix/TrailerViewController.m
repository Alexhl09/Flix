//
//  TrailerViewController.m
//  Flix
//
//  Created by alexhl09 on 6/27/19.
//  Copyright © 2019 alexhl09. All rights reserved.
//

#import "TrailerViewController.h"
#import "models/Movie.h"


@interface TrailerViewController ()




@end

@implementation TrailerViewController
@synthesize webViewTrailer, idMovie;
- (void)viewDidLoad {
    [super viewDidLoad];

  
    // Do any additional setup after loading the view.
    [self fetchTrailer];
}


///This method gets the link that I need to request the web page where the trailer is.
-(void) fetchTrailer{
    NSString * idMovieString = [NSString stringWithFormat:@"%i", idMovie];
    NSString * idURLMovie1 = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/"];
     NSString * idURLMovie2 = [NSString stringWithFormat:@"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    
    NSString * url1 = [idURLMovie1 stringByAppendingString:idMovieString];
    
    NSString * url2 = [url1 stringByAppendingString: idURLMovie2];
    
    NSLog(@"%@",url2);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url2]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
  
  
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Fail" message:@"Please check your network" preferredStyle:(UIAlertControllerStyleAlert)];
                                                        UIAlertAction * action = [UIAlertAction actionWithTitle:@"Ok" style:(UIAlertActionStyleCancel) handler:nil];
                                                        [alert addAction:action];
                                                        [self presentViewController:alert animated:YES completion:nil];
                                                        
                                                    } else {
                                                        NSDictionary * dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        NSLog(@"%@",dataDictionary);
                                          
                                                        NSArray * results = dataDictionary[@"results"];
                                                        
                                                        if(results.count > 0){
                                                            NSDictionary * dicResult = results[0];
                                                            NSString * codigo = dicResult[@"key"];
                                                            NSString * titulo = dicResult[@"name"];
                                                            [self setTitle:titulo];
                                                            self.productURL = [@"https://www.youtube.com/watch?v=" stringByAppendingString:codigo];
                                                            
                                                            NSURL *url = [NSURL URLWithString:self.productURL];
                                                            NSURLRequest *request = [NSURLRequest requestWithURL:url];
                                                            
                                                            [self->webViewTrailer loadRequest:request];
                                                        }
                                                      
                                                        //    self.productURL = @"http://www.URL YOU WANT TO VIEW GOES HERE";
                                                        //
                                                        
                                                        }
                                                   
                                                }];https://www.youtube.com/watch?v=

    
    [dataTask resume];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonTrailer:(UIButton *)sender {
}
@end
