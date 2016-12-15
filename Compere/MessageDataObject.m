//
//  MessageDataObject.m
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "MessageDataObject.h"

@implementation MessageDataObject

// TODO: populate the properties from json string

- (instancetype)initWithAuthor:(NSString *)author content:(NSString *)content isQuestion:(BOOL)isQuestion voteScore:(NSString *)voteScore textId:(NSString *)textId voted:(BOOL)voted
{
    self = [super init];
    if (self) {
        self.author = author;
        self.content = content;
        self.isQuestion = isQuestion;
        self.voteScore = voteScore;
        self.textId = textId;
        self.voted = voted;
    }
    return self;
}

@end
