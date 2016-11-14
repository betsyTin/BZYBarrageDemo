//
//  ViewController.m
//  barrageDemo
//
//  Created by Betsy on 16/7/29.
//  Copyright © 2016年 betsy. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"

@interface ViewController ()

@property (nonatomic, strong)BulletManager *bulletManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bulletManager = [[BulletManager alloc]init];
    
    __weak typeof(self) myself = self;
    self.bulletManager.generateViewBlook = ^(BulletView *view){
        [myself addBulletView:view];
    };
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake( 100, 100, 100, 40)];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake( 250, 100, 100, 40)];
    [button1 setTitle:@"停止" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonStopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)buttonClick
{
    [self.bulletManager start];
}

- (void)buttonStopClick
{
    [self.bulletManager stop ];
}

- (void)addBulletView:(BulletView*)bulletView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    bulletView.frame = CGRectMake(width, 300+bulletView.trajectory*50, CGRectGetWidth(bulletView.bounds), CGRectGetHeight(bulletView.bounds));
    
    [self.view addSubview:bulletView];
    
    [bulletView startAnimation ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
