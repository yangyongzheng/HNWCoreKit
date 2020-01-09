//
//  AMPBaseViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/24.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPBaseViewController.h"
#import "AMPBoxNavigationController.h"

@interface AMPBaseViewController ()

@end

@implementation AMPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopEnabled = YES;
    self.view.backgroundColor = UIColor.whiteColor;
    _goBackItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                   style:UIBarButtonItemStylePlain
                                                  target:self
                                                  action:@selector(goBackActionHandler)];
    self.navigationItem.leftBarButtonItems = @[_goBackItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.stackNavigationController.interactivePopGestureRecognizer.enabled = self.isInteractivePopEnabled;
    self.stackNavigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)removeGoBackItem {
    if (self.goBackItem) {
        NSArray *oldItems = self.navigationItem.leftBarButtonItems;
        NSMutableArray *newItems = [NSMutableArray arrayWithArray:oldItems];
        [newItems removeObject:self.goBackItem];
        self.navigationItem.leftBarButtonItems = [newItems copy];
    }
}

- (void)goBackActionHandler {
    [self.stackNavigationController popViewControllerAnimated:YES];
}

- (UINavigationController *)stackNavigationController {
    UINavigationController *navc = self.navigationController;
    if (navc && [navc isKindOfClass:[AMPBoxNavigationController class]]) {
        return navc.navigationController;
    } else {
        return navc;
    }
}

@end
