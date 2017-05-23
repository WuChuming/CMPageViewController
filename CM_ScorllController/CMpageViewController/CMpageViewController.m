//
//  CMpageViewController.m
//  CM_ScorllController
//
//  Created by shawn on 2017/5/22.
//  Copyright © 2017年 shawn. All rights reserved.
//

#import "CMpageViewController.h"


@interface CMpageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *tiTleScrollView;

@property (nonatomic, strong) UIScrollView *controllerScrollView;

@property (nonatomic, strong) UIView *titleBottomLine;


@property (nonatomic, strong) NSMutableArray *controllerArr;

@end

@implementation CMpageViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        _appearance = [[VCScrollViewAppearance alloc] init];
        self.tiTleScrollView.frame = CGRectMake(0, 0, self.frame .size.width, _appearance.titleHeight);
        self.controllerScrollView.frame = CGRectMake(0, _appearance.titleHeight, self.frame .size.width, self.frame.size.height - _appearance.titleHeight);
        [self addSubview:self.controllerScrollView];
        [self addSubview:self.tiTleScrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _appearance = [[VCScrollViewAppearance alloc] init];
        self.tiTleScrollView.frame = CGRectMake(0, 0, frame.size.width, _appearance.titleHeight);
        self.controllerScrollView.frame = CGRectMake(0, _appearance.titleHeight, frame.size.width, self.frame.size.height - _appearance.titleHeight);
        
        [self addSubview:self.controllerScrollView];
        [self addSubview:self.tiTleScrollView];
    }
    return self;
}

#pragma mark ----外部方法----
- (void)sc_reloadData{
    if (_appearance.titleHeight != 40) {
        self.tiTleScrollView.frame = CGRectMake(0, 0, self.frame.size.width, _appearance.titleHeight);
        self.controllerScrollView.frame = CGRectMake(0, _appearance.titleHeight, self.frame.size.width, self.frame.size.height - _appearance.titleHeight);
    }
    if (_appearance.titleBottomLineColor) {
        self.titleBottomLine.backgroundColor = _appearance.titleBottomLineColor;
    }
    NSInteger totalNum = [self.cmdataSources numberOfViewContrllerInScrollViewContrller:self];
    if (totalNum <= 0) {
        return;
    }
    [self.controllerArr removeAllObjects];
    NSInteger titlenumber = self.appearance.titleAppearCount;
    CGFloat titleButtonWidth = self.frame.size.width/titlenumber;
    
    self.tiTleScrollView.contentSize = CGSizeMake(totalNum * titleButtonWidth, self.appearance.titleHeight);
    for (int i = 0; i < totalNum; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*titleButtonWidth, 0,titleButtonWidth, self.appearance.titleHeight);
        [button setTitle:[self.cmdataSources ScrollViewController:self titleNameForIndex:i] forState:0];
        button.backgroundColor = _appearance.buttonBackgroundColor;
        button.tag = 10000 + i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        [self.tiTleScrollView addSubview:button];
    }
    self.titleBottomLine.frame = CGRectMake(0, self.tiTleScrollView.frame.size.height - 2, titleButtonWidth, 2);
    [self.tiTleScrollView addSubview:self.titleBottomLine];
    self.controllerScrollView.contentSize = CGSizeMake(self.frame.size.width * totalNum, self.frame.size.height - self.appearance.titleHeight);
    if (totalNum == 1) {
        UIViewController *firstView = [self.cmdataSources ScrollViewContrller:self ViewControllerAtIndexPath:0];
        firstView.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.appearance.titleHeight);
        [self.controllerScrollView addSubview:firstView.view];
        [self.controllerArr addObject:firstView];
    } else {
    
    UIViewController *firstView = [self.cmdataSources ScrollViewContrller:self ViewControllerAtIndexPath:0];
    firstView.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.appearance.titleHeight);
    UIViewController *secondView = [self.cmdataSources ScrollViewContrller:self ViewControllerAtIndexPath:1];
    secondView.view.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - self.appearance.titleHeight);
    [self.controllerScrollView addSubview:firstView.view];
    [self.controllerScrollView addSubview:secondView.view];
    
        [self.controllerArr addObject:firstView];
        [self.controllerArr addObject:secondView];
    }
}

#pragma mark ----设置titlescrollview---

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
   [self scrollViewScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
[self scrollViewScroll:scrollView];
}


