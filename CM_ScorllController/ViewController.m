//
//  ViewController.m
//  CM_ScorllController
//
//  Created by shawn on 2017/5/19.
//  Copyright © 2017年 shawn. All rights reserved.
//

#import "ViewController.h"
#import "CMpageViewController.h"

@interface ViewController ()<CMScorllerViewDataSource>

@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     CMpageViewController *view = [[CMpageViewController alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    CMpageViewController *view = [[CMpageViewController alloc] init];
    view.cmdataSources = self;
//    view.appearance.titleAppearCount = 6;
//    view.appearance.titleHeight = 150;
    [self.view addSubview:view];
    [view sc_reloadData];
//    UITableView
}

- (NSInteger)numberOfViewContrllerInScrollViewContrller:(CMpageViewController *)sVC{

    return self.titleArr.count;
}

- (UIViewController *)ScrollViewContrller:(CMpageViewController *)sVC ViewControllerAtIndexPath:(NSInteger)index{
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    return controller;

}
- (NSString *)ScrollViewController:(CMpageViewController *)sVC titleNameForIndex:(NSInteger)index{

    return self.titleArr[index];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr  = [NSMutableArray array];
         [_titleArr addObject:@"0"];
          [_titleArr addObject:@"1"];
          [_titleArr addObject:@"2"];
          [_titleArr addObject:@"3"];
          [_titleArr addObject:@"4"];
          [_titleArr addObject:@"5"];
          [_titleArr addObject:@"6"];
        [_titleArr addObject:@"7"];
        [_titleArr addObject:@"8"];
        [_titleArr addObject:@"9"];
        [_titleArr addObject:@"10"];
        [_titleArr addObject:@"11"];
        [_titleArr addObject:@"12"];
    }

    return _titleArr;
}


- (UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView  = [[UIView alloc] initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 100)];
        _backGroundView.backgroundColor = [UIColor purpleColor];
    }
    return _backGroundView;
}

@end
