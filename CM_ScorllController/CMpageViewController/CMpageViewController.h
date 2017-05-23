//
//  CMpageViewController.h
//  CM_ScorllController
//
//  Created by shawn on 2017/5/22.
//  Copyright © 2017年 shawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCScrollViewAppearance.h"
@class CMpageViewController;


@protocol CMScorllerViewDataSource <NSObject>

@required
- (NSInteger)numberOfViewContrllerInScrollViewContrller:(CMpageViewController *)sVC;

- (UIViewController *)ScrollViewContrller:(CMpageViewController *)sVC ViewControllerAtIndexPath:(NSInteger)index;
- (NSString *)ScrollViewController:(CMpageViewController *)sVC titleNameForIndex:(NSInteger)index;

@end


@interface CMpageViewController : UIView

@property (nonatomic, strong)VCScrollViewAppearance *appearance;

- (void)sc_reloadData;

@property (nonatomic, assign) id<CMScorllerViewDataSource> cmdataSources;
@end
