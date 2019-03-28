//
//  deatailData.h
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface deatailData : UIViewController{    
    UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic) Group *coin;
-(void)downloadData:(NSString *)url_string;

@end

NS_ASSUME_NONNULL_END
