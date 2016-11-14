//
//  BulletManager.m
//  barrageDemo
//
//  Created by Betsy on 16/7/29.
//  Copyright © 2016年 betsy. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager ()

//弹幕的数据源
@property (nonatomic, strong) NSMutableArray *dataSourse;

//弹幕使用过程中的数组变量
@property (nonatomic, strong) NSMutableArray *bulletComments;

//存储弹幕View的数组变量
@property (nonatomic, strong) NSMutableArray *bulletViews;

@property BOOL bStopAnimation;

@end

@implementation BulletManager

- (instancetype)init
{
    if (self = [super init]) {
        self.bStopAnimation = YES;
        
    }
    return self;
}

- (NSMutableArray *)dataSourse
{
    if (!_dataSourse) {
//        _dataSourse = [NSMutableArray arrayWithArray:@[@"卡拉肖克潘1",
//                                                       @"这技术，太烂了，垃圾！1",
//                                                       @"傻逼，滚出1",
//                                                       @"卡拉肖克潘2",
//                                                       @"这技术，太烂了，垃圾！2",
//                                                       @"傻逼，滚出2",
//                                                       @"卡拉肖克潘3",
//                                                       @"这技术，太烂了，垃圾！3",
//                                                       @"傻逼，滚出3",
//                                                       @"卡拉肖克潘4",
//                                                       @"这技术，太烂了，垃圾！4",
//                                                       @"傻逼，滚出4"
//                                                       ]];
        
        _dataSourse = [NSMutableArray arrayWithObjects:@"卡拉肖克潘1",@"这技术，太烂了，垃圾！1",@"傻逼，滚出1",@"卡拉肖克潘2",@"这技术，太烂了，垃圾！2",@"傻逼，滚出2",@"卡拉肖克潘3",@"这技术，太烂了，垃圾！3",@"傻逼，滚出3",@"卡拉肖克潘4",@"这技术，太烂了，垃圾！4",@"傻逼，滚出4", nil];
    }
    return _dataSourse;
}

- (NSMutableArray *)bulletComments
{
    if (!_bulletComments) {
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

- (NSMutableArray *)bulletViews
{
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}

- (void)start
{
    if (!self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSourse];
    NSLog(@"bulletComments === %ld",self.bulletComments.count);
    [self initBulletComment];
}

- (void)initBulletComment
{
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0) ,@(1) ,@(2)]];
    for (int i = 0; i < 3; i++) {
        if (self.bulletComments.count>0) {
            NSInteger index = arc4random()%trajectorys.count;
            int tra = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            [self creatBulletView:comment trajectory:tra];
        }
    }
}

- (void)creatBulletView:(NSString*)comment trajectory:(int)trajectory
{
    if (self.bStopAnimation) {
        return;
    }
    BulletView *bulletView = [[BulletView alloc]initWithComment:comment];
    bulletView.trajectory = trajectory;
    [self.bulletViews addObject:bulletView];
    
    __weak typeof (bulletView) weakView = bulletView;
    __weak typeof(self) mySelf = self;
    
    bulletView.moveStateBlook = ^(MoveState state){
        if (self.bStopAnimation) {
            return ;
        }
        switch (state) {
            case Start:{
                //弹幕开始进入屏幕
                [mySelf.bulletViews addObject:weakView];
                break;
            }
            case Enter:{
                //弹幕完全进入屏幕
                NSString *hehe = [mySelf nextComment];
                if (hehe) {
                    [mySelf creatBulletView:hehe trajectory:trajectory];
                }
                
                break;
            }
            case End:{
                //弹幕完全飞出屏幕
                if ([mySelf.bulletViews containsObject:weakView]) {
                    [weakView endAnimation];
                    [mySelf.bulletViews removeObject:weakView];
                }
                //屏幕上已经没有弹幕了，开始循环
                if (mySelf.bulletViews.count == 0) {
                    self.bStopAnimation = YES;
                    [mySelf start];
                }
                break;
            }
                
            default:
                break;
        }
    };
    
    if (self.generateViewBlook) {
        self.generateViewBlook(bulletView);
    }
}

- (NSString *)nextComment
{
    if (self.bulletComments.count == 0) {
        return nil;
    }
    NSString *comment = [self.bulletComments firstObject];
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
        
    }
    return comment;
}

- (void)stop
{
    if (self.bStopAnimation) {
        return;
    }
    self.bStopAnimation = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view endAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}

@end
