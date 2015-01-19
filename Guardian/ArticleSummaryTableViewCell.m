//
//  ArticleSummaryTableViewCell.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/18/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "ArticleSummaryTableViewCell.h"

@implementation ArticleSummaryTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleText.font = [UIFont fontWithName:@"Verdana-Bold" size:20.0f];
    self.titleText.numberOfLines = 3;
    self.dateText.font = [UIFont fontWithName:@"Verdana" size:7.0f];
    self.trailText.font = [UIFont fontWithName:@"Verdana" size:12.0f];
    self.trailText.numberOfLines = 3;
    self.userInteractionEnabled = YES;
    [self.titleText setNeedsUpdateConstraints];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
