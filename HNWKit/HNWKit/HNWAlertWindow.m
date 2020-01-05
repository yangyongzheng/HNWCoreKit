//
//  HNWAlertWindow.m
//  HNWKit
//
//  Created by Young on 2020/1/3.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWAlertWindow.h"

@interface HNWAlertNavigationController : UINavigationController

@end

@implementation HNWAlertNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self setNavigationBarHidden:YES animated:NO];
    [self setToolbarHidden:YES animated:NO];
}

@end

@interface HNWAlertBoxViewController : UIViewController

@end

@implementation HNWAlertBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

@end

@interface HNWAlertWindow ()

@end

@implementation HNWAlertWindow

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultConfiguration];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupDefaultConfiguration];
    }
    return self;
}

- (void)setupDefaultConfiguration {
    self.backgroundColor = [UIColor clearColor];
    HNWAlertBoxViewController *rootVC = [[HNWAlertBoxViewController alloc] init];
    HNWAlertNavigationController *navigationController = [[HNWAlertNavigationController alloc] initWithRootViewController:rootVC];
    self.rootViewController = navigationController;
}

@end
