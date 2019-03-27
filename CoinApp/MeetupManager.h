//
//  MeetupManager.h
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicatorDelegate.h"
#import "MeetupManagerDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@class Communicator;

@interface MeetupManager : NSObject
@property (strong, nonatomic) Communicator *communicator;
@property (weak, nonatomic) id delegate;
- (void)fetchGroupsAtCoordinate;
@end

NS_ASSUME_NONNULL_END
