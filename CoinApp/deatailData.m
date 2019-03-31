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

    activityIndicator.center = CGPointMake( self.view.frame.size.width/2,self.view.frame.size.height/2);
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
    
   
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)downloadData:(NSString *)url_string{
    dispatch_queue_t queue = dispatch_queue_create("data_process", 0);
    dispatch_async(queue, ^{
        // data processing
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_string] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil && data != nil)  {
                
                NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                Group *group = [[Group alloc] init];
                
                // [group setValue:[json valueForKey:@"id"] forKey:@"idName"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *ok =[json valueForKey:@"description"];
                    
//                    NSLog(@"json: %@", [[[json valueForKey:@"market_data"]valueForKey:@"current_price"]valueForKey:@"usd"]);
             
                    [self->activityIndicator stopAnimating];
                    self->activityIndicator.hidden = YES;
                    name.text = _coin.name;
                    currentPrice.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"current_price"]valueForKey:@"usd"]];
                    marketCap.text= [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"market_cap"]valueForKey:@"usd"]];
                    tradingVolume.text= [NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"circulating_supply"]];
                    high.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"high_24h"]valueForKey:@"usd"]];
                    low.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"low_24h"]valueForKey:@"usd"]];
                    totalSupply.text =[NSString stringWithFormat:@"%d",[[json valueForKey:@"market_data"]valueForKey:@"total_supply"]];
                    rank.text=[NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"market_cap_rank"]];
                    //            self->description.text =[NSString stringWithFormat:@"%@",[ok valueForKey:@"en"] ];
                    
                    [self->web setBackgroundColor:[UIColor clearColor]];
                    [self->web loadHTMLString:[ok valueForKey:@"en"] baseURL:nil];
                    //  [self.view addSubview:web];
                    //   NSLog(@"%f %f",self.view.frame.size.height,self->web.frame.size.width);
                    
                });
                
            }else {
                
            };
        }] resume];
        
       
       
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
