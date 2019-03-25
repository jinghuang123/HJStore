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
        self.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];
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
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    [self.dataSource setArray:@[@[@{@"":@"修改头像"}],@[@{@"昵称":@"呵呵"},@{@"支付宝绑定":@"绑定"},@{@"微信绑定":@"绑定"},@{@"淘宝绑定":@"绑定"}],@[@{@"修改手机号":@"修改"},@{@"修改密码":@"修改"},@{@"收益消息":@""}],@[@{@"清理缓存":@"110.3M"},@{@"关于我们":@""}]]];
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
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 50;
    }
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
    cell.headImageV.hidden = ![title isEqualToString:@""];
    cell.headImageV.image = [title isEqualToString:@""] ? [UIImage imageNamed:@"head_imageDefalut"] : nil;
    cell.valueLab.text = [dic valueForKey:title];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HJUserInfoFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HJUserInfoFootIdentifier];
    if (!footView) {
        footView = [[HJUserInfoFootView alloc] initWithReuseIdentifier:HJUserInfoFootIdentifier];
    }
    footView.quiteButton.hidden = section != 3;
    footView.commitBlock = ^(id obj) {
        if ([self.delegate respondsToSelector:@selector(cellDidSelected:args:)]) {
            [self.delegate cellDidSelected:USERQuiteClick args:nil];
        }
    };
    return footView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [tableView dequeueReusableCellWithIdentifier:HJUserInfoHeadIdentifier];
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 0.1)];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 90;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = 0;
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                tag = USERHeadImageClick;
            }
            break;
        case 1:
            if(indexPath.row == 0){
                tag = USERNameUpdateClick;
            }
            if(indexPath.row == 1){
                tag = USERZFBBindClick;
            }
            if(indexPath.row == 2){
                tag = USERWeChatBindClick;
            }
            if(indexPath.row == 3){
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
            case 3:
        {
            if(indexPath.row == 0){
                tag = USERCacheClearClick;
            }else if(indexPath.row == 1){
                tag = USERAboutUsClick;
            }
        }
            break;
    }
    if ([self.delegate respondsToSelector:@selector(cellDidSelected:args:)]) {
        [self.delegate cellDidSelected:tag args:nil];
    }
}


@end
