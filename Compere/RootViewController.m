//
//  RootViewController.m
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "RootViewController.h"
#import "VideoViewController.h"
#import "CommentViewController.h"
#import "QuestionViewController.h"
#import "UIColor+Utilities.h"

#import "CustomTabBarViewController.h"
#import "ViewConstants.h"
#import "DataManager.h"


static NSString const *kTabBarTintColor = @"0x8300FF";


@interface RootViewController ()
@property (strong, nonatomic) UITabBarController *tabBarController;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TODO: GET comments, top questions, recentQuestions
    
    [self setUpVideoController];
    [self setUpTabBarController];
    [self setUpInputView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpVideoController
{
   VideoViewController *videoVC = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
   [videoVC.view setFrame:CGRectMake(0, 0, kVideoWidth, kVideoHeight)];
   [self addChildViewController:videoVC];
   [self.view addSubview:videoVC.view];
   [videoVC didMoveToParentViewController:self];
}

- (void)setUpInputView
{
    // TODO
    // Use kInputViewHeight
}

- (void)setUpTabBarController
{
    CustomTabBarViewController *tabBarController = [[CustomTabBarViewController alloc] initWithNibName:@"CustomTabBarViewController" bundle:nil];
    [tabBarController.view setFrame:CGRectMake(0, kVideoHeight, kTabBarControllerWidth, kTabBarControllerHeight - kInputViewHeight)];
    [tabBarController setSelectedIndex:TabBarComment];
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    [tabBarController didMoveToParentViewController:self];

}

#pragma mark - helpers

- (UIImage *)createImageWithSolidColor:(UIColor *)color size:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [color set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}


@end
