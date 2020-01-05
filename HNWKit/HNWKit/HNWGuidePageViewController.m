//
//  HNWGuidePageViewController.m
//  HNWKit
//
//  Created by Young on 2020/1/5.
//  Copyright © 2020 Young. All rights reserved.
//

#import "HNWGuidePageViewController.h"
#import "UIImage+HNWKit.h"
#import "UIColor+HNWKit.h"
#import "HNWDevice.h"

@interface HNWGuidePageCollectionViewCell : UICollectionViewCell
@property (nonatomic, readonly, strong) UIImageView *themeImageView;
@end

@interface HNWGuidePageViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skipButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonBottom;

@property (nonatomic, readwrite, copy) NSArray<UIImage *> *guidePageImages;
@end

@implementation HNWGuidePageViewController

+ (HNWGuidePageViewController *)controllerWithGuidePageImages:(NSArray<UIImage *> *)guidePageImages {
    NSBundle *bundle = [NSBundle bundleForClass:[HNWGuidePageViewController class]];
    HNWGuidePageViewController *vc = [[HNWGuidePageViewController alloc] initWithNibName:@"HNWGuidePageViewController" bundle:bundle];
    if (guidePageImages && [guidePageImages isKindOfClass:[NSArray class]]) {
        vc.guidePageImages = guidePageImages;
    } else {
        vc.guidePageImages = nil;
    }
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = UIColor.clearColor;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = UIColor.clearColor;
    
    self.skipButtonTop.constant = HNWDevice.sharedDevice.statusBarHeight + 7;
    self.nextButtonBottom.constant = HNWDevice.sharedDevice.safeAreaBottomInset + 15;
    self.skipButton.layer.cornerRadius = 15;
    self.skipButton.layer.masksToBounds = YES;
    self.nextButton.layer.cornerRadius = 21;
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.borderWidth = 1;
    self.nextButton.layer.borderColor = HNWColorWithRGBAHexInt(0x39BF3E).CGColor;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = UIScreen.mainScreen.bounds.size;
    flowLayout.estimatedItemSize = CGSizeZero;
    [self.collectionView registerClass:[HNWGuidePageCollectionViewCell class]
            forCellWithReuseIdentifier:@"HNWGuidePageCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.guidePageImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNWGuidePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNWGuidePageCollectionViewCell" forIndexPath:indexPath];
    cell.themeImageView.image = self.guidePageImages[indexPath.item];
    return cell;
}

- (IBAction)skipButtonDidClicked:(UIButton *)sender {
    
}

- (IBAction)nextButtonDidClicked:(UIButton *)sender {
    
}

@end



@implementation HNWGuidePageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        _themeImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _themeImageView.contentMode = UIViewContentModeScaleToFill;
        _themeImageView.backgroundColor = UIColor.clearColor;
        _themeImageView.clipsToBounds = YES;
        _themeImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_themeImageView];
    }
    return self;
}

@end
