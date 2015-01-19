//
//  ArticleSummaryTableViewCell.h
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/18/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface ArticleSummaryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *trailText;
@property (weak, nonatomic) IBOutlet UILabel *dateText;

@end
