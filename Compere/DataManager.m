//
//  DataManager.m
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "DataManager.h"
#import "MessageDataObject.h"

static NSString * const kHostUrl = @"http://192.168.2.1:8080/";

@interface DataManager()

@end

@implementation DataManager
+ (DataManager *)sharedInstance
{
    static DataManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)postWithAuthor:(NSString *)author text:(NSString *)text type:(NSString*)type completion:(void (^)(NSString *))completion
{
    if (!author || !author.length || !text || !text.length) {
        return;
    }
    
    NSString *requestUrlString = [NSString stringWithFormat:@"%@%@",kHostUrl,@"add"];
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    NSString *stringData = [NSString stringWithFormat:@"author=%@&text=%@&type=%@",author,text,type];
    NSData *postData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return ;
        }
        NSString *messageId = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(messageId);
            });
        }
    }] resume];
}

- (void)voteWithAuthor:(NSString *)author messageId:(NSString *)messageId
{
    if (!author || !author.length || !messageId || !messageId.length) {
        return;
    }

    NSString *requestUrlString = [NSString stringWithFormat:@"%@%@",kHostUrl,@"vote"];
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    NSString *stringData = [NSString stringWithFormat:@"author=%@&id=%@&vote=1",author,messageId];
    NSData *postData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *votes = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"voteWithAuthor: %@  %@",votes,error);
    }] resume];
}

- (void)getCommentsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion
{
    
    NSString *requestUrlString = [NSString stringWithFormat:@"%@all?author=%@",kHostUrl, author];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return;
        }
        
        //NSDictionary *jsonDict
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.allContentMockDataList = [@[] mutableCopy];
        for (NSDictionary *dict in arr){
            BOOL isQ = [dict[@"type"] isEqualToString:@"q"];
            MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:dict[@"author"] content:dict[@"text"] isQuestion:isQ voteScore:[dict[@"score"] stringValue] textId:[dict[@"id"] stringValue] voted:[dict[@"voted"] boolValue]];
            [self.allContentMockDataList addObject:dataObject];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.allContentMockDataList);
            });
        }
        //RFC 3339 scheme for timestamp
    }
      ] resume];
}

/*
- (void)getRecentQuestionsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion
{
    NSString *requestUrlString = [NSString stringWithFormat:@"http://localhost:8080/recent?author=%@&type=q", author];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //NSDictionary *jsonDict
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.recentQuestionMockDataList = [@[] mutableCopy];
        for (NSDictionary *dict in arr){
            BOOL isQ = [dict[@"type"] isEqualToString:@"q"];
            MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:dict[@"author"] content:dict[@"text"] isQuestion:isQ voteScore:[dict[@"score"] stringValue] textId:[dict[@"id"] stringValue]];
            [self.recentQuestionMockDataList addObject:dataObject];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.recentQuestionMockDataList);
            });
        }
        //RFC 3339 scheme for timestamp
    }
      ] resume];
}

- (void)getTopQuestionsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion
{
    NSString *requestUrlString = [NSString stringWithFormat:@"http://localhost:8080/top?author=%@&type=q", author];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //NSDictionary *jsonDict
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.topQuestionMockDataList = [@[] mutableCopy];
        for (NSDictionary *dict in arr){
            BOOL isQ = [dict[@"type"] isEqualToString:@"q"];
            MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:dict[@"author"] content:dict[@"text"] isQuestion:isQ voteScore:[dict[@"score"] stringValue] textId:[dict[@"id"] stringValue]];
            [self.topQuestionMockDataList addObject:dataObject];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.topQuestionMockDataList);
            });
        }
        //RFC 3339 scheme for timestamp
    }
      ] resume];
}
*/

- (void)getTopAndRecentQuestionsWithAuthor:(NSString *)author completion:(void (^)(NSArray *))completion
{
    dispatch_group_t serviceGroup = dispatch_group_create();
    
    // Start the first service
    dispatch_group_enter(serviceGroup);
    NSString *requestUrlString = [NSString stringWithFormat:@"%@top?author=%@&type=q",kHostUrl, author];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            dispatch_group_leave(serviceGroup);
            return;
        }
        
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.topQuestionMockDataList = [@[] mutableCopy];
        for (NSDictionary *dict in arr){
            BOOL isQ = [dict[@"type"] isEqualToString:@"q"];
            MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:dict[@"author"] content:dict[@"text"] isQuestion:isQ voteScore:[dict[@"score"] stringValue] textId:[dict[@"id"] stringValue] voted:[dict[@"voted"] boolValue]];
            [self.topQuestionMockDataList addObject:dataObject];
        }
        dispatch_group_leave(serviceGroup);
    }
      ] resume];
    
    // Start the second service
    dispatch_group_enter(serviceGroup);
    requestUrlString = [NSString stringWithFormat:@"%@recent?author=%@&type=q",kHostUrl, author];
    requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            dispatch_group_leave(serviceGroup);
            return;
        }
        
        //NSDictionary *jsonDict
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        self.recentQuestionMockDataList = [@[] mutableCopy];
        for (NSDictionary *dict in arr){
            BOOL isQ = [dict[@"type"] isEqualToString:@"q"];
            MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:dict[@"author"] content:dict[@"text"] isQuestion:isQ voteScore:[dict[@"score"] stringValue] textId:[dict[@"id"] stringValue] voted:[dict[@"voted"] boolValue]];
            [self.recentQuestionMockDataList addObject:dataObject];
        }
        dispatch_group_leave(serviceGroup);
    }
      ] resume];

    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        // Assess any errors
        // Now call the final completion block
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.topQuestionMockDataList);
            });
        }
    });
}

