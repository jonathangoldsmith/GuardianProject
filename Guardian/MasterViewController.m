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


static NSString * const URLString = @"http://content.guardianapis.com/search?api-key=nv33sgmbc36mk7xj4eftrajx&show-fields=all";

@interface MasterViewController ()

//@property NSMutableArray *objects;
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
    [self TestReachability];
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
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving stream"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)TestReachability {
    SCNetworkReachability *reachability = [[SCNetworkReachability alloc] initWithHost:@"http://content.guardianapis.com"];
    [reachability reachabilityStatus:^(SCNetworkStatus status)
    {
        switch (status)
        {
            case SCNetworkStatusReachableViaWiFi:
                NSLog(@"Reachable via WiFi");
                break;
                
            case SCNetworkStatusReachableViaCellular:
                NSLog(@"Reachable via Cellular");
                break;
                
            case SCNetworkStatusNotReachable:
                NSLog(@"Not Reachable");
                break;
        }
    }];
}

@end
