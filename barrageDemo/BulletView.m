//
//  BulletView.m
//  barrageDemo
//
//  Created by Betsy on 16/7/29.
//  Copyright © 2016年 betsy. All rights reserved.
//

#import "BulletView.h"

#define Padding 10
#define photoSize 30

@interface BulletView()

@property (nonatomic, strong) UILabel *lbComment;//弹幕label

@property (nonatomic, strong) UIImageView *photoImage;

@end

@implementation BulletView



//初始化弹幕
- (instancetype)initWithComment:(NSString*)comment
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 15;
        
        //计算弹幕实际宽度
        NSDictionary *atrr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        CGFloat width = [comment sizeWithAttributes:atrr].width;
        
        self.bounds = CGRectMake(0, 0, width+2*Padding+photoSize, 30);
        
        
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding+photoSize, 0, width, 30);
        
        self.photoImage.frame = CGRectMake(-Padding, -Padding, Padding+photoSize, photoSize+Padding);
        
        self.photoImage.layer.cornerRadius = (photoSize+Padding)/2;
        self.photoImage.layer.borderColor = [UIColor blueColor].CGColor;
        self.photoImage.layer.borderWidth = 1;
        self.photoImage.image = [UIImage imageNamed:@"1"];
    }
    return self;
}

//开始动画
- (void)startAnimation
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = screenWidth+CGRectGetWidth(self.bounds);
    
    if (self.moveStateBlook) {
        self.moveStateBlook(Start);
    }
    
    CGFloat speed =wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
    
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.moveStateBlook) {
            self.moveStateBlook(End);
        }
    }];
}


- (void)enterScreen
{
    if (self.moveStateBlook) {
        self.moveStateBlook(Enter);
    }
}

//结束动画
- (void)endAnimation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (UILabel*)lbComment
{
    if (!_lbComment) {
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor orangeColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}

- (UIImageView*)photoImage
{
    if (!_photoImage) {
        _photoImage = [UIImageView new];
        _photoImage.contentMode = UIViewContentModeScaleAspectFill;
        _photoImage.layer.masksToBounds = YES;
        [self addSubview:_photoImage];
    }
    return _photoImage;
}

@end
