//
//  HJUserInfoCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserInfoCell.h"

@implementation HJUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}


- (void)initUI {
    UILabel *titleLab = [[UILabel alloc] init];
    _titleLab = titleLab;
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = [UIColor jk_colorWithHexString:@"#4f4f4f"];
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *nextImageV = [[UIImageView alloc] init];
    _nextImageV  = nextImageV;
    nextImageV.image = [UIImage imageNamed:@"set_icon_right"];
    [self.contentView addSubview:nextImageV];
    [nextImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(11);
    }];
    
    UILabel *valueLabel = [[UILabel alloc] init];
    _valueLab = valueLabel;
    valueLabel.textAlignment = NSTextAlignmentRight;
    valueLabel.font = [UIFont systemFontOfSize:15];
    valueLabel.textColor = [UIColor jk_colorWithHexString:@"#4f4f4f"];
    [self.contentView addSubview:valueLabel];
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
}


@end
