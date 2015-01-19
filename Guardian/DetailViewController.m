//
//  DetailViewController.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/16/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "DetailViewController.h"
#import "SCNetworkReachability.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_article != newDetailItem) {
        _article = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)configureView {
    [self TestReachability];
    if (self.article) {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.article.webURL];
        [self.webView loadRequest:urlRequest];
    }
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate = self;
    self.webView.frame = self.view.frame;
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
