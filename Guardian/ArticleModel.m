//
//  ArticleModel.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/18/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

static NSDateFormatter *    sUserVisibleDateFormatter;


-(id)initWithWebURLAsString:(NSString *)webURLAsString
                   webTitle:(NSString *)webTitle
 webPublicationDateAsString:(NSString *)webPublicationDateAsString
                  thumbnail:(NSString *)thumbnail
                  trailText:(NSString *)trailText;
{
    if (self = [super init])
    {
        _webTitle = webTitle;
        _webURLAsString = webURLAsString;
        _webPublicationDateAsString = [self webPublicanDateAsStringForPresentation:webPublicationDateAsString];
        _thumbnail = thumbnail;
        _trailText = [trailText stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
        _trailText = [_trailText stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];

        _webURL = [NSURL URLWithString:_webURLAsString];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionaryJSON
{
    
    return [self initWithWebURLAsString:dictionaryJSON[@"webUrl"]
                          webTitle:dictionaryJSON[@"webTitle"]
        webPublicationDateAsString:dictionaryJSON[@"webPublicationDate"]
                   thumbnail:dictionaryJSON[@"fields"][@"thumbnail"]
    trailText:dictionaryJSON[@"fields"][@"trailText"]];
    
}

#pragma mark - setters + getters


//https://developer.apple.com/library/ios/qa/qa1480/_index.html
//Parsing the web date

-(NSString *)webPublicanDateAsStringForPresentation:(NSString *)rfc3339DateTimeString
{
    static NSDateFormatter *    sRFC3339DateFormatter;
    NSString *                  userVisibleDateTimeString;
    NSDate *                    date;
    
    // If the date formatters aren't already set up, do that now and cache them
    // for subsequence reuse.
    
    if (sRFC3339DateFormatter == nil) {
        NSLocale *                  enUSPOSIXLocale;
        
        sRFC3339DateFormatter = [[NSDateFormatter alloc] init];
        
        enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        
        [sRFC3339DateFormatter setLocale:enUSPOSIXLocale];
        [sRFC3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    if (sUserVisibleDateFormatter == nil) {
        sUserVisibleDateFormatter = [[NSDateFormatter alloc] init];
        
        [sUserVisibleDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [sUserVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    // Convert the RFC 3339 date time string to an NSDate.
    // Then convert the NSDate to a user-visible date string.
    
    userVisibleDateTimeString = nil;
    
    date = [sRFC3339DateFormatter dateFromString:rfc3339DateTimeString];
    if (date != nil) {
        userVisibleDateTimeString = [sUserVisibleDateFormatter stringFromDate:date];
    }
    return userVisibleDateTimeString;
}

@end
