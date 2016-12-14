//
//  MessageDataObject.h
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDataObject : NSObject
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *avatarImage;
@property (strong, nonatomic) NSString *content;
@property (assign, nonatomic) BOOL isQuestion;
@property (strong, nonatomic) NSString *voteScore;

- (instancetype)initWithAuthor:(NSString *)author content:(NSString *)content isQuestion:(BOOL)isQuestion voteScore:(NSString *)voteScore;

//TODO: add more properties for api

@end
