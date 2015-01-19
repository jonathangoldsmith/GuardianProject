//
//  ArticleSummaryTableViewCellManager.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/19/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "ArticleSummaryTableViewCellManager.h"
#import "ArticleSummaryTableViewCell.h"

@interface ArticleSummaryTableViewCellManager ()

@property (nonatomic) ArticleSummaryTableViewCell *cell;
@property (nonatomic) NSString *text;

@end

@implementation ArticleSummaryTableViewCellManager

//
//-(id)initWithText:(NSString *)text {
//    if (self = [super init]) {
//        self.text = text;
//        self.cellNib = [UINib nibWithNibName:@"RMBMCOMPDVPromoCell" bundle:nil];
//        self.currentHeight = [self calculateHeight];
//        self.cellIdentifier = @"RMBMCOMPDVPromoCell";
//    }
//    
//    return self;
//}
//
//-(void)setupCell:(UITableViewCell *)givenCell {
//    [super setupCell:givenCell];
//    
//    self.cell = (RMBMCOMPDVPromoCell *)givenCell;
//    [self.cell updateDescriptionText:self.text];
//    self.currentHeight = self.cell.height;
//    self.needsRefresh = YES;
//}
//
//- (CGFloat)calculateHeight {
//    RMBMCOMPDVPromoCell *dummyCell = [self.cellNib instantiateWithOwner:self options:nil][0];
//    dummyCell.labelDescription.font = [UIFont systemFontOfSize:12.0f];
//    dummyCell.labelDescription.textColor = [RMBColorHelper macysRed];
//    dummyCell.labelDescription.preferredMaxLayoutWidth = dummyCell.labelDescription.frame.size.width;
//    [dummyCell.labelDescription setNeedsUpdateConstraints];
//    [dummyCell rmb_separatorLine];
//    
//    dummyCell.labelDescription.text = self.text;
//    [dummyCell setNeedsLayout];
//    [dummyCell layoutIfNeeded];
//    
//    return [dummyCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 2.0f;
//}

@end
