//
//  ZYLoadingConfig.m
//  Masonry
//
//  Created by luzhiyong on 2017/10/17.
//

#import "ZYLoadingConfig.h"

@implementation ZYLoadingConfig

+ (instancetype)sharedInstance {
    static ZYLoadingConfig *config = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        config = [[self alloc] init];
    });
    return config;
}

- (id)init {
    if (self = [super init]) {
        _loopImageSize = CGSizeMake(80, 80);
        _logoImageSize = CGSizeMake(60, 60);
        _duration = 1.0f;
        _angleStep = 360/3;
        _alphaStep = 1.0/3.0;
    }
    return self;
}

@end
