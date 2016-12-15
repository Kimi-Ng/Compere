//
//  VideoViewController.m
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "VideoViewController.h"
#import "DataManager.h"

@interface VideoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sentimentImageView;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(reflectUserSentiment)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reflectUserSentiment
{
    [[DataManager sharedInstance] getSentimentWithCompletion:^(NSUInteger sentiment) {
        if (sentiment < 5) {
            [self.sentimentImageView setImage:[UIImage imageNamed:@"guest-2"]];
        } else {
            [self.sentimentImageView setImage:[UIImage imageNamed:@"guest-4"]];
        }
    }];
}

@end
