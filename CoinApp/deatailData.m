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
     //   [self.view addSubview:scroll];
        [scroll setScrollEnabled:YES];
   
    //[scroll setContentSize:CGSizeMake(700,2000)];
    web.delegate = self;
   
    web.scrollView.scrollEnabled = NO;
   // web.scrollView.bounces = NO;
//
//    
//    
//    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(8, 79, CGRectGetWidth(self.view.frame)-16, CGRectGetHeight(self.view.frame))];
//    scroll.backgroundColor = [UIColor redColor];
//    scroll.delegate = self;
//    [self.view addSubview:scroll];
//    [scroll setScrollEnabled:YES];
//    
//   
////    self->scroll.contentSize = contentRect.size;
////    [scroll setContentSize:CGSizeMake(scroll.bounds.size.width
////                                      , scroll.bounds.size
////                                      .height*5)];
//    
//    ok = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(scroll.frame),CGRectGetHeight(scroll.frame) )];
//    ok.font = [UIFont systemFontOfSize:12.0];
//    ok.numberOfLines = 0;
//    ok.minimumFontSize = 8.0f;
//    ok.adjustsFontSizeToFitWidth = YES;
//    ok.lineBreakMode = UILineBreakModeWordWrap;
//    ok.text = @"The CarPlay framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.The CarPlay framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.The CarPlay framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.The CarPlay framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.y framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.The CarPlay framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.The CarPlay framework provides a system-generated and -hosted user interface that you customize to display your navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.navigation app. The framework maintains control over UI elements—such as touch target size, font size and color, highlights, and so on—while also enabling your app to display custom map tiles, trip and routing information, and more. This flexibility lets you focus on delivering a great CarPlay experience without the burden of creating an app that works on all supported CarPlay systems.The CarPlay framewor";
//    [scroll addSubview:ok];
//    CGFloat scrollViewHeight = 0.0f;
//    for (UIView* view in scroll.subviews)
//    {
//        scrollViewHeight += view.frame.size.height;
//    }
//    NSLog(@"sdasd %f",scrollViewHeight);
//   // [scroll setContentSize:CGSizeMake(scroll.bounds.size.width, scroll.bounds.size
//                                                               //            .heigh//t*5)];
//    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight*2)];
//   
//    scroll.maximumZoomScale = 1.0f;
//    scroll.minimumZoomScale = 1.0f;
//    [scroll setAlwaysBounceHorizontal:false];
//    scroll.contentInset = UIEdgeInsetsZero;
//    scroll.contentOffset = CGPointZero;
//    scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.title = _coin.name;
    NSString *url_string = [NSString stringWithFormat: @"https://api.coingecko.com/api/v3/coins/%@?localization=false",_coin.idName];
    [self downloadData:url_string];
    NSLog(@"%@",url_string);
    self->activityIndicator= [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    activityIndicator.center = CGPointMake( self.view.frame.size.width/2,self.view.frame.size.height/2);
    [self->activityIndicator startAnimating];
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
                    totalSupply.text =[NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"total_supply"]];
                    rank.text=[NSString stringWithFormat:@"%@",[[json valueForKey:@"market_data"]valueForKey:@"market_cap_rank"]];
                    //            self->description.text =[NSString stringWithFormat:@"%@",[ok valueForKey:@"en"] ];
                    
                    [self->web setBackgroundColor:[UIColor clearColor]];
                    [self->web loadHTMLString:[ok valueForKey:@"en"] baseURL:nil];
//                    CGFloat scrollViewHeight = 0.0f;
//                    for (UIView* view in web)
//                    {
//                        //scrollViewHeight += web.view.frame.size.height;
//                    }
//                    NSString *result = [self->web stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
//
//                    float height = [result integerValue];
                    self.scrollHeightCons.constant = web.scrollView.contentSize.height;
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
    NSLog(@"scrollViewDidZoom");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   // scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    NSLog(@"scrollViewDidScroll %@",NSStringFromCGPoint(scrollView.contentOffset));
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [scroll release];
    [_scrollHeightCons release];
    [super dealloc];
}
@end
