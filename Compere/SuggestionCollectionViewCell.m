//
//  SuggestionCollectionViewCell.m
//  Compere
//
//  Created by Erin Chuang on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "SuggestionCollectionViewCell.h"
#import "ViewConstants.h"
#import "UIColor+Utilities.h"

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
    [self setUpButtons];
    self.suggestionLabel.text = @"";
}

- (void)setUpButtons
{
    self.voteButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.voteButton setTitleColor:[UIColor colorWithHex:kYahooLightPurple] forState:UIControlStateNormal];
    self.shareButton.layer.borderColor = [UIColor colorWithHex:kYahooLightPurple].CGColor;
    [self.shareButton.titleLabel setTextColor:[UIColor colorWithHex:kYahooLightPurple]];
    [self.shareButton setTitleColor:[UIColor colorWithHex:kYahooDarkPurple] forState:UIControlStateNormal];
    
    UIImage *img = [self image:[UIImage imageNamed:@"share-icon"] replaceColor:[UIColor colorWithHex:kYahooLightPurple]];
    [self.shareButton setImage:img forState:UIControlStateNormal];
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

- (IBAction)didTapOnVoteButton:(id)sender {
    //[self setVoteButtonScore
}

- (IBAction)didTapOnShareButton:(id)sender {
}

@end
