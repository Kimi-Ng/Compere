//
//  InputViewController.h
//  Compere
//
//  Created by Erin Chuang on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataObject.h"

@protocol InputViewControllerProtocol <NSObject>

- (void)onUserPostMessage:(MessageDataObject*)message;

@end

@interface InputViewController : UIViewController

@property (weak, nonatomic) id<InputViewControllerProtocol> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
