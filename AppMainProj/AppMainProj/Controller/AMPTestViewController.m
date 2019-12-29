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

@end

@implementation AMPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.hnw_randomColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImage *image = [UIImage imageNamed:@"test"];
    HNWPhotoManager *manager = HNWPhotoManager.sharedManager;
    [manager requestSaveImages:@[image, image, image] successBlock:^{
        NSLog(@"success");
    } failureBlock:^(NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
    
    NSURL *url = [NSURL fileURLWithPath:HNWUserDocumentsDirectory()];
    NSArray *mediaItems = @[[HNWPhotoMediaItem itemWithFileURL:url videoType:NO]];
    [manager requestSaveMediaItems:mediaItems successBlock:^{
        
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
    
    [HNWDevice load];
}

@end
