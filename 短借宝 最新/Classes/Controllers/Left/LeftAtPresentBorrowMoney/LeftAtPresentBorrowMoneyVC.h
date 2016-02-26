//
//  LeftAtPresentBorrowMoneyVC.h
//  短借宝
//
//  Created by iMac21 on 15/7/20.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "BaseVC.h"

@interface LeftAtPresentBorrowMoneyVC : BaseVC

@property (strong, nonatomic)  UILabel *JieKuanJinE;
@property (strong, nonatomic)  UILabel *HuanKuanTianShu;
@property (strong, nonatomic)  UILabel *JieKuanFeiYong;
@property (strong, nonatomic)  UILabel *HuanKuanJinE;
@property (strong, nonatomic)  UILabel *DaoZhangJinE;
@property (strong, nonatomic)  UILabel *JieKuanShiJian;
@property (strong, nonatomic)  UILabel *HuanKuanShiJian;

//贷款申请
@property (weak, nonatomic) IBOutlet UIImageView *DaiKuanShenQing_img;
@property (weak, nonatomic) IBOutlet UIView *DaiKuanShenQing_view;
//审核中
@property (weak, nonatomic) IBOutlet UIView *ShenHeZhong_view1;
@property (weak, nonatomic) IBOutlet UIImageView *ShenHeZhong_img;
@property (weak, nonatomic) IBOutlet UIView *ShenHeZhong_view2;
//已放款
@property (weak, nonatomic) IBOutlet UIView *YiFangKuan_view1;
@property (weak, nonatomic) IBOutlet UIImageView *YiFangKuan_img;
@property (weak, nonatomic) IBOutlet UIView *YIFangKuan_view2;
//已申请还款
@property (weak, nonatomic) IBOutlet UIView *YiShenQingHuanKuan_view1;
@property (weak, nonatomic) IBOutlet UIImageView *YiShenQingHuanKuan_img;
@property (weak, nonatomic) IBOutlet UIView *YiShenQingHuanKuan_view2;
//借款还清
@property (weak, nonatomic) IBOutlet UIView *ShenQingHuanKuan_view;
@property (weak, nonatomic) IBOutlet UIImageView *JieKuanHuanQing_img;






@end
