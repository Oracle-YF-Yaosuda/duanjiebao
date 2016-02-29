//
//  ViewController.m
//  借贷宝
//
//  Created by imac21 on 15/7/5.
//  Copyright (c) 2015年 imac21. All rights reserved.
//
#import "ViewController.h"
#import "MainVC.h"
#import "LeftVC.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "Networking.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "EAIntroView.h"
#import "GuideViewController.h"
#import "APService.h"

#import "xiaoxiController.h"

#import "Header.h"


#import "LeftHuaViewController.h"



@interface ViewController ()<MainVCDelegate>{
    
    MBProgressHUD *HUD;
    
    UIButton *right;
    
}



@property (weak, nonatomic) IBOutlet UIBarButtonItem *barten;

/**
 *  滑动手势
 **/
@property (strong, nonatomic) UISwipeGestureRecognizer *gesture;
@property (strong, nonatomic) UISwipeGestureRecognizer *leftGesture;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

/**
 * 视图
 */
@property (strong, nonatomic) MainVC *main;
@property (strong, nonatomic) LeftHuaViewController *left;

@property (strong, nonatomic) LeftVC *left1;

@end

@implementation ViewController
#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    right=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [right setImage:[UIImage imageNamed:@"cehua_28"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(xiaoxi) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rig=[[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationItem.rightBarButtonItem=rig;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jie) name:@"tongzhi" object:nil];
    
    NSString *cunzai=[NSString stringWithFormat:@"%@/Documents/cun.plist",NSHomeDirectory()];
    
    NSFileManager *fm=[NSFileManager defaultManager];
    
    
    //    启动
   // if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    
    if (![fm fileExistsAtPath:cunzai])
    {
       // [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [@"sada" writeToFile:cunzai atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"第一次启动");
        
        [GuideViewController sharedGuide];
        [GuideViewController show];
        
    }
    [self tuisong];

//数据加载登录信息
    
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    
    NSLog(@"--%@－",[defaults1 objectForKey:@"tag"]);
    
    
    NSDictionary*myDic2=[defaults1 dictionaryForKey:@"myDictionary"];
    
     if (([[defaults1 objectForKey:@"tag"]intValue]==1)&& myDic2!=nil) {
    
    [self Sjjz];
         
     }

    
//    if ([defaults1 integerForKey:@"true"]==1) {
//        
//        [self Sjjz];
//        
//    }

    /**
     * 添加左视图、主视图
     */
    if (self.view.frame.size.height!=480) {
        [self.view addSubview:self.left1.view];
    }
    else
    
    [self.view addSubview:self.left.view];
    [self.view addSubview:self.main.view];
    
    /**
     * 添加左视图控制器、主视图控制器
     */
    
    if (self.view.frame.size.height!=480) {
        [self addChildViewController:self.left1];
    }
    else
    [self addChildViewController:self.left];
    
    
    
    [self addChildViewController:self.main];
    /**
     * 添加滑动手势
     */
    [self.main.view addGestureRecognizer:self.gesture];
    [self.main.view addGestureRecognizer:self.tapGesture];
    [self.view addGestureRecognizer:self.leftGesture];

    
}

-(void)jie{
    
    [right setImage:[UIImage imageNamed:@"cehua_242"] forState:UIControlStateNormal];
}

-(void)xiaoxi{
    
    [right setImage:[UIImage imageNamed:@"cehua_28"] forState:UIControlStateNormal];

    xiaoxiController *xx=[[xiaoxiController alloc] init];
    
    [self.navigationController pushViewController:xx animated:YES];
    
}

#warning 通知
-(void)tuisong{
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
}


- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"%@", error);
}

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
    
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    
    NSLog(@"%@",[[notification userInfo] valueForKey:@"RegistrationID"]);
    
    //self.image.image=[UIImage imageNamed:@"cehua_242"];
    
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
    
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *currentContent = [NSString
                                stringWithFormat:
                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterNoStyle
                                                               timeStyle:NSDateFormatterMediumStyle],
                                title, content, nil];
    NSLog(@"%@", currentContent);
    
//    self.image.image=[UIImage imageNamed:<#(NSString *)#>];

    
    
}



