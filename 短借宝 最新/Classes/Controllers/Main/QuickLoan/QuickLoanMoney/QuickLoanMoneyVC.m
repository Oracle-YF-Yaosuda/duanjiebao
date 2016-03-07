//
//  QuickLoanMoneyVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/10.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "QuickLoanMoneyVC.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "Networking.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "ExamineCharacherTVC.h"
#import "LoanInfomationVC.h"
#import "MBProgressHUD.h"
#import "LeftRegisterVC.h"

#import "Header.h"
#import "JSONKit.h"


@interface QuickLoanMoneyVC ()<ASValueTrackingSliderDataSource>{
    
    MBProgressHUD *HUD;
    
    float width,heig;
    
}

@property (strong, nonatomic)  ASValueTrackingSlider *topSlider;
@property (strong, nonatomic)  ASValueTrackingSlider *bottomSlider;

@property (strong, nonatomic)  UILabel *toptext;

@property (strong, nonatomic)  UILabel *bottomtext;
@property (strong, nonatomic)  UILabel *feilu;
@property (strong, nonatomic)  UILabel *huankuanshuoming;
@property (strong, nonatomic)  UIScrollView *huadong;
@property (strong, nonatomic)  UIView *Containerview;
@property (weak, nonatomic)  NSLayoutConstraint *ConViewHeight;
@property (weak, nonatomic)  NSLayoutConstraint *ConVIewWeight;
//普通贷款利率
@property CGFloat pt_jblv;
@end

@implementation QuickLoanMoneyVC

#pragma mark - Setter Getter Methods



