//
//  SuggestionCollectionViewCell.h
//  Compere
//
//  Created by Erin Chuang on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *suggestionLabel;

+ (NSString*)cellReuseIdentifier;
- (void)setVoteButtonScore:(NSString *)score;

@end
