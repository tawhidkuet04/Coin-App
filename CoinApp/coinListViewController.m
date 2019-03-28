//
//  coinListViewController.m
//  CoinApp
//
//  Created by Tawhid Joarder on 3/27/19.
//  Copyright © 2019 Tawhid Joarder. All rights reserved.
//

#import "coinListViewController.h"
#import "Group.h"
#import "deatailData.h"
#import "Communicator.h"
#import "MeetupManager.h"
#import "AppDelegate.h"


@interface coinListViewController ()<UISplitViewControllerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>{
    NSArray *group;
    MeetupManager *manager;
    IBOutlet UITableView *table;
    Group *cc ;
    
}

@end

@implementation coinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    int SCREEN_HEIGHT = [UIScreen mainScreen].bounds.size.height;
//    int SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
//    [activityIndicator setCenter:CGPointMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/4)];
//    [self.view addSubview:activityIndicator];
//    [activityIndicator startAnimating];
//
    activityIndicator= [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    // create a queue
    dispatch_queue_t queue = dispatch_queue_create("data_process", 0);
    cc = [[Group alloc] init];
    // send a block to the queue - Not in Main thread
    dispatch_async(queue, ^{
        // data processing
        
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 4;
        
        self->manager = [[MeetupManager alloc] init];
        self->manager.communicator = [[Communicator alloc] init];
        self->manager.communicator.delegate = self->manager;
        self->manager.delegate = self;
        NSLog(@"asdasd");
        //[manager fetchGroupsAtCoordinate];
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startFetchingGroups:) name:NULL object:nil];
        
        // Interaction with User Interface - Main thread
        
    });
    
            // code that updates UI goes here

//    NSError *error;
//    NSString *url_string = [NSString stringWithFormat: @"https://api.coingecko.com/api//v3/coins/markets?vs_currency=usd"];
//    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
//    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    NSLog(@"json: %@", json);
    // Do any additional setup after loading the view from its nib.
   
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                            selector:@selector(startFetchingGroups:)
//                                               name:@"kCLAuthorizationStatusAuthorized"
//                                              object:nil];
  //  NSLog(@"oioio");
   // NSLog(@"%@",group);
 
//    for( Group *cc in group){
//        NSLog(@"%@\n",cc.name);
//    }
}

- (void)startFetchingGroups:(NSNotification *)notification
{
    [manager fetchGroupsAtCoordinate];
    
}

- (void)didReceiveGroups:(NSArray *)groups
{
    
    group = [[NSArray alloc] initWithArray:groups ];
    flag = true ;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [activityIndicator stopAnimating];
        activityIndicator.hidden = YES;
        [self->table reloadData];
    });
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
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

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [ [UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" ];
    }
    
    cc = group [indexPath.row]; ;
    NSURL *url = [[NSURL alloc] initWithString:cc.image];
    if(cell.imageView.image == nil ){
        
    }
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil)  {
            
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                self.imageView.image = [UIImage imageWithData:data];
            //            });
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{

               cell.imageView.image = [UIImage imageWithData:data];
            }];
            
        };
    }] resume];

//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: cc.image]];
//    cell.imageView.image = [UIImage imageWithData: imageData];
    cell.textLabel.text = cc.name;
    return cell ;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [group count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"clicked\n");
    deatailData *con = [[deatailData alloc] init ];
    con.coin = group[indexPath.row];
    [self.navigationController pushViewController:con animated:YES ];
    
}


@end
