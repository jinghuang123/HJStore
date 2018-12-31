//
//  ViewController.h
//  MYPresentation
//
//  Created by qc on 2017/5/3.
//  Copyright © 2017年 qc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPresentedController.h"
#import "MYColorBackView.h"

@interface MYPresentationController : UIPresentationController

@property (nonatomic, assign) MYPresentedViewShowStyle style;
@property (nonatomic, assign,getter=isNeedClearBack) BOOL clearBack;
//蒙板背景展示图(只处理颜色展示)
@property (nonatomic, strong) MYColorBackView *colorBackView;
//frame
@property (assign, nonatomic) CGRect showFrame;


@property (nonatomic, copy) void(^onClickPetInfo)(id obj);
@end
