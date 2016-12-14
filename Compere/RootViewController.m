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
#import "InputViewController.h"
#import "UIColor+Utilities.h"
#import "DataManager.h"

#import "CustomTabBarViewController.h"
#import "ViewConstants.h"
#import "DataManager.h"

#define kOFFSET_FOR_KEYBOARD 270.0

static NSString const *kTabBarTintColor = @"0x8300FF";

@interface RootViewController () <InputViewControllerProtocol>
@property (strong, nonatomic) CustomTabBarViewController *tabBarController;
@property (strong, nonatomic) InputViewController *anInputViewController;
@property (strong, nonatomic) VideoViewController *videoController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TODO: GET comments, top questions, recentQuestions
    [[DataManager sharedInstance] getSth];
    
    [self setUpVideoController];
    [self setUpTabBarController];
    [self setUpInputView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpVideoController
{
   VideoViewController *videoVC = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
   self.videoController = videoVC;
   [videoVC.view setFrame:CGRectMake(0, 0, kVideoWidth, kVideoHeight)];
   [self addChildViewController:videoVC];
   [self.view addSubview:videoVC.view];
   [videoVC didMoveToParentViewController:self];
}

- (void)setUpInputView
{
    self.anInputViewController = [[InputViewController alloc] init];
    self.anInputViewController.delegate = self;

    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetMaxY([UIScreen mainScreen].bounds);
    self.anInputViewController.view.frame = CGRectMake(0.f, screenHeight - kInputViewHeight, screenWidth, kInputViewHeight);
    
    [self.view addSubview:self.anInputViewController.view];
    [self addChildViewController:self.anInputViewController];
}

- (void)setUpTabBarController
{
    self.tabBarController = [[CustomTabBarViewController alloc] initWithNibName:@"CustomTabBarViewController" bundle:nil];
    [self.tabBarController.view setFrame:CGRectMake(0, kVideoHeight, kTabBarControllerWidth, kTabBarControllerHeight - kInputViewHeight)];
    [self.tabBarController setSelectedIndex:TabBarComment];
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
    [self.tabBarController didMoveToParentViewController:self];

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

#pragma mark - keyboard events
-(void)keyboardWillShow {
    // Animate the current view out of the way
    [self setViewMovedUp:YES];
}

-(void)keyboardWillHide {
    [self setViewMovedUp:NO];
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.anInputViewController.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    self.anInputViewController.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - InputViewControllerProtocol
- (void)onUserPostMessage:(MessageDataObject*)message
{
    [[DataManager sharedInstance].allContentMockDataList addObject:message];
    [self.tabBarController.commentViewController refreshContent];
}

@end
