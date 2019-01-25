//
//  HJUserInfoView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserInfoView.h"
#import "HJUserInfoCell.h"
#import "HJUserInfoFootView.h"

@interface HJUserInfoView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end


static NSString *const HJUserInfoCellIdentifier = @"HJUserInfoCell";
static NSString *const HJUserInfoHeadIdentifier = @"HJUserInfoHead";
static NSString *const HJUserInfoFootIdentifier = @"HJUserInfoFoot";
@implementation HJUserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#f5f5f5"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:self.tableView];
    
    [self.dataSource setArray:@[@[@{@"昵称":@"呵呵"}],@[@{@"支付宝绑定":@""},@{@"微信绑定":@""},@{@"淘宝绑定":@""}],@[@{@"修改手机号":@""},@{@"修改密码":@""},@{@"清理缓存":@""}]]];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:HJUserInfoCellIdentifier];
    if (!cell) {
        cell = [[HJUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJUserInfoCellIdentifier];
    }
    NSDictionary *dic  = [self.dataSource objectAtIndex:indexPath.section][indexPath.row];
    NSArray *keys = [dic allKeys];
    NSString *title = [keys objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = title;
    cell.valueLab.text = [dic valueForKey:title];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HJUserInfoHeadIdentifier];
    if (!headView) {
        headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HJUserInfoHeadIdentifier];
        headView.frame = CGRectMake(0, 0, MaxWidth, 150);
        CGFloat headSize = 60;
        UIImageView *headImageView = [[UIImageView alloc] init];
        _headImageView = headImageView;
        headImageView.image = [UIImage imageNamed:@"default_avatar"];
        headImageView.layer.borderColor = [UIColor jk_colorWithHexString:@"#f5f5f5"].CGColor;
        headImageView.layer.borderWidth = 3.0;
        headImageView.layer.cornerRadius = headSize/2;
        headImageView.clipsToBounds = YES;
        [headView addSubview:headImageView];
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(headView.mas_centerX).offset(0);
            make.top.mas_offset(30);
            make.width.height.mas_equalTo(headSize);
        }];
        UILabel *tip = [[UILabel alloc] init];
        tip.text = @"点击修改头像";
        tip.textAlignment = NSTextAlignmentCenter;
        tip.font = [UIFont systemFontOfSize:13];
        tip.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
        [headView addSubview:tip];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(headView.mas_centerX).offset(0);
            make.top.mas_equalTo(headImageView.mas_bottom).offset(15);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(20);
        }];
        [headView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if ([self.delegate respondsToSelector:@selector(cellDidSelected:args:)]) {
                [self.delegate cellDidSelected:USERHeadImageClick args:nil];
            }
        }];
        [tip jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if ([self.delegate respondsToSelector:@selector(cellDidSelected:args:)]) {
                [self.delegate cellDidSelected:USERHeadImageClick args:nil];
            }
        }];
    }
    headView.contentView.backgroundColor = [UIColor whiteColor];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HJUserInfoFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HJUserInfoFootIdentifier];
    if (!footView) {
        footView = [[HJUserInfoFootView alloc] initWithReuseIdentifier:HJUserInfoFootIdentifier];
    }
    footView.commitBtn.hidden = section != 2;
    footView.commitBlock = ^(id obj) {
        if ([self.delegate respondsToSelector:@selector(cellDidSelected:args:)]) {
            [self.delegate cellDidSelected:USERInfoSaveClick args:nil];
        }
    };
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 90;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = 0;
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                tag = USERNameUpdateClick;
            }
            break;
        case 1:
            if(indexPath.row == 0){
                tag = USERZFBBindClick;
            }
            if(indexPath.row == 1){
                tag = USERWeChatBindClick;
            }
            if(indexPath.row == 2){
                tag = USERTaoBaoBindClick;
            }
            break;
        case 2:
            if(indexPath.row == 0){
                tag = USERMobileUpdateClick;
            }
            if(indexPath.row == 1){
                tag = USERPSWUpdateClick;
            }
            if(indexPath.row == 2){
                tag = USERCacheClearClick;
            }
            break;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(cellDidSelected:args:)]) {
        [self.delegate cellDidSelected:tag args:nil];
    }
}


@end
