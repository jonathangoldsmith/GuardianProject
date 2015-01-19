//
//  DetailViewController.h
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/16/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) ArticleModel* article;

@end

