//
//  deatailData.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "deatailData.h"

@interface deatailData ()<UIScrollViewDelegate,UIWebViewDelegate>{
    IBOutlet UIImageView *imageV;

    IBOutlet UILabel *ok;
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
@synthesize scroll;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_coin.image);
    scroll.delegate = self;

    [scroll setScrollEnabled:YES];

    web.delegate = self;
    //height = web.scrollView.contentSize.height;
    web.scrollView.scrollEnabled = NO;
 
    self.title = _coin.name;
    NSString *url_string = [NSString stringWithFormat: @"https://api.coingecko.com/api/v3/coins/%@?localization=false",_coin.idName];
   
    NSLog(@"%@",url_string);
    self->activityIndicator= [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.view.center;
    [self->activityIndicator startAnimating];
    [self downloadData:url_string];
    //[self.scroll addSubview:self->activityIndicator];
  //  [self.scroll addSubview:web];
    
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
              //  Group *group = [[Group alloc] init];
                
                // [group setValue:[json valueForKey:@"id"] forKey:@"idName"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *ok =[json valueForKey:@"description"];
                    
//                    NSLog(@"json: %@", [[[json valueForKey:@"market_data"]valueForKey:@"current_price"]valueForKey:@"usd"]);
             
//                    [self->activityIndicator stopAnimating];
//                    self->activityIndicator.hidden = YES;
                    name.text = _coin.name;
                    currentPrice.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"current_price"]valueForKey:@"usd"]];
                    marketCap.text= [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"market_cap"]valueForKey:@"usd"]];
                    tradingVolume.text= [NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"circulating_supply"]];
                    high.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"high_24h"]valueForKey:@"usd"]];
                    low.text = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"market_data"]valueForKey:@"low_24h"]valueForKey:@"usd"]];
                    totalSupply.text =[NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"total_supply"]];
                    rank.text=[NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"market_cap_rank"]];
                    //            self->description.text =[NSString stringWithFormat:@"%@",[ok valueForKey:@"en"] ];
                    
                    [self->web setBackgroundColor:[UIColor clearColor]];
                    [self->web loadHTMLString:[ok valueForKey:@"en"] baseURL:nil];
                   // web.scalesPageToFit = true
                   // web.contentMode = .scaleAspectFit;
//                    CGFloat scrollViewHeight = 0.0f;
//                    for (UIView* view in web)
//                    {
//                        //scrollViewHeight += web.view.frame.size.height;
//                    }
//                    NSString *result = [self->web stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
//
//                    float height = [result integerValue];
                   // NSLog(@"%f\n",height);
                   
                   // self.scrollHeightCons.constant = web.frame.size.height+200;
                    
                    
                    //   NSLog(@"%f %f",self.view.frame.size.height,self->web.frame.size.width);
                    
                });
                
            }else {
                
            };
        }] resume];
        
       
       
    });
    
}
#pragma mark - ScrollviewDelegate

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidZoom");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    //NSLog(@"scrollViewDidScroll %@",NSStringFromCGPoint(scrollView.contentOffset));
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    aWebView.frame = frame;
    height =fittingSize.height - 400;
    NSLog(@"%f\n",height);
    self.scrollHeightCons.constant = height;
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
}
- (void)dealloc {
    [scroll release];
    [_scrollHeightCons release];
    [super dealloc];
}
@end


