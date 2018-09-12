//
//  ZYAnimationOneViewController.m
//  ZYLoading_Example
//
//  Created by luzhiyong on 2017/10/17.
//  Copyright © 2017年 luzy. All rights reserved.
//

#import "ZYAnimationOneViewController.h"

#import <ZYLoading/UIView+ZYLoadingView.h>

@interface ZYAnimationOneViewController ()

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation ZYAnimationOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.startButton];
    
    // 通过一组图片组合成动画的方式
    ZYLoadingConfigInstance.loadingType = ZYLoadingAnimateImages;
    ZYLoadingConfigInstance.animateImageName = @"zy_loading_";
    ZYLoadingConfigInstance.loopImageSize = CGSizeMake(37, 13);
    ZYLoadingConfigInstance.duration = 1.f;
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
