//
//  CustomTabBarViewController.m
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "CommentViewController.h"
#import "QuestionViewController.h"
#import "ViewConstants.h"
#import "UIColor+Utilities.h"

@interface CustomTabBarViewController () <UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *commentBarItem;  // tag = 0
@property (weak, nonatomic) IBOutlet UITabBarItem *questionBarItem; // tag = 1
@property (strong, nonatomic) UIViewController *commentViewController;
@property (strong, nonatomic) UIViewController *questionViewController;

@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CommentViewController *commentVC = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    QuestionViewController *questionVC = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    self.commentViewController = commentVC;
    self.questionViewController = questionVC;
    
    [self setChildViewController:commentVC];
    [self setChildViewController:questionVC];
    
    [self setUpTabBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpTabBar
{
    self.tabBar.delegate = self;
    [UITabBar appearance].barTintColor = [UIColor colorWithHex:kYahooLightPurple];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"AmericanTypewriter" size:18.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
}
- (void)setChildViewController:(UIViewController *)vc
{
    [self addChildViewController:vc];
    [vc.view setFrame:CGRectMake(0, kTabBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-kTabBarHeight)];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)setSelectedIndex:(TabBarType)tab
{
    switch(tab) {
            case TabBarQuestion:
                [self setChildViewController:self.questionViewController];
                [self.commentViewController removeFromParentViewController];
            break;
            case TabBarComment:
                [self setChildViewController:self.commentViewController];
                [self.questionViewController removeFromParentViewController];
            default:
            
            break;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0: // comment
            [self setChildViewController:self.commentViewController];
            [self.questionViewController removeFromParentViewController];
            break;
        case 1: // question
            [self setChildViewController:self.questionViewController];
            [self.commentViewController removeFromParentViewController];
            break;
        default:
            break;
    }
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
