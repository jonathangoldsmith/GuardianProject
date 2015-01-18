//
//  GuardianController.h
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/17/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuardianController : NSObject

-(void)loadArticlesWithParameters:(NSDictionary *)parameters
                             path:(NSString *)path
                           ofType:(NSString *)type
               andCompletionBlock:(void (^)(NSArray *array, BOOL success, NSError *error))completionBlock;
@end
