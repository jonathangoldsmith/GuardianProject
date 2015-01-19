//
//  ArticleSummaryTableViewCellTests.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/19/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ArticleSummaryTableViewCell.h"

@interface ArticleSummaryTableViewCellTests : XCTestCase

@property (nonatomic, strong) ArticleSummaryTableViewCell *testCell;

@end

@implementation ArticleSummaryTableViewCellTests

- (void)setUp
{
    [super setUp];
    self.testCell = [[ArticleSummaryTableViewCell alloc] init];
    
    UILabel *titleText = [[UILabel alloc] init];
    [self.testCell addSubview:titleText];
    self.testCell.titleText = titleText;
    
    UILabel *trailText = [[UILabel alloc] init];
    [self.testCell addSubview:trailText];
    self.testCell.trailText = trailText;
    
    UILabel *dateText = [[UILabel alloc] init];
    [self.testCell addSubview:dateText];
    self.testCell.dateText = dateText;
    
    UIImageView *thumbnail = [[UIImageView alloc] init];
    [self.testCell addSubview:thumbnail];
    self.testCell.thumbnail = thumbnail;
    
}

- (void)tearDown
{
    self.testCell= nil;
    [super tearDown];
}

- (void)testProperties
{
    XCTAssertNotNil(self.testCell, @"testCell should not be nil");
    XCTAssertNotNil(self.testCell.titleText, @"testCell's leftLabel should not be nil");
    XCTAssertNotNil(self.testCell.trailText, @"testCell's rightLabel should not be nil");
    XCTAssertNotNil(self.testCell.dateText, @"testCell's rightLabel should not be nil");
    XCTAssertNotNil(self.testCell.thumbnail, @"testCell's rightLabel should not be nil");

}

- (void)testFunctions
{
    XCTAssertNoThrow([self.testCell setSelected:NO animated:NO], @"setSelected should not throw an exception");
    XCTAssertNoThrow([self.testCell awakeFromNib], @"awake from nib should not throw");
    
}

@end
