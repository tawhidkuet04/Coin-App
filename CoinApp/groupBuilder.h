//
//  groupBuilder.h
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface groupBuilder : NSObject
+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
