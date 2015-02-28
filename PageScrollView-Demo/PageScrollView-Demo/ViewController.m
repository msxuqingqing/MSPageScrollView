//
//  ViewController.m
//  PageScrollView-Demo
//
//  Created by XuQingQing on 15-1-25.
//  Copyright (c) 2015年 XQQ. All rights reserved.
//

#import "ViewController.h"
#define kTabHeight 44
#define kBottomHeight 49
#define kStatusBarHeight 20

@interface ViewController ()
@property (nonatomic, strong) MSTabScrollView *tabScrollView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPageScrollView];
    [self createBottomView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabScrollView resetPageViewContentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPageScrollView {
    self.titleArray = @[@"头条", @"新鲜事", @"体育直播", @"动漫", @"游戏", @"手机", @"财经", @"宠物", @"本地", @"汽车", @"旅游", @"趣味", @"世界杯"];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat pageHeight = KDevice_Height - kStatusBarHeight - kBottomHeight;
    self.tabScrollView = [[MSTabScrollView alloc]initWithPageWidth:KDevice_Width PageHeight:pageHeight Delegate:self];
    self.tabScrollView.tabSelectedColor = [UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1]; //默认颜色，可不设置
    self.tabScrollView.tabBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]; //默认颜色，可不设置
    self.tabScrollView.selectedTabIndex = 0; //默认位置，可不设置
    self.tabScrollView.isNeedPageCountLimit = NO; //默认不限制，可不设置
    [self.tabScrollView handleLayout];
    [self.view addSubview:self.tabScrollView];
    
    
    //使用自动布局，非自动布局时去掉
    NSDictionary *metrics = @{@"TopHeight":@(kStatusBarHeight),@"BottomHeight":@(kTabHeight)};
    [self.tabScrollView setCustomLayoutWithVisualFormat1:@"H:|[view]|"
                                                 Format2:@"V:|-TopHeight-[view]-BottomHeight-|"
                                                 metrics:metrics
                                               superView:self.view];

    
    //非自动布局时需设置self.tabScrollView的frame, 代替上面代码
    //[self.tabScrollView setFrame:CGRectMake(30, 50, KDevice_Width - 80, pageHeight)];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:bottomView];
    NSDictionary *metrics = @{@"Height":@(kBottomHeight)};
    [bottomView setCustomLayoutWithVisualFormat1:@"H:|[view]|"
                                         Format2:@"V:[view(Height)]|"
                                         metrics:metrics
                                       superView:self.view];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请尝试左右滑动";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 0.5;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:titleLabel];
    [titleLabel setCustomLayoutWithVisualFormat1:@"H:|[view]|"
                                         Format2:@"V:|[view]|"
                                         metrics:nil
                                       superView:bottomView];
}

#pragma mark - MSTabScrollViewDelegate
- (NSInteger)NumberOfTabInTabScrollView:(UIScrollView *)tabScrollView {
    return self.titleArray.count;
}

- (UIView *)tabScrollView:(UIScrollView *)tabScrollView pageViewForTabIndex:(NSInteger)tabIndex {
    UIView *pageView = [[UIView alloc]init];
    pageView.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor yellowColor];
    label.text = [NSString stringWithFormat:@"第%ld页",tabIndex + 1];
    label.textAlignment = NSTextAlignmentCenter;
    [pageView addSubview:label];
    
    [label setCustomLayoutWithVisualFormat1:@"H:|[view]|"
                                    Format2:@"V:|-100-[view(40)]"
                                    metrics:nil
                                  superView:pageView];
    return pageView;
}

- (NSString *)tabScrollView:(UIScrollView *)tabScrollView titleForTabIndex:(NSInteger)tabIndex {
    if (tabIndex < self.titleArray.count) {
        return self.titleArray[tabIndex];
    }
    return nil;
}

//适应设备旋转时增加以下部分代码
#pragma mark - UIViewControllerRotation
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations

{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.tabScrollView updatePageViewConstraint:InterfaceOrientationPortrait];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.tabScrollView updatePageViewConstraint:InterfaceOrientationLandscape];
        default:
            break;
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationPortrait;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
}
@end












