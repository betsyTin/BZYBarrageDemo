//
//  BulletManager.h
//  barrageDemo
//
//  Created by Betsy on 16/7/29.
//  Copyright © 2016年 betsy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;

@interface BulletManager : NSObject

@property (nonatomic, copy) void(^generateViewBlook)(BulletView *view);

- (void)start;

- (void)stop;

@end
