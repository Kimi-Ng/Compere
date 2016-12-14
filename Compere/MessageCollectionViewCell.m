//
//  MessageCollectionViewCell.m
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "MessageCollectionViewCell.h"
#import "UIColor+Utilities.h"
#import "ViewConstants.h"

@interface MessageCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *voteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MessageCollectionViewCell

+ (CGSize)cellDefaultSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUpButtons];
}

- (void)setUpButtons
{
    self.voteButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.voteButton setTitleColor:[UIColor colorWithHex:kYahooDarkPurple] forState:UIControlStateNormal];
    self.shareButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.shareButton.titleLabel setTextColor:[UIColor colorWithHex:kYahooDarkPurple]];
    [self.shareButton setTitleColor:[UIColor colorWithHex:kYahooDarkPurple] forState:UIControlStateNormal];
}

- (void)populateCellWithData:(MessageDataObject *)data
{
    
}

- (IBAction)didTapOnVoteButton:(id)sender
{
    self.voteButton.userInteractionEnabled = NO;
    [self.voteButton setBackgroundColor:[UIColor colorWithHex:kYahooLightPurple]];
    [self.voteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (IBAction)didTapOnShareButton:(id)sender {
    NSLog(@"s");
}

@end
