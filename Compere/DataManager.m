//
//  DataManager.m
//  Compere
//
//  Created by Kimi Wu on 12/14/16.
//  Copyright © 2016 Kimi Wu. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
+ (DataManager *)sharedInstance
{
    static DataManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    
    return sharedInstance;
}


@end
