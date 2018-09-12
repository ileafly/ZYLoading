//
//  UIView+ZYLoadingView.h
//  Pods
//
//  Created by luzhiyong on 2016/12/22.
//
//

#import <UIKit/UIKit.h>

#import "ZYLoadingView.h"

#import "ZYLoadingConfig.h"

@interface UIView (ZYLoadingView)

@property (nonatomic, strong) ZYLoadingView *loadingView;

- (void)beginLoading;

- (void)endLoading;

@end
