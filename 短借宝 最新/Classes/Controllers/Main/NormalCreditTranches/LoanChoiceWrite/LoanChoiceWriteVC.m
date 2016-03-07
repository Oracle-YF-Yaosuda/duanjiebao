//
//  LoanChoiceWriteVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/10.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LoanChoiceWriteVC.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "Networking.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "ExamineCharacherTVC.h"
#import "LoanInfomationVC.h"
#import "MBProgressHUD.h"
#import "LeftRegisterVC.h"
#import "Header.h"

@interface LoanChoiceWriteVC ()<ASValueTrackingSliderDataSource,UIGestureRecognizerDelegate>{
    
    MBProgressHUD *HUD;
    
}
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@property (weak, nonatomic) IBOutlet UILabel *lable4;


@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *topSlider;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *bottomSlider;

@property (weak, nonatomic) IBOutlet UILabel *toptext;

@property (weak, nonatomic) IBOutlet UILabel *bottomtext;
@property (weak, nonatomic) IBOutlet UILabel *feilu;
@property (weak, nonatomic) IBOutlet UILabel *huankuanshuoming;
@property (weak, nonatomic) IBOutlet UIScrollView *huadong;
@property (weak, nonatomic) IBOutlet UIView *Containerview;
- (IBAction)woyaojiekuan:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConVIewWeight;
//普通贷款利率
@property CGFloat pt_jblv;
@end

@implementation LoanChoiceWriteVC

#pragma mark - Setter Getter Methods


#warning 我要借款Button有一个判断钱数存进数据库
int xiaotian=-1;
- (void)viewDidLoad {
    _toptext.text=@"100";
//    [self ShiFouFeYiDaiKuan];
    
//    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
//    self.navigationController.interactivePopGestureRecognizer.delegate=nil;
   

    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    HUD.removeFromSuperViewOnHide=YES;
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        NSString *url2 = [NSString stringWithFormat:@"%@androidIndexAction!indexInit.action",networkAddress];
        
        NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //        NSLog(@"url--%@",url2);
        
        [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            @try
            {
                
                            NSLog(@"\n\n 界面数据  %@\n\n",responseObject);
                NSDictionary *weatherInfo = [responseObject objectForKey:@"jdlv"];
                
                _lable1.text=[NSString stringWithFormat:@"%@",[weatherInfo objectForKey:@"jkjemin"]];
                _lable2.text=[NSString stringWithFormat:@"%@",[weatherInfo objectForKey:@"jkjemax"]];
                _lable3.text=[NSString stringWithFormat:@"%@",[weatherInfo objectForKey:@"jkqxmin"]];
                _lable4.text=[NSString stringWithFormat:@"%@",[weatherInfo objectForKey:@"jkqxmax"]];
                
                self.ConViewHeight.constant = [UIScreen mainScreen].bounds.size.height;
                self.ConVIewWeight.constant = [UIScreen mainScreen].bounds.size.width;
                
                xiaotian=[[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkqxmin"] intValue];
                
                _huankuanshuoming.numberOfLines = 0;
                UIFont * tfont = [UIFont systemFontOfSize:12];
                _huankuanshuoming.font = tfont;
                _huankuanshuoming.backgroundColor = [UIColor whiteColor];
                _huankuanshuoming.text=[NSString stringWithFormat:@"\t%@",[weatherInfo objectForKey:@"lvsm"]];
                _bottomtext.text=[NSString stringWithFormat:@"%d",xiaotian];
                self.pt_jblv=[weatherInfo[@"pt_jblv"] floatValue];
                NSLog(@"----------------------%.2f",_pt_jblv);
                //线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新界面
                    [_topSlider setThumbImage:[UIImage imageNamed:@"putongjiekuan_17"] forState:UIControlStateNormal];
                    [_bottomSlider setThumbImage:[UIImage imageNamed:@"putongjiekuan_15"] forState:UIControlStateNormal];
                    // Do any additional setup after loading the view.
                    
                    
                    NSNumberFormatter *tempFormatter1 = [[NSNumberFormatter alloc] init];
                    //后尾加两零
                    [tempFormatter1 setPositiveSuffix:@"00"];
                    [tempFormatter1 setNegativeSuffix:@"00"];
                    
                    self.topSlider.minimumValue = [weatherInfo[@"jkjemin"] intValue]/100;
                    self.topSlider.maximumValue = [weatherInfo[@"jkjemax"] intValue]/100;
                    
                    
                    self.topSlider.dataSource = self;
                    [self.topSlider setNumberFormatter:tempFormatter1];
                    //    圆角
                    self.topSlider.popUpViewCornerRadius = 16.0;
                    
                    self.topSlider.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:13];
                    self.topSlider.textColor = [UIColor whiteColor];
                    
                    UIColor *coldBlue = [UIColor colorWithRed:41/255.0 green:182/255.0 blue:246/255.0 alpha:1];
                    
                    
                    self.topSlider.popUpViewAnimatedColors = @[coldBlue];
                    
                    //    2
                    
                    NSNumberFormatter *tempFormatter = [[NSNumberFormatter alloc] init];
                    [tempFormatter setPositiveSuffix:@""];
                    [tempFormatter setNegativeSuffix:@""];
                    
                    
                    
                    
                    self.bottomSlider.minimumValue = [weatherInfo[@"jkqxmin"] intValue];
                    self.bottomSlider.maximumValue = [weatherInfo[@"jkqxmax"] intValue];
                    
                    
                    self.bottomSlider.dataSource = self;
                    [self.bottomSlider setNumberFormatter:tempFormatter];
                    //    圆角
                    self.bottomSlider.popUpViewCornerRadius = 16.0;
                    
                    self.bottomSlider.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:13];
                    self.bottomSlider.textColor = [UIColor whiteColor];
                    
                    
                    UIColor *koldBlue = [UIColor colorWithRed:121/255.0 green:188/255.0 blue:50/255.0 alpha:1];
                    self.bottomSlider.popUpViewAnimatedColors = @[koldBlue];
                    
                    [HUD hide:YES];
                    
                });
                

            }
            @catch (NSException * e) {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText=@"请检查你的网络连接!";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
    });

    
}


- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    value = roundf(value);
    NSString *s;
    
    if (value > 29.0 && value < 50.0) {
        s = [NSString stringWithFormat:@"%@", [slider.numberFormatter stringFromNumber:@(value)]];
    } else if (value >= 50.0) {
        
    }
    return s;
}


- (IBAction)top:(UISlider*)sender {
    
    self.feilu.text=[NSString stringWithFormat:@"%.2f元",[self.toptext.text intValue]*[self.bottomtext.text intValue]*self.pt_jblv*0.001];
    //    NSLog(@"%f",self.pt_jblv);
    
    self.toptext.text=[NSString stringWithFormat:@"%d元",((int)sender.value)*100];
    
}


- (IBAction)buttom:(UISlider *)sender {
    
    self.feilu.text=[NSString stringWithFormat:@"%.2f元",[self.toptext.text intValue]*[self.bottomtext.text intValue]*self.pt_jblv*0.001];
    //    NSLog(@"%f",self.pt_jblv);
    
    
    self.bottomtext.text=[NSString stringWithFormat:@"%d天",(int)sender.value];
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)woyaojiekuan:(id)sender {
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"DaiKuanShiFouKeYi"] integerValue]==1) {
        
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = [defaults3 objectForKey:@"DaiKuanShuChuXinXi"];
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:3];
        
        
        
    }else{
        
        
        if ([defaults3 integerForKey:@"true"]==1) {
            
            //    或有真则为真
            NSLog(@"测试null%d",[[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@"null"]);
            NSLog(@"测试nil%d",[defaults3 objectForKey:@"GeRenXinXi_Name_Field"]==nil);
            NSLog(@"%lu",(unsigned long)[[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] length]);
            
            
            
            if ([[defaults3 objectForKey:@"GeRenXinXi_SuoZaiDaXue_Field"] isEqual:@""]||[[defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"] isEqual:@""]||[[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"] isEqual:@""]||[[defaults3 objectForKey:@"zjz1"] isEqual:@""]||[[defaults3 objectForKey:@"GeRenXinXi_SuoZaiDaXue_Field"] isEqual:@"null"]||[[defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"] isEqual:@"null"]||[[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"] isEqual:@"null"]||[[defaults3 objectForKey:@"zjz1"] isEqual:@"null"]) {
                
                [defaults3 setObject:[self.toptext.text substringToIndex:self.toptext.text.length-1] forKey:@"JinE"];
                [defaults3 setObject:[self.bottomtext.text substringToIndex:self.bottomtext.text.length-1] forKey:@"QiXian"];
                [defaults3 setObject:[self.feilu.text substringToIndex:self.feilu.text.length-1] forKey:@"FeiLu"];
                
                
                //        四个圈
                LoanInfomationVC *l=[self.storyboard instantiateViewControllerWithIdentifier:@"LoanInfomation"];
                l.shabi=@"hahah";
                [self.navigationController pushViewController:l animated:YES];
                
            }else{
                
                [defaults3 setObject:[self.toptext.text substringToIndex:self.toptext.text.length-1] forKey:@"JinE"];
                [defaults3 setObject:[self.bottomtext.text substringToIndex:self.bottomtext.text.length-1] forKey:@"QiXian"];
                [defaults3 setObject:[self.feilu.text substringToIndex:self.feilu.text.length-1] forKey:@"FeiLu"];
                
                ExamineCharacherTVC *l1=[self.storyboard instantiateViewControllerWithIdentifier:@"ExamineCharacher"];
                
                [self.navigationController pushViewController:l1 animated:YES];
                
                
                
            }
            
        }
        else
        {
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"请先登录";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:3];
            
            
            LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
            
            
            [self.navigationController
             pushViewController:left3 animated:YES];
            
            
            
            
        }
        
    }
    

}
@end
