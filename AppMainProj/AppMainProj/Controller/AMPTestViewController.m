//
//  AMPTestViewController.m
//  AppMainProj
//
//  Created by Young on 2019/12/26.
//  Copyright © 2019 Young. All rights reserved.
//

#import "AMPTestViewController.h"
#import <HNWKit/HNWKit.h>

@interface AMPTestViewController ()
{
    HNWWeakTimer *_timer;
}
@end

@implementation AMPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.hnw_randomColor;
    _timer = [[HNWWeakTimer alloc] init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (arc4random() % 2 == 0) {
        [_timer scheduledWithTimeInterval:1000
                                  repeats:YES
                                    block:^(HNWWeakTimer * _Nonnull timerHolder) {
                                        NSLog(@"来了 %@", timerHolder);
                                    }];
    } else {
        [_timer scheduledWithCountdown:60000 interval:1000 block:^(HNWWeakTimer * _Nonnull timerHolder, long currentCountdown) {
            NSLog(@"来了 %ld", currentCountdown);
        }];
    }
}

@end
