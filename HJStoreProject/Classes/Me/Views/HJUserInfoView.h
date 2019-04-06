//
//  HJUserInfoView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperView.h"

#define USERNameUpdateClick           0x00001
#define USERHeadImageClick            0x00002
#define USERZFBBindClick              0x00003
#define USERWeChatBindClick           0x00004
#define USERTaoBaoBindClick           0x00005
#define USERMobileUpdateClick         0x00006
#define USERPSWUpdateClick            0x00007
#define USERCacheClearClick           0x00008
#define USERAboutUsClick             0x00009
#define USERQuiteClick             0x000010


@protocol HJUserInfoViewDelegate <NSObject>
@required
-(void)viewSendMsg:(long) msgType args:(NSObject*) args;
@optional
-(void)cellDidSelected:(long) msgType args:(NSObject*) args;
@end

@interface HJUserInfoView : HJSuperView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) id<HJUserInfoViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *headImageView;
- (void)setDataSourceChange;
@end


