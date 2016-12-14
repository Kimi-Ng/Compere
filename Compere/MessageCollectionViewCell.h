//
//  MessageCollectionViewCell.h
//  Compere
//
//  Created by Kimi Wu on 12/13/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDataObject.h"

@interface MessageCollectionViewCell : UICollectionViewCell

+ (CGSize)cellDefaultSize;

- (void)populateCellWithData:(MessageDataObject *)data;

@end
