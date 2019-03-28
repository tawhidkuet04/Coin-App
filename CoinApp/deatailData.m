//
//  deatailData.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "deatailData.h"

@interface deatailData (){
    IBOutlet UIImageView *imageV;

    IBOutlet UIWebView *web;
    IBOutlet UILabel *name;
    IBOutlet UITextView *description;
    
    IBOutlet UILabel *rank;
    IBOutlet UILabel *currentPrice;
    IBOutlet UILabel *marketCap;
    IBOutlet UILabel *tradingVolume;
    IBOutlet UILabel *high;
    IBOutlet UILabel *low;
    IBOutlet UILabel *totalSupply;

}


@end

@implementation deatailData

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_coin.image);
   
    NSString *url_string = [NSString stringWithFormat: @"https://api.coingecko.com/api/v3/coins/%@?localization=false",_coin.idName];
    [self downloadData:url_string];
    NSLog(@"%@",url_string);
    self->activityIndicator= [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    activityIndicator.center = CGPointMake( self.view.frame.size.width/2,self.view.frame.size.height/1.2);
    [self->activityIndicator startAnimating];
    [self.view addSubview:self->activityIndicator];
    
    
    NSURL *url = [[NSURL alloc] initWithString:_coin.image];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil)  {
            
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                self.imageView.image = [UIImage imageWithData:data];
            //            });
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self->imageV.image = [UIImage imageWithData:data];
            }];
            
        };
    }] resume];
    
    name.text = _coin.name;
    currentPrice.text = [NSString stringWithFormat:@"%f",_coin.currentPrice];
    marketCap.text= [NSString stringWithFormat:@"%f",_coin.marketCap];
    tradingVolume.text= [NSString stringWithFormat:@"%f",_coin.circulationSupply];
    high.text = [NSString stringWithFormat:@"%f",_coin.high];
    low.text = [NSString stringWithFormat:@"%f",_coin.low];
    totalSupply.text = [NSString stringWithFormat:@"%f",_coin.totalVolume];
    rank.text=[NSString stringWithFormat:@"%d",_coin.rank];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)downloadData:(NSString *)url_string{
    dispatch_queue_t queue = dispatch_queue_create("data_process", 0);
    dispatch_async(queue, ^{
        // data processing
        NSError *error;
        
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        Group *group = [[Group alloc] init];
       
       // [group setValue:[json valueForKey:@"id"] forKey:@"idName"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *ok =[json valueForKey:@"description"];
            
            NSLog(@"json: %@", json );
//            self->description.text =[NSString stringWithFormat:@"%@",[ok valueForKey:@"en"] ];
            [self->activityIndicator stopAnimating];
            self->activityIndicator.hidden = YES;
            [self->web setBackgroundColor:[UIColor clearColor]];
            [self->web loadHTMLString:[ok valueForKey:@"en"] baseURL:nil];
          //  [self.view addSubview:web];
         //   NSLog(@"%f %f",self.view.frame.size.height,self->web.frame.size.width);
            
        });
        
    });
    
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