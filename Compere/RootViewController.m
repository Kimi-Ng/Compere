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

#define kVideoWidth [UIScreen mainScreen].bounds.size.width
#define kVideoHeight [UIScreen mainScreen].bounds.size.width
#define kTabBarHeight [UIScreen mainScreen].bounds.size.height - kVideoHeight
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    CommentViewController *commentVC = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    QuestionViewController *questionVC = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    
    [tabBarController addChildViewController:commentVC];
    [tabBarController addChildViewController:questionVC];
    [tabBarController setSelectedIndex:0];
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    [tabBarController didMoveToParentViewController:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