-(void)Sjjz{
    
#warning 网络状态判断
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
        NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
    
        NSDictionary*myDic2=[defaults2 dictionaryForKey:@"myDictionary"];
    
        NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[myDic2 valueForKey:@"name"],@"username",[myDic2 valueForKey:@"pass"],@"password",nil];
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jasonString = [writer stringWithObject:dataDictionary];
    
    NSLog(@"%@",jasonString);
    
    //
    //    包括dxyzm:短信验证码 zcsjhm：用户注册手机号码 password：注册密码
    
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidLogAction!login.action?login=%@",networkAddress,jasonString];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try
        {
            NSLog(@"\n----------------%@",responseObject);
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"--0--%@",resultDic );
            
            
            NSDictionary *dic=[resultDic objectForKey:@"hyxx"];
            NSDictionary *dic1=[resultDic objectForKey:@"hyzh"];
            
            
            NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
            //flag   判断0或1   登录
            [defaults3 setObject:[resultDic objectForKey:@"flag"] forKey:@"true"];
            if (![[dic objectForKey:@"hyxm"]isEqualToString: @"null"]) {
                [defaults3 setObject:[dic objectForKey:@"hyxm"] forKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"];
                [defaults3 setObject:[dic objectForKey:@"jtzz"] forKey:@"JiaTingZhuZhi"];
                
                [defaults3 setObject:[dic objectForKey:@"address"] forKey:@"GeRenXinXi_ShengShiQu_Field"];//地址
                [defaults3 setObject:[dic objectForKey:@"csrq"] forKey:@"GeRenXinXi_ShengRi_Field"];//生日
                [defaults3 setObject:[dic objectForKey:@"fjh"] forKey:@"FangJianHao"];//房间号
                if ([[dic objectForKey:@"xl"] isEqual:@"null"]) {
                    [defaults3 setObject:@" "  forKey:@"XUeHao"];
                }
                else{
                    [defaults3 setObject:[dic objectForKey:@"xl"] forKey:@"XUeHao"];
                }
                
                // [defaults3 setObject:[dic objectForKey:@"xl"] forKey:@"XUeHao"];//会员学号
                [defaults3 setObject:[dic objectForKey:@"hyxm"] forKey:@"GeRenXinXi_Name_Field"];
                //会员姓名
                //[defaults3 setObject:[dic objectForKey:@"id"] forKey:@"id"];//会员id
                [defaults3 setObject:[dic objectForKey:@"sex"] forKey:@"xingbie"];//性别
                [defaults3 setObject:[dic objectForKey:@"sfzh"] forKey:@"GeRenXinXi_ShenFenZhenHao_Field"];//身份证号
                [defaults3 setObject:[dic objectForKey:@"ssdz"] forKey:@"SuSheDiZhi"];//宿舍地址
                [defaults3 setObject:[dic objectForKey:@"sslh"] forKey:@"GongYuHao"];//宿舍楼号
                [defaults3 setObject:[dic objectForKey:@"szbj"] forKey:@"GeRenXinXi_BanJi_Field"];//所在班级
                [defaults3 setObject:[dic objectForKey:@"szdx"] forKey:@"GeRenXinXi_SuoZaiDaXue_Field"];//所在大学
                [defaults3 setObject:[dic objectForKey:@"szzy"] forKey:@"GeRenXinXi_SuoZaiZhuanYe_Field"];//所在专业
                //        [defaults3 setObject:[dic objectForKey:@"zhid"] forKey:@"zhid"];//会员账号id
                [defaults3 setObject:[dic objectForKey:@"xxwps"] forKey:@"GeRenXinXi_XueXinWangMiMai_Field"];//学信网密码
                [defaults3 setObject:[dic objectForKey:@"xxwzh"] forKey:@"GeRenXinXi_XueXinWangZhangHao_Field"];//学信网账号
            }else{
                [defaults3 setObject:@"" forKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"];
                [defaults3 setObject:@"" forKey:@"JiaTingZhuZhi"];
                
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_ShengShiQu_Field"];//地址
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_ShengRi_Field"];//生日
                [defaults3 setObject:@""forKey:@"FangJianHao"];//房间号
                
                [defaults3 setObject:@"" forKey:@"XUeHao"];//会员学号
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_Name_Field"];//会员姓名
                [defaults3 setObject:@"" forKey:@"xingbie"];//性别
                [defaults3 setObject:@"" forKey:@"SuSheDiZhi"];//宿舍地址
                [defaults3 setObject:@"" forKey:@"GongYuHao"];//宿舍楼号
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_BanJi_Field"];//所在班级
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_SuoZaiDaXue_Field"];//所在大学
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_SuoZaiZhuanYe_Field"];//所在专业
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_XueXinWangMiMai_Field"];//学信网密码
                [defaults3 setObject:@"" forKey:@"GeRenXinXi_XueXinWangZhangHao_Field"];//学信网账号
            }
            
            if (![[dic objectForKey:@"skyhkh"]isEqualToString:@"null"]) {
                //银行卡信息页面
#warning 银行卡信息页面
                
                [defaults3 setObject:[dic objectForKey:@"skyh"] forKey:@"bank"];//收款银行
                [defaults3 setObject:[dic objectForKey:@"skyhkh"] forKey:@"YinHangKaXinXi_YinHangKaHao_Field"];//收款银行卡号
                if ([[dic objectForKey:@"khhmc"] isEqual:@"null"]) {
                    [defaults3 setObject:@" "  forKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"];
                }
                else{
                    [defaults3 setObject:[dic objectForKey:@"khhmc"] forKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"];
                }
            }else {
                //银行卡信息页面
#warning 银行卡信息页面
                [defaults3 setObject:@"" forKey:@"bank"];//收款银行
                [defaults3 setObject:@"" forKey:@"YinHangKaXinXi_YinHangKaHao_Field"];//收款银行卡号
                [defaults3 setObject:@"" forKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"];
            }
            if (![[dic objectForKey:@"lxrdh"]isEqualToString:@"null"]) {
                //联系人页面
#warning 联系人页面
                [defaults3 setObject:[dic objectForKey:@"jjlxr_dy"] forKey:@"LianXiRenXinXi_DaoYuanName_Field"];//紧急联系人导员姓名
                [defaults3 setObject:[dic objectForKey:@"jjlxr_dysjh"] forKey:@"LianXiRenXinXi_DaoYuanPhoneNum_Field"];//紧急联系人导员手机号
                [defaults3 setObject:[dic objectForKey:@"jjlxr_tx1"] forKey:@"LianXiRenXinXi_XueShengName_Field"];//紧急联系人同学1姓名
                [defaults3 setObject:[dic objectForKey:@"jjlxr_tx1sjh"] forKey:@"LianXiRenXinXi_XueShengPhoneNum_Field"];//紧急联系人同学1手机号
                [defaults3 setObject:[dic objectForKey:@"jjlxr_tx2"] forKey:@"LianXiRenXinXi_XueShengName2_Field"];//紧急联系人同学2姓名
                [defaults3 setObject:[dic objectForKey:@"jjlxr_tx2sjh"] forKey:@"LianXiRenXinXi_XueShengPhoneNum2_Field"];//紧急联系人同学2手机号
                [defaults3 setObject:[dic objectForKey:@"lxrdh"] forKey:@"LianXiRenXinXi_PhoneNum_Field"];//紧急联系人（父&母）电话号
                [defaults3 setObject:[dic objectForKey:@"lxrgx"] forKey:@"fumu"];//紧急联系人选择（父&母）
                [defaults3 setObject:[dic objectForKey:@"lxrxm"] forKey:@"LianXiRenXinXi_Name_Field"];//紧急联系人（父&母）姓名
            }else{
                //联系人页面
#warning 联系人页面
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_DaoYuanName_Field"];//紧急联系人导员姓名
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_DaoYuanPhoneNum_Field"];//紧急联系人导员手机号
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_XueShengName_Field"];//紧急联系人同学1姓名
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_XueShengPhoneNum_Field"];//紧急联系人同学1手机号
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_XueShengName2_Field"];//紧急联系人同学2姓名
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_XueShengPhoneNum2_Field"];//紧急联系人同学2手机号
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_PhoneNum_Field"];//紧急联系人（父&母）电话号
                [defaults3 setObject:@"" forKey:@"fumu"];//紧急联系人选择（父&母）
                [defaults3 setObject:@"" forKey:@"LianXiRenXinXi_Name_Field"];//紧急联系人（父&母）姓名
            }
            if (![[dic objectForKey:@"zjz1"]isEqualToString:@"null"]&&![[dic objectForKey:@"zjz2"]isEqualToString:@"null"]&&![[dic objectForKey:@"zjz3"]isEqualToString:@"null"]&&![[dic objectForKey:@"zjz4"]isEqualToString:@"null"]) {
                //照片资料页面
#warning 照片资料页面
                [defaults3 setObject:[dic objectForKey:@"zjz1"] forKey:@"zjz1"];//身份证
                [defaults3 setObject:[dic objectForKey:@"zjz2"] forKey:@"zjz2"];//学生证
                [defaults3 setObject:[dic objectForKey:@"zjz3"] forKey:@"zjz3"];//个人自拍
                [defaults3 setObject:[dic objectForKey:@"zjz4"] forKey:@"zjz4"];//个人自拍
            }
            else{
                //照片资料页面
#warning 照片资料页面
                [defaults3 setObject:@"" forKey:@"zjz1"];//身份证
                [defaults3 setObject:@"" forKey:@"zjz2"];//学生证
                [defaults3 setObject:@"" forKey:@"zjz3"];//个人自拍
                [defaults3 setObject:@"" forKey:@"zjz4"];//身份证翻面
            }
            
            //        hyzh
            //会员黑名单
            [defaults3 setObject:[dic1 objectForKey:@"hmdbs"]forKey:@"HeiMingDan"];
            //会员诚信值
            [defaults3 setObject:[dic1 objectForKey:@"hycxz"]forKey:@"HuiYuanChengXinZhi"];
            //会员积分
            [defaults3 setObject:[dic1 objectForKey:@"hyjf"]forKey:@"HuiYuanJiFen"];
            [defaults3 setObject:[dic1 objectForKey:@"id"]forKey:@"hyid"];
            //        [defaults3 setObject:[dic1 objectForKey:@"password"]forKey:@"password"];
            //        [defaults3 setObject:[dic1 objectForKey:@"shbs"]forKey:@"shbs"];
            //        [defaults3 setObject:[dic1 objectForKey:@"shsj"]forKey:@"shsj"];
            //        [defaults3 setObject:[dic1 objectForKey:@"sjhm"]forKey:@"sjhm"];
            //        [defaults3 setObject:[dic1 objectForKey:@"username"]forKey:@"username"];
            //        [defaults3 setObject:[dic1 objectForKey:@"xxwsbs"]forKey:@"xxwsbs"];
            //        [defaults3 setObject:[dic1 objectForKey:@"zcsj"]forKey:@"zcsj"];
            
            
            
            
            [self ShiFouFeYiDaiKuan];
            
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"自动登录成功";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:1];
            

            
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
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"无法连接网络，请检查网络连接状态！";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
    }];
    
    
}

-(void)ShiFouFeYiDaiKuan
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
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
            
            [defaults3 setObject:[responseObject[0] objectForKey:@"flag"] forKey:@"DaiKuanShiFouKeYi"];
            [defaults3 setObject:[responseObject[0] objectForKey:@"massages"] forKey:@"DaiKuanShuChuXinXi"];
            
            

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
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"无法连接网络，请检查网络连接状态！";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];

        
    }];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([defaults3 integerForKey:@"true"]==1) {
        UILabel *ll=(UILabel*)[self.view viewWithTag:11];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        NSDictionary*myDic=[defaults dictionaryForKey:@"myDictionary"];
        
        ll.text=[myDic objectForKey:@"name"];
        
    }else{
        UILabel *ll=(UILabel*)[self.view viewWithTag:11];
        
        ll.text=@"点击登录/注册";
        
    }
  
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Load

