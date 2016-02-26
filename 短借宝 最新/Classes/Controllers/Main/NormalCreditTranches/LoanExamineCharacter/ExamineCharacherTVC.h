//
//  ExamineCharacherTVC.h
//  短借宝
//
//  Created by iMac21 on 15/8/5.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamineCharacherTVC : UITableViewController

//贷款信息页面
@property (weak, nonatomic) IBOutlet UITextField *JinEw;
@property (weak, nonatomic) IBOutlet UITextField *QiXianw;
@property (weak, nonatomic) IBOutlet UITextField *LiXiw;

//借款信息跳转button
@property (weak, nonatomic) IBOutlet UIButton *JieKuanXinXi_Button;
@property (weak, nonatomic) IBOutlet UITextField *JieKuanJinE;
@property (weak, nonatomic) IBOutlet UITextField *JIeKuanQiXian;
@property (weak, nonatomic) IBOutlet UITextField *JieKuanLiXi;
//个人信息跳转button
@property (weak, nonatomic) IBOutlet UIButton *PuTongGeRenXinXi_BianJi_Buttton;
@property (weak, nonatomic) IBOutlet UITextField *FangJianHao;//
@property (weak, nonatomic) IBOutlet UITextField *PuTongZhuanYe;//
@property (weak, nonatomic) IBOutlet UITextField *PuTongBanji;//
@property (weak, nonatomic) IBOutlet UITextField *GongYuHao;//


@property (weak, nonatomic) IBOutlet UITextField *PuTongName;//真实姓名
@property (weak, nonatomic) IBOutlet UITextField *PuTongShengRi;//出生日期
@property (weak, nonatomic) IBOutlet UITextField *XingBie;//性别
@property (weak, nonatomic) IBOutlet UILabel *PuTongShenFenZhengHao;//身份证
@property (weak, nonatomic) IBOutlet UITextField *PuTongShengshi;//省市
@property (weak, nonatomic) IBOutlet UITextField *PuTongChuanhao;//详细地址
@property (weak, nonatomic) IBOutlet UITextField *PuTongDaXueMing;//大学名
@property (weak, nonatomic) IBOutlet UITextField *XueHao;//学号
@property (weak, nonatomic) IBOutlet UITextField *PuTongZhanghao;//学信网账号
@property (weak, nonatomic) IBOutlet UITextField *PuTongMiMa;//学信网密码
@property (weak, nonatomic) IBOutlet UITextField *PuTongYinHang;//银行名称
@property (weak, nonatomic) IBOutlet UITextField *PuTongKaHao;//银行卡号
@property (weak, nonatomic) IBOutlet UITextField *PuTongXingMing;//开卡人姓名
@property (weak, nonatomic) IBOutlet UITextField *PuTongMingCheng;

@property (weak, nonatomic) IBOutlet UIImageView *PuTongShenFenZheng;//身份证正面
@property (weak, nonatomic) IBOutlet UIImageView *PuTongXueShengZheng;//学生证
@property (weak, nonatomic) IBOutlet UIImageView *PuTongZiPaiiZhao;//自拍照
@property (weak, nonatomic) IBOutlet UIImageView *ShenFenZhenFanMian;//身份证反面
@property (weak, nonatomic) IBOutlet UITextField *PuTongJiaZhangGuanXi;//家长关系
@property (weak, nonatomic) IBOutlet UITextField *PuTongJiaZhangXingMing;//家长姓名
@property (weak, nonatomic) IBOutlet UITextField *PuTongJiaZhangShouJiHao;//家长手机号
@property (weak, nonatomic) IBOutlet UITextField *PuTongDaoYuanXingMing;
@property (weak, nonatomic) IBOutlet UITextField *PuTongDaoYuanShouJiHao;
@property (weak, nonatomic) IBOutlet UITextField *PuTongTongXueXingMing;
@property (weak, nonatomic) IBOutlet UITextField *PuTongTongXueShouJiHao;
@property (weak, nonatomic) IBOutlet UITextField *PuTongTongXue2XingMing;
@property (weak, nonatomic) IBOutlet UITextField *PuTongTongXue2ShouJiHao;


//银行卡信息跳转button
@property (weak, nonatomic) IBOutlet UIButton *PuTongYInHangKaXinXi_BianJi_Button;

//照片资料信息跳转button
@property (weak, nonatomic) IBOutlet UIButton *PuTongZhaoPian_BianJi_Button;
//联系人信息页面跳转BUTTON
@property (weak, nonatomic) IBOutlet UIButton *PuTongLianXiRen_BianJi_Button;

@end
