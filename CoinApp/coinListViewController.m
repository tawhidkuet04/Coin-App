//
//  coinListViewController.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "coinListViewController.h"
#import "Group.h"
#import "Communicator.h"
#import "MeetupManager.h"

@interface coinListViewController (){
    NSArray *group;
    MeetupManager *manager;
}

@end

@implementation coinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSError *error;
//    NSString *url_string = [NSString stringWithFormat: @"https://api.coingecko.com/api//v3/coins/markets?vs_currency=usd"];
//    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
//    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    NSLog(@"json: %@", json);
    // Do any additional setup after loading the view from its nib.
    manager = [[MeetupManager alloc] init];
    manager.communicator = [[Communicator alloc] init];
    manager.communicator.delegate = manager;
    manager.delegate = self;
    NSLog(@"asdasd");
    //[manager fetchGroupsAtCoordinate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startFetchingGroups:) name:NULL object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                            selector:@selector(startFetchingGroups:)
//                                               name:@"kCLAuthorizationStatusAuthorized"
//                                              object:nil];
    NSLog(@"oioio");
   // NSLog(@"%@",group);
 
    for( Group *cc in group){
        NSLog(@"%@\n",cc.name);
    }
}

- (void)startFetchingGroups:(NSNotification *)notification
{
    [manager fetchGroupsAtCoordinate];
    
}
- (void)didReceiveGroups:(NSArray *)groups
{
    NSLog(@"xx");
    group = [[NSArray alloc] initWithArray:groups ];
//    for( Group *cc in group){
//        NSLog(@"%f\n",cc.marketCap);
//    }
   
    

}
- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
