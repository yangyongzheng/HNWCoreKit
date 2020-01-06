//
//  HNWFormSheetWrapperController.m
//  HNWKit
//
//  Created by Young on 2020/1/1.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWFormSheetWrapperController.h"

@interface HNWFormSheetWrapperController ()
@property (nonatomic, strong) UIView *formSheetView;
@end

@implementation HNWFormSheetWrapperController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Public
+ (instancetype)wrapperControllerWithFormSheetView:(UIView *)formSheetView {
    if (formSheetView && [formSheetView isKindOfClass:[UIView class]]) {
        HNWFormSheetWrapperController *vc = [[[self class] alloc] init];
        vc.formSheetView = formSheetView;
        return vc;
    } else {
        return nil;
    }
}

- (void)showWithPresentingViewController:(UIViewController *)presentingViewController
                     animationTransition:(NSInteger)animationTransition
                              completion:(void (^)(void))completion {
    
}

- (void)hideWithAnimationTransition:(NSInteger)animationTransition
                         completion:(void (^)(void))completion {
    
}

@end
