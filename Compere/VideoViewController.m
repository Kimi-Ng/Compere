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
@property (nonatomic) NSArray *sentimentMap;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sentimentMap = @[@"vsad",
                          @"vsad",
                          @"sad2",
                          @"sad2",
                          @"neutral",
                          @"neutral",
                          @"happy2",
                          @"happy2",
                          @"vhappy",
                          @"vhappy",
                          @"vhappy"];
    [NSTimer scheduledTimerWithTimeInterval:1.0
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
        NSString *imageName = self.sentimentMap[sentiment];
        [self.sentimentImageView setImage:[UIImage imageNamed:imageName]];
//        if (sentiment < 5) {
//            [self.sentimentImageView setImage:[UIImage imageNamed:@"sad_black"]];
//        } else {
//            [self.sentimentImageView setImage:[UIImage imageNamed:@"happy_yellow"]];
//        }
    }];
}

@end
