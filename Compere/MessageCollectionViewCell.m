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

- (void)prepareForReuse
{
    self.voteButton.hidden = NO;
}

- (void)setUpButtons
{
    self.avatarImageView.layer.cornerRadius = 20;
    self.avatarImageView.clipsToBounds = YES;
    self.voteButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.voteButton setTitleColor:[UIColor colorWithHex:kYahooDarkPurple] forState:UIControlStateNormal];
    self.shareButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.shareButton.titleLabel setTextColor:[UIColor colorWithHex:kYahooDarkPurple]];
    [self.shareButton setTitleColor:[UIColor colorWithHex:kYahooDarkPurple] forState:UIControlStateNormal];
}

- (void)populateCellWithData:(MessageDataObject *)data
{
    self.nameLabel.text = data.author;
    self.contentLabel.text = data.content;
    if (data.isQuestion) {
        self.voteButton.hidden = NO;
        self.shareButton.hidden =NO;
    } else {
        self.voteButton.hidden = YES;
        self.shareButton.hidden = YES;
    }
    [self.avatarImageView setImage:[UIImage imageNamed:data.author]];
    [self setVoteButtonScore:data.voteScore];
}

- (void)setVoteButtonScore:(NSString *)score
{
    if (score.length == 0){
        self.voteButton.hidden = YES;
    } else {
        self.voteButton.hidden = NO;
        [self.voteButton setTitle:score forState:UIControlStateNormal];
    }
}

- (IBAction)didTapOnVoteButton:(id)sender
{
    self.voteButton.userInteractionEnabled = NO;
    [self.voteButton setBackgroundColor:[UIColor colorWithHex:kYahooLightPurple]];
    [self.voteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSInteger score = [self.voteButton.titleLabel.text integerValue];
    score++;
    [self.voteButton setTitle:[NSString stringWithFormat:@"%ld", score] forState:UIControlStateNormal];
    // Call Post API for vote
    
}

- (IBAction)didTapOnShareButton:(id)sender {
    NSLog(@"s");
}

@end
