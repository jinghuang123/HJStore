//
//  ViewController.h
//  MYPresentation
//
//  Created by qc on 2017/5/3.
//  Copyright © 2017年 qc. All rights reserved.
//


#import "MYPresentedController.h"


@interface MYPresentedController ()


@end

@implementation MYPresentedController


- (void)dealloc
{
    NSLog(@"MYPresentedController dealloc");
}

//管理
- (MYPresentAnimationManager *)animationManager
{
    if (!_animationManager) {
        _animationManager = [[MYPresentAnimationManager alloc]init];
    }
    return _animationManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)initWithShowFrame:(CGRect)showFrame ShowStyle:(MYPresentedViewShowStyle)showStyle callback:(handleBack)callback
{
    //断言
//    NSParameterAssert(![@(showStyle)isKindOfClass:[NSNumber class]]||![@(isBottomMenu)isKindOfClass:[NSNumber class]]);
    if (self = [super init]) {
        
        //设置管理
        weakify(self)
        self.transitioningDelegate          = self.animationManager;
        self.modalPresentationStyle         = UIModalPresentationCustom;
        self.callback                       = callback;
        self.animationManager.showStyle     = showStyle;
        self.animationManager.showViewFrame = showFrame;
        self.animationManager.onClickPetInfo = ^(id obj) {
            if (weak_self.callback) {
                weak_self.callback(obj);
            }
        };
    }
    return self;
}



- (void)setClearBack:(BOOL)clearBack
{
    _clearBack = clearBack;
    self.animationManager.clearBack = clearBack;
}

@end
