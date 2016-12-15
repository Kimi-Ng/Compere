//
//  SuggestionCollectionViewCell.h
//  Compere
//
//  Created by Erin Chuang on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataObject.h"

@protocol SuggestionCollectionViewCellProtocol <NSObject>

- (void)suggestionVoted;

@end

@interface SuggestionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *suggestionLabel;
@property (nonatomic) NSString *textId;
@property (weak, nonatomic) id<SuggestionCollectionViewCellProtocol> delegate;

+ (NSString*)cellReuseIdentifier;
- (void)setVoteButtonScore:(NSString *)score;
- (void)populateCellWithData:(MessageDataObject *)data;
@end
