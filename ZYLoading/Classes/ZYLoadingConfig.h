//
//  ZYLoadingConfig.h
//  Masonry
//
//  Created by luzhiyong on 2017/10/17.
//

#import <Foundation/Foundation.h>

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

@end
