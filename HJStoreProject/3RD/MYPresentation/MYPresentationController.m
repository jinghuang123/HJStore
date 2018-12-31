//
//  ViewController.h
//  MYPresentation
//
//  Created by qc on 2017/5/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#import "MYPresentationController.h"


@interface MYPresentationController ()

//蒙板点击层 (只处理点击)
@property (nonatomic, strong) UIControl *coverView;

@end

@implementation MYPresentationController

- (MYColorBackView *)colorBackView
{
    if (!_colorBackView) {
        CGFloat yOffSet = 64;
        if (MaxHeight >= ENM_SCREEN_H_X) {
            yOffSet = 84;
        }
        _colorBackView = [[MYColorBackView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight - yOffSet)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callBackAction)];
        [_colorBackView addGestureRecognizer:tap];
        if (self.isNeedClearBack) {
            _colorBackView.backColorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.000001];
        }else{
            _colorBackView.backColorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            if (_showFrame.origin.y > yOffSet) {
                _colorBackView.topView.backgroundColor   = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0000001];
            }
            //全屏蒙版
//            _colorBackView.topView.backgroundColor   = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        }
//        [_colorBackView addSubview:self.coverView];
    }
    return _colorBackView;
}


- (void)callBackAction {
    if (self.onClickPetInfo) {
        self.onClickPetInfo(nil);
    }
}

//蒙板
- (UIControl *)coverView
{
    if (!_coverView) {
        
        _coverView = [[UIControl alloc]initWithFrame:my_Screen_Bounds];
        [_coverView addTarget:self action:@selector(coverViewTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverView;
}


//重写布局
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    //容器frame,不能遮挡导航栏 , 透明除外
    self.containerView.frame = CGRectMake(0, 0, self.showFrame.size.width, self.showFrame.size.height + 64);
    self.presentedView.frame = self.showFrame;
    [self.containerView insertSubview:self.colorBackView belowSubview:self.presentedView];
}


//蒙板点击
- (void)coverViewTouch
{
    
    
    
//    CGFloat duraration = [self animationDuration];
    
    

    [UIView animateWithDuration:0.15 animations:^{
        self.colorBackView.backColorView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.001];
        self.colorBackView.topView.backgroundColor       = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.001];
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    } completion:^(BOOL finished) {

        if ([self.presentedViewController isKindOfClass:[MYPresentedController class]]) {
            MYPresentedController *presentedVc           = (MYPresentedController *)self.presentedViewController;
            presentedVc.presented                        = NO;
        }
        [self.coverView removeFromSuperview];
    }];
}

- (CGFloat)animationDuration
{
    CGFloat duration = 0.0;
    switch (_style) {
        case MYPresentedViewShowStyleFromTopDropStyle:
        case MYPresentedViewShowStyleFromBottomDropStyle:
        case MYPresentedViewShowStyleFromTopSpreadStyle:
        case MYPresentedViewShowStyleFromBottomSpreadStyle:
            
            duration = 0.25;
            break;
        case MYPresentedViewShowStyleFromTopSpringStyle:
        case MYPresentedViewShowStyleFromBottomSpringStyle:
            
            duration = 0.5;
            break;
        case MYPresentedViewShowStyleSuddenStyle:
            
            duration = 0.1;
            break;
        default:
            break;
    }
    return duration;
}


@end
