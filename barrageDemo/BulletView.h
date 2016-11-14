//
//  BulletView.h
//  barrageDemo
//
//  Created by Betsy on 16/7/29.
//  Copyright © 2016年 betsy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MoveState){
    Start,
    Enter,
    End
};

@interface BulletView : UIView

@property (nonatomic, assign) int trajectory;//弹道

@property (nonatomic, copy) void(^moveStateBlook)(MoveState state);//弹幕状态回调

//初始化弹幕
- (instancetype)initWithComment:(NSString*)comment;

//开始动画
- (void)startAnimation;

//结束动画
- (void)endAnimation;

@end
