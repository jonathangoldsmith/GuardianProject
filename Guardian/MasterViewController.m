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

static NSString * const BaseURLString = @"http://content.guardianapis.com/search?api-key=nv33sgmbc36mk7xj4eftrajx";

@interface MasterViewController ()

//@property NSMutableArray *objects;
@property(strong, nonatomic) NSArray *articles;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * response = [[NSDictionary alloc] initWithDictionary:[(NSDictionary *)responseObject objectForKey:@"response"]];
        //NSDictionary * responseDict = [responseObject objectForKey:@"response"];
        if(!self.articles) {
            self.articles = [[NSArray alloc] initWithArray:[response objectForKey:@"results"]];
        }
        self.title = @"JSON Retrieved";
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
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
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = self.objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *articleDictionary = [[NSDictionary alloc] initWithDictionary:[self.articles objectAtIndex:indexPath.row]];
    cell.textLabel.text = [articleDictionary objectForKey:@"webTitle"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

@end
