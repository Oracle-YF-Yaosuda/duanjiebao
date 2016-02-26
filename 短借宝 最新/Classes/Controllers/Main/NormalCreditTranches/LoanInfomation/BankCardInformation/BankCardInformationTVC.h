//
//  BankCardInformationTVC.h
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol hideDelegate1 <NSObject>

@optional

-(void)hid1;

@end

@interface BankCardInformationTVC : UITableViewController

@property (retain ,nonatomic)id<hideDelegate1>delegate;

@property (weak, nonatomic) IBOutlet UITextField *YinHangKaXinXi_YinHangKaHao_Field;
@property (weak, nonatomic) IBOutlet UITextField *YinHangKaXinXi_KaiHuRenXingMing_Field;
@property (weak, nonatomic) IBOutlet UITextField *YinHangKaXinXi_KaiHuMingCheng_Field;

@end
