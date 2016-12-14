//
//  SuggestionCollectionViewCell.m
//  Compere
//
//  Created by Erin Chuang on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "SuggestionCollectionViewCell.h"

@interface SuggestionCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *voteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation SuggestionCollectionViewCell

+ (NSString*)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.suggestionLabel.text = @"";
}

@end
