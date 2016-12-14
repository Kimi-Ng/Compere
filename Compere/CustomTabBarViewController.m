//
//  CustomTabBarViewController.m
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "QuestionViewController.h"
#import "ViewConstants.h"
#import "UIColor+Utilities.h"

@interface CustomTabBarViewController () <UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *commentBarItem;  // tag = 0
@property (weak, nonatomic) IBOutlet UITabBarItem *questionBarItem; // tag = 1
@property (strong, nonatomic) UIView *bottomView;

@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.commentViewController = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    QuestionViewController *questionVC = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    self.questionViewController = questionVC;
    
    [self setChildViewController:self.commentViewController];
    [self setChildViewController:questionVC];
    
    [self setUpTabBar];
    [self setUpBottomView];

}

- (void)setUpBottomView
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.tabBar.frame)-5, CGRectGetWidth(self.tabBar.frame)/2, 5)];
    [self.bottomView setBackgroundColor:[UIColor colorWithHex:kYahooDarkPurple]];
    [self.tabBar addSubview:self.bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpTabBar
{
    self.tabBar.delegate = self;
    [UITabBar appearance].barTintColor = [UIColor colorWithHex:kYahooLightPurple];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:15.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    // Add separator
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.tabBar.bounds)/2, 0, 1, CGRectGetHeight(self.tabBar.bounds))];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar addSubview:separator];
    
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
        case 0:{ // comment
            //[API] get data for comment and reload UI
            //[API] get sentiment data
            [self setChildViewController:self.commentViewController];
            [self.questionViewController removeFromParentViewController];
            CGRect frame = self.bottomView.frame;
            [self.bottomView setFrame:CGRectMake(0, CGRectGetHeight(self.tabBar.frame)-5, CGRectGetWidth(frame), CGRectGetHeight(frame))];
            break;
            }
        case 1:{ // question
            //[API] get data for top and recent question and reload UI
            //[API] get sentiment data
            [self setChildViewController:self.questionViewController];
            [self.commentViewController removeFromParentViewController];
            CGRect frame = self.bottomView.frame;
            [self.bottomView setFrame:CGRectMake(CGRectGetWidth(frame), CGRectGetHeight(self.tabBar.frame)-5, CGRectGetWidth(frame), CGRectGetHeight(frame))];
            break;
            }
        default:
            break;
    }
}


@end
