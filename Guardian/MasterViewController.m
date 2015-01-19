//
//  MasterViewController.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/16/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AFNetworking.h"
#import "ArticleModel.h"
#import "ArticleSummaryTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SCNetworkReachability.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>


static NSString * const URLString = @"http://content.guardianapis.com/search?api-key=nv33sgmbc36mk7xj4eftrajx&show-fields=all";

@interface MasterViewController ()

@property(strong, nonatomic) NSArray *articles;
@property(strong, nonatomic) NSMutableArray *articleArray;


@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if([self hasConnectivity] == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Stream"
                                                            message:@"You do not have an internet connection"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * response = [[NSDictionary alloc] initWithDictionary:[(NSDictionary *)responseObject objectForKey:@"response"]];
        if(!self.articles) {
            self.articles = [[NSArray alloc] initWithArray:[response objectForKey:@"results"]];
        }
        self.articleArray = [[NSMutableArray alloc] init];
        for (NSDictionary *articleObj in self.articles)
        {
            ArticleModel *article = [[ArticleModel alloc] initWithDictionary:articleObj];
            [self.articleArray addObject:article];
        }
        self.title = @"Guardian";
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Stream"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        DetailViewController *dvc = (DetailViewController *)segue.destinationViewController;
        dvc.article = [self.articleArray objectAtIndex:indexPath.row];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView registerNib:[UINib nibWithNibName:@"ArticleSummaryTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    ArticleSummaryTableViewCell *articleCell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    return articleCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ArticleSummaryTableViewCell *)articleCell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleModel *article = [self.articleArray objectAtIndex:indexPath.row];
    articleCell.titleText.text = @"";
    articleCell.titleText.text = article.webTitle;
    articleCell.dateText.text = article.webPublicationDateAsString;
    articleCell.trailText.text = article.trailText;
    [articleCell.thumbnail sd_setImageWithURL:[NSURL URLWithString:article.thumbnail]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self.view];
}

-(BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

@end
