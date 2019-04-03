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
#import <PINRemoteImage/PINRemoteImage.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>
#import <PINCache/PINCache.h>
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
    self.title = @"Coin App";
//
    activityIndicator= [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    // create a queue
    dispatch_queue_t queue = dispatch_queue_create("data_process", 0);
    cc = [[Group alloc] init];
    refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(startFetchingGroups:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
         table.refreshControl =refreshControl;
        //self.mytableView.refreshControl = refreshControl;
    } else {
        //[self.mytableView addSubview:refreshControl];
    }
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

         [manager fetchGroupsAtCoordinate];
        //[manager fetchGroupsAtCoordinate];
       //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startFetchingGroups:) name:NULL object:nil];
        
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
     NSLog(@"reloadingaa");
    [manager fetchGroupsAtCoordinate];
    [refreshControl endRefreshing];
    
}

- (void)didReceiveGroups:(NSArray *)groups
{
  
      group = [[NSArray alloc] initWithArray:groups ];


    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"reloading");
        [self->activityIndicator stopAnimating];
        self->activityIndicator.hidden = YES;
        [self->table reloadData];
    });
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
//    for( Group *cc in group){
//        NSLog(@"%f\n",cc.marketCap);
//    }
   

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] autorelease];
    }
    cc = group [indexPath.row];
  NSURL *url = [[NSURL alloc] initWithString:cc.image];
//    UIImageView *imageView = [[UIImageView alloc] init];
    //[cell.imageView.image pin_setImageFromURL:url];
//    [imageView pin_setImageFromURL:[NSURL URLWithString:@"http://pinterest.com/kitten.jpg"]];
    
    
  //  cell.imageView.alpha = 0.0f;
   // __weak PINImageCell *weakCell = cell;
    
    [cell.imageView pin_setImageFromURL:url placeholderImage:[UIImage imageNamed:@"Default_Image_Thumbnail.png"]];
//    cell.
  // [cell.imageView.image pin_setImageFromURL:[NSURL URLWithString:cc.image]];
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager loadImageWithURL:url
//                      options:0
//                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                         // progression tracking code
//                     }
//                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                        if (image) {
//                            // do something with image
//                        }
//                    }];
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cc.image]
//                      placeholderImage:[UIImage imageNamed:@"Default_Image_Thumbnail.png"]];
    
//    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:url
//                                                        options:0
//                                                       progress:nil
//                                                      completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
//     {
//         if (cell.tag == indexPath.row && image && finished)
//         {
//             dispatch_async(dispatch_get_main_queue(), ^(){
//                 cell.imageView.image = image;
//             });
//
//         }
//     }];
    
//     [cell.imageView setImageWithURL:[NSURL URLWithString:cc.image] andResize:CGSizeMake(30, 30) withContentMode:UIViewContentModeScaleAspectFit];
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cc.image]
//                      placeholderImage:[UIImage imageNamed:@"fa-image.png"]];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiSqYCr8KThAhVCo48KHaPJDAgQjRx6BAgBEAU&url=http%3A%2F%2Ffdiv.net%2F2013%2F05%2F17%2Fgetting-html5-video-work-ios-mobile-safari&psig=AOvVaw1bLl_KsIkgqBfS5wKMi8sa&ust=1553863456202007"]];
 //   NSURL *url = [[NSURL alloc] initWithString:cc.image];
//    if(cell.imageView.image == nil ){
//
//    }
//    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error == nil && data != nil)  {
//
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            cell.imageView.image = [UIImage imageWithData:data];
//                        });
//
////            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
////
////              cell.imageView.image = [UIImage imageWithData:data];
////            }];
//
//        };
//    }] resume];

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
