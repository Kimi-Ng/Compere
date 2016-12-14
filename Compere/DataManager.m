//
//  DataManager.m
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "DataManager.h"
#import "MessageDataObject.h"
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

- (void)getSth
{

    NSString *requestUrlString;// = [NSString stringWithFormat:@"%@?lang=%@&region=%@&device=ios&version=%@", APICardHomeBaseUrl, APILanguage, APIRegion, version];
    NSURL *requestURL = [NSURL URLWithString:requestUrlString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSArray *widgetArray = jsonDict[@"widgets"][@"result"];
        
        for(NSDictionary *widget in widgetArray) {
        //parse the json
        }
    }
    ] resume];

}

- (void)applyMockData
{
    //name, content,
    NSArray *allContentNameList = @[@"Dale", @"Kimi", @"Arun", @"Neelesh", @"Muru", @"Erin", @"Arun", @"Kimi",@"Dale", @"Erin", @"Kimi"];
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
                                @"This program is funny"];
    NSArray *allContentTypeList = @[@"C",
                                    @"C",
                                    @"C",
                                    @"Q",
                                    @"C",
                                    @"C",
                                    @"C",
                                    @"C",
                                    @"Q",
                                    @"C",
                                    @"C"];
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
                                    @""];
    // recent question
    NSArray *recentQuestionList = @[@"Where to buy Melody's T-shirt?",
                                    @"Why is the host keep laugthing?"];
    NSArray *recentQuestionAuthorList = @[@"Neelesh",
                                          @"Erin"];
    
    NSArray *recentQuestionScoreList = @[@"2", @"3"];
    
    // top question
    NSArray *topQuestionList = @[@"How do I dress for a wedding?"];
    NSArray *topQuestionScoreList = @[@"28"];
    NSArray *topQuestionAuthorList = @[@"Dale"];
    
    
    self.allContentMockDataList = [[NSMutableArray alloc] initWithCapacity:allContentList.count];
    self.recentQuestionMockDataList = [[NSMutableArray alloc] initWithCapacity:recentQuestionList.count];
    self.topQuestionMockDataList = [[NSMutableArray alloc] initWithCapacity:topQuestionList.count];
    for (int i=0;i<allContentList.count;i++){
        BOOL isQ = [allContentTypeList[i] isEqualToString:@"Q"];
        MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:allContentNameList[i] content:allContentList[i] isQuestion:isQ voteScore:allContentVoteScoreList[i]];
        [self.allContentMockDataList addObject:dataObject];
    }
    
    for (int i=0;i<recentQuestionList.count;i++){
        MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:recentQuestionAuthorList[i] content:recentQuestionList[i] isQuestion:YES voteScore:recentQuestionScoreList[i]];
        [self.recentQuestionMockDataList addObject:dataObject];
    }
    
    for (int i=0;i<topQuestionList.count;i++){
        MessageDataObject *dataObject = [[MessageDataObject alloc] initWithAuthor:topQuestionAuthorList[i] content:topQuestionList[i] isQuestion:YES voteScore:topQuestionScoreList[i]];
        [self.topQuestionMockDataList addObject:dataObject];
    }
    
    
    
}


@end
