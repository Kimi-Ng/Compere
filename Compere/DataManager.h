//
//  DataManager.h
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (strong, nonatomic) NSMutableArray *allContentMockDataList;
@property (strong, nonatomic) NSMutableArray *recentQuestionMockDataList;
@property (strong, nonatomic) NSMutableArray *topQuestionMockDataList;

+ (DataManager *)sharedInstance;

//- (void)applyMockData; // for testing


//- (void)getTopQuestionsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion;
//- (void)getRecentQuestionsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion;
- (void)getTopAndRecentQuestionsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion;
- (void)getCommentsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion;
- (void)getSimilarWithText:(NSString*)text completion:(void (^)(NSArray *))completion;
- (void)getSentimentWithCompletion:(void (^)(NSUInteger))completion;
- (void)postWithAuthor:(NSString *)author text:(NSString *)text type:(NSString*)type completion:(void (^)(NSString *))completion;
- (void)voteWithAuthor:(NSString *)author messageId:(NSString *)messageId;

@end
