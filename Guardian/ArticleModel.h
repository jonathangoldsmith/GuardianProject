//
//  ArticleModel.h
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/18/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (strong, nonatomic) NSString *articleId;
@property (strong ,nonatomic) NSString *webTitle;

@property (strong ,nonatomic) NSString *webURLAsString;
@property (strong, nonatomic) NSString *webPublicationDateAsString;
@property (strong ,nonatomic) NSString *thumbnail;
@property (strong ,nonatomic) NSString *trailText;

@property (strong, nonatomic) NSString *webPublicanDateAsStringForPresentation;
@property (strong, nonatomic) NSURL *webURL;
@property (strong, nonatomic) NSURL *apiURL;

-(id)initWithWebURLAsString:(NSString *)webURLAsString
              webTitle:(NSString *)webTitle
webPublicationDateAsString:(NSString *)webPublicationDateAsString
       thumbnail:(NSString *)thumbnail
                  trailText:(NSString *)trailText;

-(id)initWithDictionary:(NSDictionary *)dictionaryJSON;


@end
