//
//  PersonalnformationTVC.h
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol hideDelegate <NSObject>

@optional

-(void)hid;

@end

@interface PersonalnformationTVC : UITableViewController<UITextFieldDelegate>

@property (retain ,nonatomic)id<hideDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_Name_Field;
@property (weak, nonatomic) IBOutlet UIButton *GeRenXinXI_Button_Man;
@property (weak, nonatomic) IBOutlet UIImageView *GeRenXinXi_Image_Man;
@property (weak, nonatomic) IBOutlet UIButton *GeRenXinXI_Button_Woman;
@property (weak, nonatomic) IBOutlet UIImageView *GeRenXinXI_Image_Woman;
@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_ShengRi_Field;
//@property (weak, nonatomic) IBOutlet  *GeRenXinXi_ShenFenZhenHao_Field;
@property (weak, nonatomic) IBOutlet UILabel *GeRenXinXi_ShenFenZhenHao_Field;
@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_SuoZaiDaXue_Field;
@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_SuoZaiZhuanYe_Field;
@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_BanJi_Field;
@property (weak, nonatomic) IBOutlet UITextField *XUeHao;
@property (weak, nonatomic) IBOutlet UITextField *GongYuHao;
@property (weak, nonatomic) IBOutlet UITextField *GongyuLouHao;
@property (weak, nonatomic) IBOutlet UITextField *FangJianHao;
@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_XueXinWangZhangHao_Field;
@property (weak, nonatomic) IBOutlet UITextField *GeRenXinXi_XueXinWangMiMai_Field;
@property (weak, nonatomic) IBOutlet UITextField *JiaTingZhuZhi;

@end
