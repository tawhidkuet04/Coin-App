//
//  groupBuilder.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "groupBuilder.h"
#import "Group.h"

@implementation groupBuilder
+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
  //  NSLog(@"%lu\n",(unsigned long)[parsedObject count]);
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    for( NSDictionary *dict in parsedObject){
        Group *group = [[Group alloc] init];
        [group setValue:[dict valueForKey:@"id"] forKey:@"idName"];
        [group setValue:[dict valueForKey:@"name"] forKey:@"name"];
        [group setValue:[dict valueForKey:@"image"] forKey:@"image"];
//        [group setValue:[dict valueForKey:@"current_price"] forKey:@"currentPrice"];
//        [group setValue:[dict valueForKey:@"market_cap"] forKey:@"marketCap"];
//        [group setValue:[dict valueForKey:@"total_volume"] forKey:@"totalVolume"];
//        [group setValue:[dict valueForKey:@"circulating_supply"] forKey:@"circulationSupply"];
//        [group setValue:[dict valueForKey:@"market_cap_rank"] forKey:@"rank"];
//        [group setValue:[dict valueForKey:@"high_24h"] forKey:@"high"];
//        [group setValue:[dict valueForKey:@"low_24h"] forKey:@"low"];
        [groups addObject:group];
        //NSLog(@"ok");
         //NSLog(@"%@\n",group.name);
    }
//    for( Group *cc in groups){
//        NSLog(@"%@\n",cc.name);
//    }
//
//    NSArray *results = [ parsedObject valueForKey:@"name"];
//    NSLog(@"Count %lu", (unsigned long)results.count);
//  //  NSLog(@"%@",results);
//    for (NSDictionary *groupDic in results) {
//        Group *group = [[Group alloc] init];
//        NSLog(@"%@\n",groupDic);
//       // [group setValue:[groupDic valueForKey:@"symbol"] forKey:@"name"];
//
////        for (NSString *key in groupDic) {
////            if ([group respondsToSelector:NSSelectorFromString(key)]) {
////                [group setValue:[groupDic valueForKey:key] forKey:key];
////            }
////        }
//
//       // [groups addObject:group];
//    }
    
    return groups;
}
@end
