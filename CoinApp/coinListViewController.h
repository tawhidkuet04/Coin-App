//
//  coinListViewController.h
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#
NS_ASSUME_NONNULL_BEGIN

@interface coinListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    bool flag ;
    UIActivityIndicatorView *activityIndicator ;
}
@property (nonatomic, strong) NSOperationQueue *queue;
@end

NS_ASSUME_NONNULL_END