- (UISwipeGestureRecognizer *)gesture {
    if (!_gesture) {
        _gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture)];
        _gesture.numberOfTouchesRequired = 1;
        _gesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _gesture;
}
- (UISwipeGestureRecognizer *)leftGesture {
    if (!_leftGesture) {
        _leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeGesture)];
        _leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        _leftGesture.numberOfTouchesRequired = 1;
    }
    return _leftGesture;
}
- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    }
    return _tapGesture;
}

- (LeftVC *)left1 {
    if (!_left1) {
        _left1 = [[LeftVC alloc] init];
        _left1 = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftVC"];
    }
    return _left1;
}

- (LeftHuaViewController *)left {
    if (!_left) {
        _left = [[LeftHuaViewController alloc] init];
        //_left = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftVC"];
    }
    return _left;
}


- (MainVC *)main {
    if (!_main) {
        _main = [[MainVC alloc] init];
        _main = [self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
        _main.delegate = self;
    }
    return _main;
}
#pragma mark - Gesture Action

- (void)handleSwipeGesture {
    
    self.barten.tag=8889;
    self.main.contentView.userInteractionEnabled=NO;
    
    CGRect rect = self.view.frame;
    rect.origin.x = 4*SCREEN_WIDTH/5.3;
    [UIView beginAnimations:nil context:nil];
    self.main.view.frame = rect;
    [UIView commitAnimations];
//    NSLog(@"侧滑");
    
    
}
- (void)handleLeftSwipeGesture {
    
    self.barten.tag=8888;
    self.main.contentView.userInteractionEnabled=YES;

    
    CGRect rect = self.view.frame;
    [UIView beginAnimations:nil context:nil];
    self.main.view.frame = rect;
    [UIView commitAnimations];
//    NSLog(@"侧滑2");

}

- (IBAction)btnUserInfoClick:(UIBarButtonItem *)sender {
    if (sender.tag == 8888) {
        [self showLeftVC];
    }else{
        [self showMainVC];
    }
    
}

- (void)handleTapGesture {
    
    [self handleLeftSwipeGesture];
    
}

#pragma mark - MainVC delegate
- (void)showLeftVC {
    [self handleSwipeGesture];
}
- (void)showMainVC {
    [self handleLeftSwipeGesture];
}


- (void)showIntroWithCrossDissolve {
    //自己写得方法
    EAIntroPage *page1 = [EAIntroPage page];//想用几个引导页就创建几个
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"yindaoyemian1"];
    //    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"yindaoyemian2"];
    //    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"yindaoyemian3"];
    //    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame: self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.main.view animateDuration:0.0];
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
