//
//  ZYLoadingView.h
//  Pods
//
//  Created by luzhiyong on 2016/12/22.
//
//

#import <UIKit/UIKit.h>

@interface ZYLoadingView : UIView

@property (nonatomic, readonly) BOOL isLoading;

- (void)startAnimation;

- (void)stopAnimation;

@end
