# ZYLoading
利用runtime的关联对象，封装了一个简单易用的Loading控件

## 目的
统一管理项目中随处可见的Loading控件，提供一组基础的loading控件样式，包括旋转图片的设置和logo的设置，提供便捷的调用方法。

## 预期
- 提供一个配置类用于配置loading的尺寸、图片等信息
- 封装loading控件，支持loading动画的开启与停止
- 利用runtime的关联对象特性，添加一个`UIView`的分类，并管理loadingView，从而达到调用`[view beginLoading]`和[view endLoading]能方便的在view的中心显示和隐藏loading控件

## 实现方案

###### ZYLoadingConfig
loading控件配置类，单例模式，持有loadingType、animateImageName、loopImage、logoImage、loadingMessage、loopImageSize、logoImageSize、duration、angleStep、alphaStep等配置信息

```
#define ZYLoadingConfigInstance [ZYLoadingConfig sharedInstance]

typedef NS_ENUM(NSInteger, ZYLoadingType) {
    ZYLoadingAnimateImages,  // 传入一组图片组合成动画
    ZYLoadingLoopImage // 设置一个图片，旋转图片
};

@interface ZYLoadingConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) ZYLoadingType loadingType;

@property (nonatomic, strong) NSString *animateImageName;

@property (nonatomic, strong) UIImage *loopImage;

@property (nonatomic, strong) UIImage *logoImage;

@property (nonatomic, strong) NSString *loadingMessage;

@property (nonatomic, assign) CGSize loopImageSize;

@property (nonatomic, assign) CGSize logoImageSize;

@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, assign) CGFloat angleStep;

@property (nonatomic, assign) CGFloat alphaStep;
```

###### ZYLoadingView

自定义loading控件，管理loading控件元素的布局，利用`[UIView animateWithDuration:delay:options:animations:completion:`执行旋转动画
通过`CGAffineTransformMakeRotation()`旋转`loopImageView`，动画过程中循环调用达到loading动画的效果。

```
- (void)loopAnimation {
    _loopAngle += _angleStep;
    
    _logoAlpha += _alphaStep;
    
    if (_logoAlpha >= 1.0 || _logoAlpha <= 0.0) {
        _alphaStep = - _alphaStep;
    }
    
    /*
     时间函数曲线
     
     UIViewAnimationOptionCurveEaseInOut   由慢到快  默认
     UIViewAnimationOptionCurveEaseIn      由慢到特快
     UIViewAnimationOptionCurveEaseOut     由快到慢
     UIViewAnimationOptionCurveLinear      匀速  保证旋转动画匀速过渡
     */
    
    [UIView animateWithDuration:ZYLoadingConfigInstance.duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.f));
        _loopImageView.transform = loopAngleTransform;
        _logoImageView.alpha = _logoAlpha;
    } completion:^(BOOL finished) {
        if (_isLoading && [self superview] != nil) {
            [self loopAnimation];
        } else {
            [self removeFromSuperview];
            
            _loopAngle = 0.0;
            _logoAlpha = 0.0;
            _alphaStep = ABS(_alphaStep);
            
            CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.f));
            _loopImageView.transform = loopAngleTransform;
            _logoImageView.alpha = _logoAlpha;
        }
    }];
}
```

###### UIView+ZYLoadingView
给`UIView`添加一个分类，利用关联对象的特性给分类添加一个成员变量`loadingView`，并提供`beginLoading`和`endLoading`这两个方法方便的创建loadingView和隐藏loadingView。

```
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
```