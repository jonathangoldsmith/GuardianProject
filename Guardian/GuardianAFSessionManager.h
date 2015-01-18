//
//  GuardianAFSessionManager.h
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/17/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface GuardianAFSessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;
- (instancetype)initWithBaseURL:(NSURL *)url;


@end
