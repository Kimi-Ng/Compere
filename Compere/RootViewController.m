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


static NSString const *kTabBarTintColor = @"0x8300FF";


@interface RootViewController ()
@property (strong, nonatomic) UITabBarController *tabBarController;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpVideoController];
    [self setUpTabBarController];
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

- (void)setUpTabBarController
{

    CustomTabBarViewController *tabBarController = [[CustomTabBarViewController alloc] initWithNibName:@"CustomTabBarViewController" bundle:nil];
    [tabBarController.view setFrame:CGRectMake(0, kVideoHeight, kTabBarControllerWidth, kTabBarControllerHeight)];
    [tabBarController setSelectedIndex:TabBarComment];
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    [tabBarController didMoveToParentViewController:self];
/*
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate = self;
    [tabBarController.view setFrame:CGRectMake(0, kVideoHeight, kTabBarControllerWidth, kTabBarControllerHeight)];
    
    UIImage *bgImage = [self createImageWithSolidColor:[UIColor whiteColor] size:CGSizeMake(kTabBarControllerWidth, kTabBarHeight)];
    //self.tabBarController.tabBar.appearance.backgroundColor = [UIColor grayColor];
    [tabBarController.tabBar setBackgroundImage:bgImage];
    //tabBarController.tabBar.tintColor = [UIColor blueColor];//colorWithHex:kTabBarTintColor];
    //self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    //self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    //[[self.tabBarController.tabBar appearance] setTintColor:[UIColor redColor]];
    //self.tabBarController.tabBar.appearance.tintColor = [UIColor redColor];//colorWithHex:kTabBarTintColor];
    [tabBarController.navigationItem setTitle:@""];
    
    CGRect tabBarFrame = tabBarController.tabBar.frame;
    tabBarFrame = CGRectMake(0, 0, CGRectGetWidth(tabBarController.tabBar.frame), CGRectGetHeight(tabBarController.tabBar.frame));

    [tabBarController.tabBar setFrame:tabBarFrame];
    
    [tabBarController addChildViewController:[self setUpCommentViewController]];
    [tabBarController addChildViewController:[self setUpQuestionViewController]];
    [tabBarController setSelectedIndex:0];
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    [tabBarController didMoveToParentViewController:self];
    self.tabBarController = tabBarController;
    */
}

//- (UIViewController *)setUpCommentViewController
//{
//    CommentViewController *commentVC = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
//    commentVC.tabBarItem.tag = 1;
//    commentVC.tabBarItem.title = @"Comments";
//    [commentVC.view setFrame:CGRectMake(0, kTabBarHeight, 0, 0)];
//    //commentVC.tabBarItem.titlePositionAdjustment
//    // TODO: set image
//    //commentVC.tabBarItem.image = [UIImage imageNamed:@"tabbar-tv"];
//    return commentVC;
//}
//
//- (UIViewController *)setUpQuestionViewController
//{
//    QuestionViewController *questionVC = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
//    questionVC.tabBarItem.tag = 1;
//    questionVC.tabBarItem.title = @"Questions";
//    // TODO: set image
//    //questionVC.tabBarItem.image = [UIImage imageNamed:@"tabbar-tv"];
//    return questionVC;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
