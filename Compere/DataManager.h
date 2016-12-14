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

- (void)applyMockData;

@end
