//
//  MeetupManager.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "MeetupManager.h"
#import "Communicator.h"
#import "groupBuilder.h"
#import "Group.h"

@implementation MeetupManager
- (void)fetchGroupsAtCoordinate
{
    [self.communicator getData];
}

- (void)receivedGroupsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [groupBuilder groupsFromJSON:objectNotation error:&error];
    //NSLog(@"hoise");
//    for( Group *cc in groups){
//        NSLog(@"%@\n",cc.name);
//    }
    if (error != nil) {
        [self.delegate fetchingGroupsFailedWithError:error];
        
    } else {
        [self.delegate didReceiveGroups:groups];
    }
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
     NSLog(@"hoi nai");
    [self.delegate fetchingGroupsFailedWithError:error];
}
@end
