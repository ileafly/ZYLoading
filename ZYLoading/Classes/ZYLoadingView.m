//
//  ZYLoadingView.m
//  Pods
//
//  Created by luzhiyong on 2016/12/22.
//
//

#import "ZYLoadingView.h"

#import "ZYLoadingConfig.h"

@interface ZYLoadingView ()

@property (nonatomic, strong) UIImageView *loopImageView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *loadingMessageLabel;

@property (nonatomic, assign) CGFloat loopAngle, angleStep, logoAlpha, alphaStep;

@end

@implementation ZYLoadingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - 界面搭建

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    self.loopAngle = 0.0;
    self.logoAlpha = 1.0;
    self.angleStep = ZYLoadingConfigInstance.angleStep;
    self.alphaStep = ZYLoadingConfigInstance.alphaStep;
    
    self.loopImageView.frame = CGRectMake(0, 0, ZYLoadingConfigInstance.loopImageSize.width, ZYLoadingConfigInstance.loopImageSize.height);
    self.loopImageView.center = self.center;
    self.logoImageView.frame = CGRectMake(0, 0, ZYLoadingConfigInstance.logoImageSize.width, ZYLoadingConfigInstance.logoImageSize.height);
    self.logoImageView.center = self.center;
    
    [self addSubview:self.loopImageView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.loadingMessageLabel];
    
}

#pragma mark - Public Methods

- (void)startAnimation {
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    [self loadingAnimation];
}

- (void)stopAnimation {
    self.hidden = YES;
    _isLoading = NO;
}

#pragma mark - Private Methods

- (void)loadingAnimation {
    
    if (ZYLoadingConfigInstance.loadingType == ZYLoadingAnimateImages) {
        // 图片组动画
        _logoImageView.image = [UIImage animatedImageNamed:ZYLoadingConfigInstance.animateImageName duration:ZYLoadingConfigInstance.duration];
    } else {
        // 旋转图片动画
        _loopImageView.image = ZYLoadingConfigInstance.loopImage;
        _logoImageView.image = ZYLoadingConfigInstance.logoImage;
    
        [self loopAnimation];
    }
}

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

#pragma mark - Getter

- (UIImageView *)loopImageView {
    if (!_loopImageView) {
        _loopImageView = [[UIImageView alloc] init];
        _loopImageView.contentMode = UIViewContentModeCenter;
    }
    return _loopImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
    }
    return _logoImageView;
}

- (UILabel *)loadingMessageLabel {
    if (!_loadingMessageLabel) {
        _loadingMessageLabel = [[UILabel alloc] init];
        _loadingMessageLabel.textAlignment = NSTextAlignmentCenter;
        _loadingMessageLabel.font = [UIFont systemFontOfSize:14.f];
        _loadingMessageLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        _loadingMessageLabel.text = @"加载中...";
        _loadingMessageLabel.backgroundColor = [UIColor clearColor];
    }
    return _loadingMessageLabel;
}

@end