///viewcontroller的ScrollView滚动
- (void)scrollViewScroll:(UIScrollView *)scrollView{
    NSInteger totalNum = [self.cmdataSources numberOfViewContrllerInScrollViewContrller:self];
    if (scrollView == self.controllerScrollView) {
        CGFloat originIndex = roundf(scrollView.contentOffset.x/self.frame.size.width);
        if (self.controllerArr.count != totalNum && self.controllerArr.count < originIndex +2) {
            UIViewController *controller = [self.cmdataSources ScrollViewContrller:self ViewControllerAtIndexPath:(int)originIndex + 1];
            controller.view.frame = CGRectMake(self.frame.size.width * ((int)originIndex + 1), 0, self.frame.size.width, self.frame.size.height - self.appearance.titleHeight);
            [self.controllerScrollView addSubview:controller.view];
            [self.controllerArr addObject:controller];
        }
        [self.controllerScrollView setContentOffset:CGPointMake(originIndex*self.frame.size.width, 0) animated:YES];
        [UIView animateWithDuration:.5f animations:^{
            self.titleBottomLine.frame = CGRectMake(self.titleBottomLine.frame.size.width * originIndex, self.tiTleScrollView.frame.size.height - 2, self.titleBottomLine.frame.size.width, 2);
        }];
        
        if (originIndex > 0 && originIndex < totalNum - 2) {
        [self.tiTleScrollView setContentOffset:CGPointMake((originIndex -1) * self.frame.size.width/self.appearance.titleAppearCount, 0)  animated:YES];
        }
    } else if (scrollView == self.tiTleScrollView){
    CGFloat originIndex = roundf(scrollView.contentOffset.x/(self.frame.size.width/_appearance.titleAppearCount));
        if (originIndex > 1 && originIndex < totalNum - 3) {
    [self.tiTleScrollView setContentOffset:CGPointMake(originIndex*self.frame.size.width/_appearance.titleAppearCount, 0) animated:YES];
        }
    }

}
#pragma mark ----titleButton----
- (void)titleButtonClick:(UIButton *)button{
    NSInteger index = button.tag - 10000;
    NSInteger currentVccount = self.controllerArr.count;
    NSInteger totalNum = [self.cmdataSources numberOfViewContrllerInScrollViewContrller:self];
    if (index >= self.controllerArr.count ) {
        if (index != totalNum - 1) {
            for (int i = 0 ; i < index - currentVccount + 2; i ++) {
                UIViewController *vc  = [self.cmdataSources ScrollViewContrller:self ViewControllerAtIndexPath:index ];
                vc.view.frame = CGRectMake(self.frame.size.width * (i + currentVccount), 0, self.frame.size.width, self.frame.size.height - self.appearance.titleHeight);
                [self.controllerScrollView addSubview:vc.view];
                [self.controllerArr addObject:vc];
            }
        } else {
            for (int i = 0 ; i < index - currentVccount + 1; i ++) {
                UIViewController *vc  = [self.cmdataSources ScrollViewContrller:self ViewControllerAtIndexPath:index ];
                vc.view.frame = CGRectMake(self.frame.size.width * (i + currentVccount), 0, self.frame.size.width, self.frame.size.height - self.appearance.titleHeight);
                [self.controllerScrollView addSubview:vc.view];
                [self.controllerArr addObject:vc];
            }
        }
    }
    [self.controllerScrollView setContentOffset:CGPointMake(index*self.frame.size.width, 0) animated:YES];
    [UIView animateWithDuration:.5f animations:^{
        self.titleBottomLine.frame = CGRectMake(self.titleBottomLine.frame.size.width * index, self.tiTleScrollView.frame.size.height - 2, self.titleBottomLine.frame.size.width, 2);}];
    if (index > 0 && index < totalNum - 3){
    [self.tiTleScrollView setContentOffset:CGPointMake((index -1) * self.frame.size.width/self.appearance.titleAppearCount, 0)  animated:YES];
    }
}
#pragma mark  ---appearanceDelegate---
- (void)setTitleHeightwithValue:(float)height{
    self.tiTleScrollView.frame = CGRectMake(0, 0, self.frame.size.width,height);
    self.controllerScrollView.frame = CGRectMake(0, height, self.frame.size.width,self.frame.size.height - height);
}


#pragma mark ----懒加载----
-(UIScrollView *)tiTleScrollView{
    if (!_tiTleScrollView) {
        _tiTleScrollView  = [[UIScrollView alloc] init];
        _tiTleScrollView.showsHorizontalScrollIndicator = NO;
        _tiTleScrollView.delegate = self;
    }
    return _tiTleScrollView;
}

- (UIScrollView *)controllerScrollView{
    if (!_controllerScrollView) {
        _controllerScrollView  = [[UIScrollView alloc] init];
        _controllerScrollView.delegate = self;
    }
    return _controllerScrollView;
}
- (UIView *)titleBottomLine{
    if (!_titleBottomLine) {
        _titleBottomLine  = [[UIView alloc] init];
        _titleBottomLine.backgroundColor = [UIColor redColor];
    }
    return _titleBottomLine;
}

- (NSMutableArray *)controllerArr{
    if (!_controllerArr) {
        _controllerArr = [NSMutableArray array];
    }
    return _controllerArr;
}
@end