- (void)getSimilarWithText:(NSString*)text completion:(void (^)(NSArray *))completion
{
    NSString *requestUrlString = [NSString stringWithFormat:@"%@similar?text=%@",kHostUrl, text];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return;
        }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dict in arr){
            BOOL isQ = [dict[@"type"] isEqualToString:@"q"];
            MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:dict[@"author"] content:dict[@"text"] isQuestion:isQ voteScore:[dict[@"score"] stringValue] textId:[dict[@"id"] stringValue] voted:[dict[@"voted"] boolValue]];
            [dataArray addObject:dataObject];
        }

        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(dataArray);
            });
        }
    }
      ] resume];
}

- (void)getSentimentWithCompletion:(void (^)(NSUInteger))completion
{
    NSString *requestUrlString = [NSString stringWithFormat:@"%@sentiment",kHostUrl];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            return;
        }

        NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"!!! %@",s);
        NSUInteger i = (NSUInteger)([s floatValue] * 10.f);
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(i);
            });
        }
    }
      ] resume];
}
/*
- (void)applyMockData
{
    //name, content,
    NSArray *allContentNameList = @[@"Dale", @"Kimi", @"Arun", @"Neelesh", @"Muru", @"Erin", @"Arun", @"Kimi",@"Dale", @"Erin", @"Kimi",@"Arun",@"Neelesh"];
    // for comment section
    NSArray *allContentList = @[@"wow, that's cute~",
                                @">//<",
                                @"Hi everyone~",
                                @"Why is the host keep laugthing?",
                                @"lol",
                                @"so funny~",
                                @"I love Melody",
                                @"Melody the best",
                                @"Where to buy Melody's T-shirt?",
                                @"Melody! Melody!",
                                @"This program is funny",
                                @"How do I dress for a wedding?",
                                @"Where to buy fashion shoes?"];
    NSArray *allContentTypeList = @[@"c",
                                    @"c",
                                    @"c",
                                    @"q",
                                    @"c",
                                    @"c",
                                    @"c",
                                    @"c",
                                    @"q",
                                    @"c",
                                    @"c",
                                    @"q",
                                    @"q"];
    NSArray *allContentVoteScoreList = @[@"",
                                    @"",
                                    @"",
                                    @"2",
                                    @"",
                                    @"",
                                    @"",
                                    @"",
                                    @"3",
                                    @"",
                                    @"",
                                    @"28",
                                    @"26"];
    NSArray *allTextIdList = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    // recent question
    NSArray *recentQuestionList = @[@"Where to buy Melody's T-shirt?",
                                    @"Why is the host keep laugthing?"];
    NSArray *recentQuestionAuthorList = @[@"Neelesh",
                                          @"Erin"];
    
    NSArray *recentQuestionScoreList = @[@"2", @"3"];
    NSArray *recentQuestionTextIdList = @[@"8", @"3"];
    
    // top question
    NSArray *topQuestionList = @[@"How do I dress for a wedding?",
                                 @"Where to buy fashion shoes?"];
    NSArray *topQuestionScoreList = @[@"28", @"26"];
    NSArray *topQuestionAuthorList = @[@"Dale", @"Erin"];
    NSArray *topQuestionTextIdList = @[@"11",@"12"];
    
    
    self.allContentMockDataList = [[NSMutableArray alloc] initWithCapacity:allContentList.count];
    self.recentQuestionMockDataList = [[NSMutableArray alloc] initWithCapacity:recentQuestionList.count];
    self.topQuestionMockDataList = [[NSMutableArray alloc] initWithCapacity:topQuestionList.count];
    for (int i=0;i<allContentList.count;i++){
        BOOL isQ = [allContentTypeList[i] isEqualToString:@"q"];
        MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:allContentNameList[i] content:allContentList[i] isQuestion:isQ voteScore:allContentVoteScoreList[i] textId:allTextIdList[i]];
        [self.allContentMockDataList addObject:dataObject];
    }
    
    for (int i=0;i<recentQuestionList.count;i++){
        MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:recentQuestionAuthorList[i] content:recentQuestionList[i] isQuestion:YES voteScore:recentQuestionScoreList[i] textId:recentQuestionTextIdList[i]];
        [self.recentQuestionMockDataList addObject:dataObject];
    }
    
    for (int i=0;i<topQuestionList.count;i++){
        MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:topQuestionAuthorList[i] content:topQuestionList[i] isQuestion:YES voteScore:topQuestionScoreList[i] textId:topQuestionTextIdList[i]];
        [self.topQuestionMockDataList addObject:dataObject];
    }
}
*/

@end
