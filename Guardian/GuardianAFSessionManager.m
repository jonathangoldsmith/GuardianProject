//
//  GuardianAFSessionManager.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/17/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "GuardianAFSessionManager.h"

@implementation GuardianAFSessionManager

+(instancetype)sharedClient
{
    static GuardianAFSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GuardianAFSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://content.guardianapis.com/"]];
        
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

@end
