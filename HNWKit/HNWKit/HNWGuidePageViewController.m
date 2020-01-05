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
{
    CGPoint _beginDraggingPoint;
}
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skipButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonBottom;

@property (nonatomic, readwrite, copy) NSArray<UIImage *> *guidePageImages;
@property (nonatomic) NSInteger currentPageIndex; // default 0
@property (nonatomic, getter=isScrollingAnimation) BOOL scrollingAnimation;
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

- (void)scrollToGuidePageAtIndex:(NSInteger)index {
    if (index < self.guidePageImages.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
    }
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
    
    self.pageControl.numberOfPages = self.guidePageImages.count;
    self.pageControl.currentPage = 0;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = UIScreen.mainScreen.bounds.size;
    flowLayout.estimatedItemSize = CGSizeZero;
    self.collectionView.scrollsToTop = NO;
    [self.collectionView registerClass:[HNWGuidePageCollectionViewCell class]
            forCellWithReuseIdentifier:@"HNWGuidePageCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.guidePageImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNWGuidePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNWGuidePageCollectionViewCell" forIndexPath:indexPath];
    cell.themeImageView.image = self.guidePageImages[indexPath.item];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _beginDraggingPoint = [scrollView.panGestureRecognizer locationInView:self.view];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint endDraggingPoint = [scrollView.panGestureRecognizer locationInView:self.view];
    if (decelerate) {
        self.collectionView.scrollEnabled = NO;
    } else {
        [self refreshPageIndex];
        if (endDraggingPoint.x < _beginDraggingPoint.x && self.currentPageIndex == self.guidePageImages.count-1) {
            [self tellsDelegateDidFinishGuiding];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.collectionView.scrollEnabled = YES;
    [self refreshPageIndex];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.scrollingAnimation = NO;
    [self refreshPageIndex];
}

#pragma mark - Actions
- (IBAction)skipButtonDidClicked:(UIButton *)sender {
    [self tellsDelegateDidFinishGuiding];
}

- (IBAction)nextButtonDidClicked:(UIButton *)sender {
    if ((self.collectionView.isTracking && self.collectionView.isDragging) ||
        self.collectionView.isDecelerating ||
        self.isScrollingAnimation) {
        return;
    }
    if (self.currentPageIndex + 1 < self.guidePageImages.count) {
        self.scrollingAnimation = YES;
        [self scrollToGuidePageAtIndex:self.currentPageIndex+1];
    } else {
        [self tellsDelegateDidFinishGuiding];
    }
}

#pragma mark - Misc
- (void)refreshPageIndex {
    CGFloat offsetX = self.collectionView.contentOffset.x;
    long newIndex = lround(offsetX / CGRectGetWidth(self.view.bounds));
    if (self.currentPageIndex != newIndex) {
        self.currentPageIndex = newIndex;
        self.pageControl.currentPage = newIndex;
    }
}

- (void)tellsDelegateDidFinishGuiding {
    if (self.delegate && [self.delegate respondsToSelector:@selector(guidePageViewController:didFinishGuidingWithOptions:)]) {
        [self.delegate guidePageViewController:self didFinishGuidingWithOptions:@{}];
    }
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
