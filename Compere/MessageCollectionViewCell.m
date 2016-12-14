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
    [self.voteButton setTitleColor:[UIColor colorWithHex:kYahooLightPurple] forState:UIControlStateNormal];
    self.shareButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.shareButton.titleLabel setTextColor:[UIColor colorWithHex:kYahooLightPurple]];
    [self.shareButton setTitleColor:[UIColor colorWithHex:kYahooDarkPurple] forState:UIControlStateNormal];
    
    UIImage *img = [self image:[UIImage imageNamed:@"share-icon"] replaceColor:[UIColor colorWithHex:kYahooLightPurple]];
    [self.shareButton setImage:img forState:UIControlStateNormal];
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


- (UIImage *)image:(UIImage *)image replaceColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextTranslateCTM(contextRef, 0.0f, image.size.height);
    CGContextScaleCTM(contextRef, 1.0f,  -1.0f);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    CGContextDrawImage(contextRef, drawRect, image.CGImage);
    CGContextClipToMask(contextRef, drawRect, image.CGImage);
    CGContextAddRect(contextRef, drawRect);
    CGContextDrawPath(contextRef, kCGPathFill);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //keep original scale and orientation property
    return [UIImage imageWithCGImage:[resultImage CGImage] scale:image.scale orientation:image.imageOrientation];
}

@end
