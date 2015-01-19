//
//  ArticleModelsTests.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/19/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ArticleModel.h"

@interface ArticleModelsTests : XCTestCase

@property (strong, nonatomic) ArticleModel *article;

@end

@implementation ArticleModelsTests

- (void)setUp
{
    [super setUp];
    self.article = [[ArticleModel alloc] init];
    self.article.webURLAsString = @"testURL";
    self.article.thumbnail = @"testText";
    self.article.trailText = @"testTrail";
    self.article.webTitle = @"testTitle";

    
}

- (void)tearDown
{
    self.article = nil;
    [super tearDown];
}

- (void)testProductarticleNil
{
    XCTAssertNotNil(self.article, @"article should not be nil");
    XCTAssertNotNil(self.article.webURLAsString, @"webURLAsString should not be nil");
    XCTAssertNotNil(self.article.trailText, @"trailText should not be nil");
    XCTAssertNotNil(self.article.thumbnail, @"thumbnail should not be nil");
    XCTAssertNotNil(self.article.webTitle, @"webTitle should not be nil");

    
}

- (void)testProductarticleValues
{

    XCTAssertEqualObjects(self.article.webURLAsString,
                          @"testURL", @"expected: %@, got%@", @"testURL", self.article.webURLAsString);
    XCTAssertEqualObjects(self.article.thumbnail,
                          @"testText", @"expected: %@, got%@", @"testText", self.article.thumbnail);
    XCTAssertEqualObjects(self.article.trailText,
                          @"testTrail", @"expected: %@, got%@", @"testTrail", self.article.trailText);
    XCTAssertEqualObjects(self.article.webTitle,
                          @"testTitle", @"expected: %@, got%@", @"testTitle", self.article.webTitle);
}

@end
