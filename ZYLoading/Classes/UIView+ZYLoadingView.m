//
//  UIView+ZYLoadingView.m
//  Pods
//
//  Created by luzhiyong on 2016/12/22.
//
//

#import "UIView+ZYLoadingView.h"

#import <objc/runtime.h>

static char LoadingViewKey;

@implementation UIView (ZYLoadingView)

#pragma mark - Setter

- (void)setLoadingView:(ZYLoadingView *)loadingView {
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (ZYLoadingView *)loadingView {
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)beginLoading {
    if (!self.loadingView) {
        self.loadingView = [[ZYLoadingView alloc] initWithFrame:self.bounds];
    }
    
    [self addSubview:self.loadingView];
    
    [self.loadingView startAnimation];
}

- (void)endLoading {
    if (self.loadingView) {
        [self.loadingView stopAnimation];
    }
}

@end
