//
//  Group.h
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject
@property(strong,nonatomic) NSString  *idName;
@property(strong,nonatomic) NSString  *name;
@property(strong,nonatomic) NSString  *image;
@property(nonatomic) float  currentPrice;
@property(nonatomic) float  marketCap;
@property(nonatomic) float  totalVolume;
@property(nonatomic) float  circulationSupply;
@property(nonatomic) int  rank;
@end

NS_ASSUME_NONNULL_END