- (void)viewDidLoad {
    [super viewDidLoad];
   // self.feilu.text=100*7*   *0.001];
    _toptext.text=@"100元";
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    _huadong=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    
    _huadong.contentSize=CGSizeMake(width, heig);
    
    _huadong.canCancelContentTouches=YES;
    
    _huadong.delaysContentTouches=NO;
    
    
    //手动添加界面
    
    //金钱及其他信息查看界面
    
    
    for (int i=0; i<3; i++) {
        
        UIView *topview1;
        
        if (i==1) {
            
            topview1=[[UIView alloc]initWithFrame:CGRectMake(i*1.0*width/3-1, 0, width/3+2, 50)];
            UIButton *bb1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, topview1.frame.size.width, topview1.frame.size.height)];
            [bb1 setImage:[UIImage imageNamed:@"putongjiekuan_06"] forState:UIControlStateNormal];
            [bb1 setTitle:@"借款时间" forState:UIControlStateNormal];
            
            [bb1 setTitleColor:[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f] forState:UIControlStateNormal];
            
            bb1.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            
            bb1.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 0);
            
            [topview1 addSubview:bb1];
            bb1.userInteractionEnabled=NO;
            
        }
        else if (i==2) {
            
            topview1=[[UIView alloc]initWithFrame:CGRectMake(i*1.0*width/3, 0, width/3, 50)];
            UIButton *bb1=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, topview1.frame.size.width, topview1.frame.size.height)];
            [bb1 setImage:[UIImage imageNamed:@"jinqian_123"] forState:UIControlStateNormal];
            [bb1 setTitle:@"借款费用" forState:UIControlStateNormal];
            
            [bb1 setTitleColor:[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f] forState:UIControlStateNormal];
            
            bb1.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            bb1.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 0);
            [topview1 addSubview:bb1];
            bb1.userInteractionEnabled=NO;
            
            
            
        }
        else{
            topview1=[[UIView alloc]initWithFrame:CGRectMake(i*1.0*width/3, 0, width/3, 50)];
            
            
            UIButton *bb1=[[UIButton alloc] initWithFrame:topview1.frame];
            [bb1 setImage:[UIImage imageNamed:@"putongjiekuan_03"] forState:UIControlStateNormal];
            [bb1 setTitle:@"借款金额" forState:UIControlStateNormal];
            
            [bb1 setTitleColor:[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f] forState:UIControlStateNormal];
            
            bb1.titleLabel.font=[UIFont systemFontOfSize:14.0f];
            bb1.titleEdgeInsets=UIEdgeInsetsMake(0, 6, 0, 0);
            [topview1 addSubview:bb1];
            bb1.userInteractionEnabled=NO;
            
            
        }
        
        //
        [topview1.layer setBorderWidth:1.0f];
        [topview1.layer setBorderColor:[[UIColor colorWithRed:192.0/255 green:192.0/255  blue:192.0/255  alpha:1.0f] CGColor]];
        
        topview1.backgroundColor=[UIColor whiteColor];
        [_huadong addSubview:topview1];
        
        //贷款金额
        
        UIView *topview2;
        
        if (i==1) {
            
            topview2=[[UIView alloc]initWithFrame:CGRectMake(i*1.0*width/3-1, 49, width/3+2, 50)];
            
            _bottomtext=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, topview2.frame.size.width, topview2.frame.size.height)];
            
            _bottomtext.text=@"7天";
            _bottomtext.textAlignment=NSTextAlignmentCenter;
            _bottomtext.textColor=[UIColor colorWithRed:104.0/255 green:159.0/255 blue:56.0/255 alpha:1.0f];
            
            if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
            _bottomtext.font=[UIFont systemFontOfSize:19 weight:2];
            else
                _bottomtext.font=[UIFont systemFontOfSize:19];
            
            [topview2 addSubview:_bottomtext];
            
        }
        else if (i==2) {
            
            topview2=[[UIView alloc]initWithFrame:CGRectMake(i*1.0*width/3, 49, width/3, 50)];
            _feilu=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, topview2.frame.size.width, topview2.frame.size.height)];
            
            NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
            if ([[defaults3 objectForKey:@"DaiKuanLeiXing"] intValue]==1)
            _feilu.text=@"14.00元";
                
            else
            
            self.feilu.text=@"元";
            _feilu.textAlignment=NSTextAlignmentCenter;
            _feilu.textColor=[UIColor colorWithRed:1 green:143.0/255 blue:0 alpha:1.0f];
            if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
                _feilu.font=[UIFont systemFontOfSize:19 weight:2];
            else
                _feilu.font=[UIFont systemFontOfSize:19];
            
            [topview2 addSubview:_feilu];
            
        }
        else{
            
            topview2=[[UIView alloc]initWithFrame:CGRectMake(i*1.0*width/3, 49, width/3,50)];
            _toptext=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, topview2.frame.size.width, topview2.frame.size.height)];
            
            _toptext.text=@"100元";
            _toptext.textAlignment=NSTextAlignmentCenter;
            _toptext.textColor=[UIColor colorWithRed:41.0/255 green:182.0/255 blue:246.0/255 alpha:1.0f];
            if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
                _toptext.font=[UIFont systemFontOfSize:19 weight:2];
            else
                _toptext.font=[UIFont systemFontOfSize:19];
            
            [topview2 addSubview:_toptext];
            
        }
        [topview2.layer setBorderWidth:1.0f];
        [topview2.layer setBorderColor:[[UIColor colorWithRed:192.0/255 green:192.0/255  blue:192.0/255  alpha:1.0f] CGColor]];
        
        topview2.backgroundColor=[UIColor colorWithRed:228.0/255 green:228.0/255  blue:228.0/255  alpha:1.0f];
        [_huadong addSubview:topview2];
        
    }
    
    
    
    _topSlider =[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(25, 130, width-50, 30)];
    UILabel*lable1=[[UILabel alloc] initWithFrame:CGRectMake(25, 165, 40, 20)];
    UILabel*lable2=[[UILabel alloc] initWithFrame:CGRectMake(width-65, 165, 40, 20)];
    UILabel*lable3=[[UILabel alloc] initWithFrame:CGRectMake(35, 242, 40, 20)];
    UILabel*lable4=[[UILabel alloc] initWithFrame:CGRectMake(width-55, 242, 40, 20)];
    lable1.textColor =[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    lable2.textColor =[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    lable3.textColor =[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    lable4.textColor =[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    [_huadong addSubview:lable4];
    [_huadong addSubview:lable3];
    [_huadong addSubview:lable2];
    [_huadong addSubview:lable1];
    [_huadong addSubview:_topSlider];
    _bottomSlider =[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(25, 210, width-50, 30)];
    [_huadong addSubview:_bottomSlider];
    
    _topSlider.dataSource=self;
    
    _bottomSlider.dataSource=self;
    
    [_topSlider addTarget:self action:@selector(top:) forControlEvents:UIControlEventValueChanged];
    
    [_bottomSlider addTarget:self action:@selector(buttom:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    
    
    //我要贷款确认按钮界面
    UIView *view_QueRen;
    
    if (heig==480) {
        view_QueRen=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 280, width,heig-180)];
    }
    else
    view_QueRen=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 280, width,heig-280)];
    
    
    view_QueRen.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    [_huadong addSubview:view_QueRen];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,view_QueRen.frame.origin.y/16, view_QueRen.frame.size.width, 20)];
    label.text=@"请选择贷款金额和期限";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor =[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    UIFont * tfont = [UIFont systemFontOfSize:14];
    label.font = tfont;
    [view_QueRen addSubview:label];
    
    UIButton *Btn_XiaYiBu=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+30,CGRectGetMaxY(label.frame)+5 , view_QueRen.frame.size.width-60, 44)];
    [Btn_XiaYiBu setBackgroundImage:[UIImage imageNamed:@"enniuzhengchang2x_03"] forState:UIControlStateNormal];
    [Btn_XiaYiBu setTitle:@"我要借款" forState:UIControlStateNormal];
    [Btn_XiaYiBu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Btn_XiaYiBu.titleLabel.font=[UIFont systemFontOfSize: 14.0];
    [Btn_XiaYiBu addTarget:self action:@selector(TiaoZhuanPAnDuan:) forControlEvents:UIControlEventTouchUpInside];
    [view_QueRen addSubview:Btn_XiaYiBu];
    
    
    UILabel *shuomi=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(Btn_XiaYiBu.frame)+20, width, 20)];
    
    shuomi.text=@"借款说明";
    shuomi.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    [view_QueRen addSubview:shuomi];
    
    _huankuanshuoming=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(shuomi.frame)+10, width-32, 20)];
    
    _huankuanshuoming.text=@" ";
    

    _huankuanshuoming.backgroundColor=[UIColor clearColor];
    
    [view_QueRen addSubview:_huankuanshuoming];

    [self.view addSubview:_huadong];
    
    _huadong.backgroundColor=[UIColor whiteColor];
    
    
    //
    
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    HUD.removeFromSuperViewOnHide=YES;
    
    // 更新界面
    [_topSlider setThumbImage:[UIImage imageNamed:@"putongjiekuan_17"] forState:UIControlStateNormal];
    [_bottomSlider setThumbImage:[UIImage imageNamed:@"putongjiekuan_15"] forState:UIControlStateNormal];
 
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        
        //
        //    包括dxyzm:短信验证码 zcsjhm：用户注册手机号码 password：注册密码
        
        
        NSString *url2 = [NSString stringWithFormat:@"%@androidIndexAction!indexInit.action",networkAddress];
        
        NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //        NSLog(@"url--%@",url2);
        
        [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            @try
            {
                
                NSLog(@"\njiekuangkjie\n\n-----\n%@",responseObject);
                lable1.text=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkjemin"]];
                lable2.text=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkjemax"]];
                lable3.text=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkqxmin"]];
                lable4.text=[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkqxmax"]];
                _bottomtext.text=[NSString stringWithFormat:@"%@天",[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkqxmin"]];
                _feilu.text=[NSString stringWithFormat:@"%.2f元",[[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkjemin"] intValue]*[[[responseObject objectForKey:@"jdlv"] objectForKey:@"jkqxmin"] intValue]*[[[responseObject objectForKey:@"jdlv"] objectForKey:@"pt_jblv"] floatValue]*0.001];
                [HUD hide:YES];
                HUD=nil;
                
                
                NSDictionary *weatherInfo = [responseObject objectForKey:@"jdlv"];
                
                
                self.ConViewHeight.constant = [UIScreen mainScreen].bounds.size.height;
                self.ConVIewWeight.constant = [UIScreen mainScreen].bounds.size.width;
                
                
                _huankuanshuoming.frame=CGRectMake(20, _huankuanshuoming.frame.origin.y, width-40, 20);
                _huankuanshuoming.text=[NSString stringWithFormat:@"\t%@",[weatherInfo objectForKey:@"lvsm"]];
                _huankuanshuoming.font=[UIFont systemFontOfSize:13.0f];
                _huankuanshuoming.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
                
                _huankuanshuoming.numberOfLines=0;
                
                [_huankuanshuoming sizeToFit];
                
                _huadong.contentSize=CGSizeMake(width, CGRectGetHeight(_huankuanshuoming.frame)+500);
                
                NSLog(@"gap---%f",CGRectGetHeight(_huankuanshuoming.frame)+540);
                
                self.pt_jblv=[weatherInfo[@"pt_jblv"] floatValue];
                
                NSNumberFormatter *tempFormatter1 = [[NSNumberFormatter alloc] init];
                //后尾加两零
                [tempFormatter1 setPositiveSuffix:@"00"];
                [tempFormatter1 setNegativeSuffix:@"00"];
                
                self.topSlider.minimumValue = [weatherInfo[@"jkjemin"] floatValue]/100;
                self.topSlider.maximumValue = [weatherInfo[@"jkjemax"] floatValue]/100;
                
                
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
            
            [HUD hide:YES];
            HUD=nil;
            
            HUD=[[MBProgressHUD alloc] initWithView:self.view];
            
            [self.view addSubview:HUD];
            
            
            HUD.mode =MBProgressHUDModeText;
            
            HUD.labelText =@"网络未连接，请重试！";
            
            HUD.margin = 10.f;
            
            [HUD setRemoveFromSuperViewOnHide:YES];
            
            [HUD hide:YES afterDelay:2];


            NSLog(@"%@",error);
            
        }];
    
        self.title=@"我要借款";
    
    

    self.view.backgroundColor=[UIColor whiteColor];
    
    
}

- (void)TiaoZhuanPAnDuan:(UIButton *)sender {
    
    [self ShiFouFeYiDaiKuan];
}
-(void)panduan{
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
   
        
        if ([[defaults3 objectForKey:@"DaiKuanShiFouKeYi"] integerValue]==1) {
            
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.yOffset=100;
            
            
            UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
            ll.backgroundColor=[UIColor clearColor];
            
            ll.text=@"您当前有未还清账单，还不能再次申请贷款！";
            ll.textColor=[UIColor whiteColor];
            
            ll.numberOfLines=0;
            
            [ll sizeToFit];
            
            HUD.customView=ll;
            

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

-(void)ShiFouFeYiDaiKuan
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"true"] intValue]!=1) {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请先登录";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
    }
    else{
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",nil];
    //    NSLog(@"%@",[defaults3 objectForKey:@"zhid"]);
    
    NSString *strJson = [dataDictionary JSONString];
    //    NSLog(@"%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!queryHydk_flag.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try
        {
            
            NSLog(@"Success----: %@", responseObject);
            //        NSLog(@"Success: %@", [responseObject[0] objectForKey:@"flag"]);
            
            if ([[responseObject[0] objectForKey:@"flag"] intValue]==0)
            {
                [defaults3 setObject:[responseObject[0] objectForKey:@"flag"] forKey:@"DaiKuanShiFouKeYi"];
                [defaults3 setObject:[responseObject[0] objectForKey:@"massages"] forKey:@"DaiKuanShuChuXinXi"];
                
                [self panduan];
                
            }
            else{
                
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = [responseObject[0] objectForKey:@"massages"];
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];
                
                
            }
 
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
    
    }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)top:(UISlider*)sender {
    
    self.feilu.text=[NSString stringWithFormat:@"%.2f元",[self.toptext.text intValue]*[self.bottomtext.text intValue]*self.pt_jblv*0.001];
    //    NSLog(@"%f",self.pt_jblv);
    
    self.toptext.text=[NSString stringWithFormat:@"%d元",((int)sender.value)*100];
    
     NSLog(@"-top--%@--%@--%@",self.bottomtext.text,self.toptext.text,self.feilu.text);
    
}


- (IBAction)buttom:(UISlider *)sender {
    
    self.feilu.text=[NSString stringWithFormat:@"%.2f元",[self.toptext.text intValue]*[self.bottomtext.text intValue]*self.pt_jblv*0.001];
    //    NSLog(@"%f",self.pt_jblv);
    
    
    self.bottomtext.text=[NSString stringWithFormat:@"%d天",(int)sender.value];
    
    NSLog(@"---%@--%@--%@",self.bottomtext.text,self.toptext.text,self.feilu.text);
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
