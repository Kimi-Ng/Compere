//
//  CustomTabBarViewController.h
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentViewController.h"
#import "ViewConstants.h"

@interface CustomTabBarViewController : UIViewController

@property (strong, nonatomic) CommentViewController *commentViewController;
@property (strong, nonatomic) UIViewController *questionViewController;

- (void)setSelectedIndex:(TabBarType)tab;

@end
