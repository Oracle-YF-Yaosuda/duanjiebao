//
//  TheContactInformationTVC.h
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableReloadDelegate.h"

@protocol hideDelegate3 <NSObject>

@optional

-(void)hid3;

@end

@interface  TheContactInformationTVC : UITableViewController
@property (retain ,nonatomic)id<hideDelegate3>delegate;

@property (weak, nonatomic) IBOutlet UIButton *LianXiRenXinXI_FuQin_Button;
@property (weak, nonatomic) IBOutlet UIImageView *LianXiRenXinXI_FuQin_Image;

@property (weak, nonatomic) IBOutlet UIButton *LianXiRenXinXi_MuQin_Button;
@property (weak, nonatomic) IBOutlet UIImageView *LianXiRenXinXi_MuQin_Image;

@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_Name_Field;
@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_PhoneNum_Field;
@property (weak, nonatomic) IBOutlet UIButton *LianXiRenXinXi_PhoneNum_button;

@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_DaoYuanName_Field;
@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_DaoYuanPhoneNum_Field;
@property (weak, nonatomic) IBOutlet UIButton *LianXiRenXinXi_DaoYuanPhoneNum_Button;

@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_XueShengName_Field;
@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_XueShengPhoneNum_Field;
@property (weak, nonatomic) IBOutlet UIButton *LianXiRenXinXi_XueShengPhoneNum_Button;

@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_XueShengName2_Field;
@property (weak, nonatomic) IBOutlet UITextField *LianXiRenXinXi_XueShengPhoneNum2_Field;
@property (weak, nonatomic) IBOutlet UIButton *LianXiRenXinXi_XueShengPhoneNum2_Button;




@end
