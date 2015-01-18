//
//  GuardianController.m
//  Guardian
//
//  Created by Jonathan Goldsmith on 1/17/15.
//  Copyright (c) 2015 JonathanGoldsmith. All rights reserved.
//

#import "GuardianController.h"
#import "GuardianAFSessionManager.h"
#import "AFNetworking/AFNetworking.h"

@implementation GuardianController


-(void)loadArticlesWithParameters:(NSDictionary *)parameters
                             path:(NSString *)path
                           ofType:(NSString *)type
               andCompletionBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock
{
    NSMutableDictionary *workingParameters = [[NSMutableDictionary alloc] init];
    
    [workingParameters addEntriesFromDictionary:parameters];
    [workingParameters setObject:@"nv33sgmbc36mk7xj4eftrajx" forKey:@"api-key"];
    
    //might end up using this
    
    /*AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
[[GuardianAFSessionManager sharedClient] registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [[GuardianAFSessionManager sharedClient] setDefaultHeader:@"Accept" value:@"application/json"];
    
    
    [[GuardianAFSessionManager sharedClient] getPath:path
                                      parameters:[workingParameters copy]
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSDictionary *responseObjectDictionary =(NSDictionary *)responseObject;
                                             NSDictionary *responseDictionary = responseObjectDictionary[@"response"];
                                             
                                             NSMutableArray *finalArray = [[NSMutableArray alloc] init];
                                             
                                             if ([type isEqualToString:@"editorsPicks"])
                                             {
                                                 NSArray *editorsPickArray = (NSArray *)responseDictionary[@"editorsPicks"];
                                                 
                                                 for (NSDictionary *articleObj in editorsPickArray)
                                                 {
                                                     Article *article = [[Article alloc] initWithDictionary:articleObj];
                                                     [finalArray addObject:article];
                                                 }
                                                 
                                             } else if ([type isEqualToString:@"sections"])
                                             {
                                                 
                                                 NSArray *sectionsResultsArray = (NSArray *)responseDictionary[@"results"];
                                                 
                                                 for (NSDictionary *sectionObj in sectionsResultsArray)
                                                 {
                                                     Section *section = [[Section alloc] initWithJSONDictionary:sectionObj];
                                                     if ([[self goodSections] containsObject:section.sectionID])
                                                     {
                                                         [finalArray addObject:section];
                                                     }
                                                     
                                                 }
                                             } else if ([type isEqualToString:@"articles"])
                                             {
                                                 NSArray *articlesArray = (NSArray *)responseDictionary[@"results"];
                                                 
                                                 for (NSDictionary *articleObj in articlesArray)
                                                 {
                                                     Article *article = [[Article alloc] initWithDictionary:articleObj];
                                                     [finalArray addObject:article];
                                                 }
                                             }
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock([finalArray copy], YES, nil);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock([NSArray array], NO, error);
                                             }
                                             
                                         }];
    */
}

@end
