//
//  Communicator.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "Communicator.h"
#import "CommunicatorDelegate.h"

@implementation Communicator
-(void)getData{
    NSString *urlString = [ NSString stringWithFormat:@"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"];
    NSURL  *url = [ [NSURL alloc] initWithString:urlString];
  //  NSLog(@"%@",url);
//    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        if (error) {
//            [self.delegate fetchingGroupsFailedWithError:error];
//        } else {
//            [self.delegate receivedGroupsJSON:data];
//        }
//    }];
//
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error == nil )  {
                [self.delegate receivedGroupsJSON:data];
                }else {
                    
                     [self.delegate fetchingGroupsFailedWithError:error];
                    
                };
            }] resume];
    
    
    
}
@end
