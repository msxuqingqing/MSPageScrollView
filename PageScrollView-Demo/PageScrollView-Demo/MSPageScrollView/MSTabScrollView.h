//
//  MSTabScrollView.h
//  PageScrollView-Demo
//
//  Created by XuQingQing on 15-1-26.
//  Copyright (c) 2015年 XQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    InterfaceOrientationPortrait,
    InterfaceOrientationLandscape
}InterfaceOrientation;

@protocol MSTabScrollViewDelegate;

@interface MSTabScrollView : UIView <UIScrollViewDelegate>

//遵从MSTabScrollViewDelegate协议的对象
@property (nonatomic, assign) id<MSTabScrollViewDelegate> delegate;
//Tab标题选中时的颜色
@property (nonatomic, strong) UIColor *tabSelectedColor;
//Tab背景颜色
@property (nonatomic, strong) UIColor *tabBackgroundColor;
//Tab中被选中标题的位置
@property (nonatomic, assign) NSInteger selectedTabIndex;
//是否开启同时存在的页数个数的限制
//YES：同时最多存在3页； NO：一次性初始化所有页面，无页数限制
@property (nonatomic, assign) BOOL isNeedPageCountLimit;

//框架初始化
//pageWidth：框架视图的宽度 ；pageHeight：框架视图的宽长度 ；delegate：遵从MSTabScrollViewDelegate协议的对象
//非自动布局时需设置框架的frame，请调用setFrame方法
- (id)initWithPageWidth:(CGFloat)pageWidth PageHeight:(CGFloat)pageHeight Delegate:(id)delegate;

//初始化页面布局，在初始化框架并设定好属性后手动调用
- (void)handleLayout;

//刷新下部滚动视图的contentSize，在使用autoLayout时需要在controller的viewDidAppear中调用
- (void)resetPageViewContentSize;

//当程序需要自动适应设备旋转时，在controller的系统回调方法中调用
- (void)updatePageViewConstraint:(InterfaceOrientation)orientation;
@end

@protocol MSTabScrollViewDelegate<NSObject>
- (UIView *)tabScrollView:(UIScrollView *)tabScrollView pageViewForTabIndex:(NSInteger)tabIndex;
- (NSString *)tabScrollView:(UIScrollView *)tabScrollView titleForTabIndex:(NSInteger)tabIndex;
@required
- (NSInteger)NumberOfTabInTabScrollView:(UIScrollView *)tabScrollView;
@end

//内部类，无需调用
//*********************************************************************
#pragma mark - MSTabView
@protocol MSTabViewDelegate <NSObject>

- (void)msTabTableView:(UITableView *)tableView didSelectRowAtIndex:(NSInteger)index;
- (void)msScrollViewDidScroll:(UIScrollView *)scrollView;
- (NSString *)msTitleViewTextGet:(NSInteger)index;
@end

@interface MSTabView : UIView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<MSTabViewDelegate> delegate;
@property (nonatomic, assign) NSInteger locateTabIndex;
@property (nonatomic, strong) NSLayoutConstraint *sliderViewConstraintX;
@property (nonatomic, strong) NSLayoutConstraint *sliderViewConstraintWidth;

- (id)initWithDelegate:(id)delegate;
- (void)updateTab;
- (CGFloat)getSizeHeight;
- (CGFloat)getOffsetY;
- (void)setTabContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (void)updateSliderLayout:(CGFloat)location width:(CGFloat)width;
@end

@interface NSString (MSExtension)

- (CGSize)customSizeWithFont:(UIFont *)font
           constrainedToSize:(CGSize)size
               lineBreakMode:(NSLineBreakMode)mode;

@end

@interface UIView (MSExtension)

- (void)setCustomLayoutWithVisualFormat1:(NSString *)format1
                                 Format2:(NSString *)format2
                                 metrics:(NSDictionary *)metrics
                               superView:(UIView *)superView;

@end
//*********************************************************************