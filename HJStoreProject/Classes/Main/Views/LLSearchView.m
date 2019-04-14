//
//  LLSearchView.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchView.h"

@interface LLSearchView ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) UIView *hotSearchView;

@end
@implementation LLSearchView

- (instancetype)initWithFrame:(CGRect)frame hotArray:(NSMutableArray *)hotArr historyArray:(NSMutableArray *)historyArr
{
    if (self = [super initWithFrame:frame]) {
        self.hotArray = hotArr;
        [self addSubview:self.hotSearchView];
    }
    return self;
}


- (UIView *)hotSearchView
{
    if (!_hotSearchView) {
        self.hotSearchView = [self setViewWithOriginY:0 title:@"热门搜索" textArr:self.hotArray];
    }
    return _hotSearchView;
}


- (UIView *)setViewWithOriginY:(CGFloat)riginY title:(NSString *)title textArr:(NSMutableArray *)textArr
{
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, MaxWidth - 30 - 45, 30)];
    titleL.text = title;
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleL];

    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [self getWidthWithStr:text] + 30;
        if (letfWidth + width + 15 > MaxWidth) {
            y += 40;
            letfWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:12];
        label.text = text;
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        label.backgroundColor = [UIColor whiteColor];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [view addSubview:label];
        letfWidth += width + 10;
    }
    view.frame = CGRectMake(0, riginY, MaxWidth, y + 40);
    return view;
}


- (void)tagDidCLick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    if (self.tapAction) {
        self.tapAction(label.text);
    }
}

- (CGFloat)getWidthWithStr:(NSString *)text
{
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MaxWidth, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.width;
    return width;
}



- (void)removeTestDataWithTextArr:(NSMutableArray *)testArr index:(int)index
{
    NSRange range = {index, testArr.count - index - 1};
    [testArr removeObjectsInRange:range];
    [NSKeyedArchiver archiveRootObject:testArr toFile:KHistorySearchPath];
}



@end
