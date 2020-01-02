//
//  HNWAlertDispatcher.m
//  HNWKit
//
//  Created by Young on 2020/1/2.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertDispatcher.h"

@interface HNWAlertBoxView : UIView

@property (nonatomic, readonly, strong) UIView *shadowView;
@property (nonatomic, readonly, strong) UIView *animateView;
@property (nonatomic, readonly, strong) UIView *alertView;

+ (instancetype)boxViewWithAlertView:(UIView *)alertView;

@end

@implementation HNWAlertBoxView

@synthesize shadowView = _shadowView;
@synthesize animateView = _animateView;

+ (instancetype)boxViewWithAlertView:(UIView *)alertView {
    if (alertView && [alertView isKindOfClass:[UIView class]]) {
        HNWAlertBoxView *boxView = [[HNWAlertBoxView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        boxView->_alertView = alertView;
        [boxView setupDefaultUI];
        return boxView;
    } else {
        return nil;
    }
}

- (void)setupDefaultUI {
    [self addSubview:self.shadowView];
    [self addSubview:self.animateView];
    if (self.alertView) {
        [self.animateView addSubview:self.alertView];
        self.alertView.center = CGPointMake(CGRectGetMidX(self.animateView.bounds), CGRectGetMidY(self.animateView.bounds));
        self.alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    }
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:self.bounds];
        _shadowView.userInteractionEnabled = NO;
        _shadowView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
        _shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _shadowView;
}

- (UIView *)animateView {
    if (!_animateView) {
        _animateView = [[UIView alloc] initWithFrame:self.bounds];
        _animateView.userInteractionEnabled = YES;
        _animateView.backgroundColor = [UIColor clearColor];
        _animateView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _animateView;
}

@end

@interface HNWAlertBoxNavigationController : UINavigationController

@end

@implementation HNWAlertBoxNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    [self setNavigationBarHidden:YES animated:NO];
}

@end

@interface HNWAlertBoxController : UIViewController
@property (nonatomic, strong) NSMutableArray<HNWAlertBoxView *> *alertBoxViews;
@end

@implementation HNWAlertBoxController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
}

- (NSMutableArray<HNWAlertBoxView *> *)alertBoxViews {
    if (!_alertBoxViews) {
        _alertBoxViews = [NSMutableArray array];
    }
    return _alertBoxViews;
}

@end



@interface HNWAlertDispatcher ()
@property (nonatomic, readwrite, strong) UIWindow *alertWindow;
@property (nonatomic, readonly, weak) HNWAlertBoxController *boxController;
@end

@implementation HNWAlertDispatcher

+ (HNWAlertDispatcher *)sharedDispatcher {
    static HNWAlertDispatcher *dispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatcher = [[[self class] alloc] init];
        [dispatcher setupDefaultConfiguration];
    });
    return dispatcher;
}

- (void)showAlertView:(UIView *)alertView
            alertMode:(HNWAlertMode)alertMode
       animationStyle:(HNWAlertAnimationStyle)animationStyle
           completion:(void (^)(void))completion {
    [self.alertWindow makeKeyAndVisible];
}

- (void)hideAlertView:(UIView *)alertView
       animationStyle:(HNWAlertAnimationStyle)animationStyle
           completion:(void (^)(void))completion {
    
}

#pragma mark - Misc
- (void)setupDefaultConfiguration {
    self.alertWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.alertWindow.windowLevel = UIWindowLevelStatusBar + 10;
    self.alertWindow.backgroundColor = UIColor.clearColor;
    self.alertWindow.hidden = YES;
    self.alertWindow.clipsToBounds = YES;
    HNWAlertBoxController *boxVC = [[HNWAlertBoxController alloc] init];
    self.alertWindow.rootViewController = [[HNWAlertBoxNavigationController alloc] initWithRootViewController:boxVC];
}

@end
