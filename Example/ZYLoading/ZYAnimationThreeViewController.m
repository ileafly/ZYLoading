//
//  ZYAnimationThreeViewController.m
//  ZYLoading_Example
//
//  Created by luzhiyong on 2017/10/17.
//  Copyright © 2017年 luzy. All rights reserved.
//

#import "ZYAnimationThreeViewController.h"

#import <ZYLoading/UIView+ZYLoadingView.h>

@interface ZYAnimationThreeViewController ()

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation ZYAnimationThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.startButton];
    
    // 通过一张图片旋转
    ZYLoadingConfigInstance.loadingType = ZYLoadingLoopImage;
    ZYLoadingConfigInstance.loopImage = [UIImage imageNamed:@"loading_circle"];
    ZYLoadingConfigInstance.loopImageSize = CGSizeMake(60, 60);
    ZYLoadingConfigInstance.logoImage = [UIImage imageNamed:@"loading_zhangyu"];
    ZYLoadingConfigInstance.logoImageSize = CGSizeMake(40, 40);
    ZYLoadingConfigInstance.duration = 0.25f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)startAction:(id)sender {
    [self.view beginLoading];
    
    [self performSelector:@selector(stopAction:) withObject:nil afterDelay:5.f];
}

- (void)stopAction:(id)sender {
    [self.view endLoading];
}

#pragma mark - Getter

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.frame = CGRectMake(20, 500, 80, 40);
        [_startButton setTitle:@"开启动画" forState:UIControlStateNormal];
        _startButton.backgroundColor = [UIColor blackColor];
        [_startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}


@end
