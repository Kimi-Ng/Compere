//
//  ViewConstants.h
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

@interface ViewConstants
typedef NS_ENUM(NSUInteger, TabBarType){
    TabBarComment = 0,
    TabBarQuestion,
    TabBarCounts
};

#define kVideoWidth [UIScreen mainScreen].bounds.size.width
#define kVideoHeight 170
//[UIScreen mainScreen].bounds.size.width/2 - 17
#define kTabBarControllerWidth [UIScreen mainScreen].bounds.size.width
#define kTabBarControllerHeight [UIScreen mainScreen].bounds.size.height - kVideoHeight
#define kTabBarHeight 35
#define kYahooLightPurple @"#A956F8"
#define kYahooDarkPurple @"#8300FF"
#define kMessageCollectionViewCellIdentifier @"MessageCollectionViewCell"
#define kQuestionSectionCellIdentifier @"QuestionSectionCell"
#define kInputViewHeight 40

@end
