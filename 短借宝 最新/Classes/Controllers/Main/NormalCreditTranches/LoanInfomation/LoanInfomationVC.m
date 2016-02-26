//
//  LoanInfomationVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/10.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LoanInfomationVC.h"
#import "PersonalnformationTVC.h"
#import "BankCardInformationTVC.h"
#import "DataUploadVC-XIB.h"
#import "TheContactInformationTVC.h"
#import "MBProgressHUD.h"
#import "ExamineCharacherTVC.h"
#import "WoYao_chuangyeTableViewController.h"
@interface LoanInfomationVC ()<hideDelegate,hideDelegate1,hideDelegate2,hideDelegate3>
{
    
    MBProgressHUD *HUD;
    
    float width,heig;
    
}
//资料完整性
@property (strong, nonatomic)  UILabel *DataIntegrity;
@property(strong,nonatomic)UIButton *anniu;


@end

@implementation LoanInfomationVC
-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    _DataIntegrity.text=@"0";
    //个人信息
    if (![[defaults3 objectForKey:@"GeRenXinXi_XueXinWangMiMai_Field"] isEqual:@""]&&![[defaults3 objectForKey:@"GeRenXinXi_XueXinWangMiMai_Field"] isEqual:@"null"]) {
        if (self.DataIntegrity.text.intValue>=100) {
            
        }else
            
            self.image.hidden=NO;
        
        self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
    }else{
        self.image.hidden=YES;
        
    }
    //联系人
    if (![[defaults3 objectForKey:@"LianXiRenXinXi_PhoneNum_Field"] isEqual:@""]&&![[defaults3 objectForKey:@"LianXiRenXinXi_PhoneNum_Field"] isEqual:@"null"]) {
        if (self.DataIntegrity.text.intValue>=100) {
            
        }else
            
            self.imagelianxiren.hidden=NO;
        self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
        
    }else{
        self.imagelianxiren.hidden=YES;
        
    }
    //银行卡
    
    if (![[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"] isEqual:@""]&&![[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"] isEqual:@"null"]) {
        self.imageyinhangka.hidden=NO;
        if (self.DataIntegrity.text.intValue>=100) {
            
        }else
            self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
    }else{
        self.imageyinhangka.hidden=YES;
        
        
    }
    //照片上传
    
    if ([[defaults3  objectForKey:@"zjz1"] isEqual:@""]||[[defaults3 objectForKey:@"zjz2"] isEqual:@"null"]||[[defaults3 objectForKey:@"zjz3"] isEqual:@""]||[[defaults3 objectForKey:@"zjz4"] isEqual:@"null"]) {
        
        self.imageziliao.hidden=YES;
    }else{
        
        self.imageziliao.hidden=NO;
        if (self.DataIntegrity.text.intValue>=100) {
            
        }else
            self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _DataIntegrity.text=@"0";
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    _DataIntegrity=[[UILabel alloc] initWithFrame:CGRectMake(0, 177, width, 21)];
    // _DataIntegrity.backgroundColor=[UIColor blackColor];
    _DataIntegrity.textAlignment=NSTextAlignmentCenter;
    _DataIntegrity.textColor=[UIColor colorWithRed:1 green:152.0/255 blue:0 alpha:1];
    
    
    
    UIImageView *back=[[UIImageView alloc] initWithFrame:CGRectMake((width-304)/2, 20, 304, 307)];
    
    back.image=[UIImage imageNamed:@"zizhi_03"];
    
    back.userInteractionEnabled=YES;
    
    [self.view addSubview:back];
    
    
    _imagelianxiren=[[UIImageView alloc] initWithFrame:CGRectMake((304-110)/2, 195, 110, 113)];
    
    _imagelianxiren.image=[UIImage imageNamed:@"zhuye01_03"];
    
    //_imagelianxiren.hidden=YES;
    
    [back addSubview:_imagelianxiren];
    
    _imageyinhangka=[[UIImageView alloc] initWithFrame:CGRectMake(-0.5, 96, 110, 113)];
    
    _imageyinhangka.image=[UIImage imageNamed:@"zhuye01_03"];
    
    //_imageyinhangka.hidden=YES;
    
    [back addSubview:_imageyinhangka];
    
    _imageziliao=[[UIImageView alloc] initWithFrame:CGRectMake(304-111, 96, 110, 113)];
    
    _imageziliao.image=[UIImage imageNamed:@"zhuye01_03"];
    
    //_imageziliao.hidden=YES;
    
    [back addSubview:_imageziliao];
    
    _image=[[UIImageView alloc] initWithFrame:CGRectMake((304-110)/2-1, 0, 110, 113)];
    
    _image.image=[UIImage imageNamed:@"zhuye01_03"];
    
    //_image.hidden=YES;
    
    [back addSubview:_image];
    
    
    UIButton *b1=[[UIButton alloc] initWithFrame:CGRectMake((304-110)/2, 2, 110, 113)];
    
    UIButton *b2=[[UIButton alloc] initWithFrame:CGRectMake(5, 95, 110, 113)];
    
    UIButton *b3=[[UIButton alloc] initWithFrame:CGRectMake(304-115, 95, 110, 113)];
    
    UIButton *b4=[[UIButton alloc] initWithFrame:CGRectMake((304-110)/2, 197, 110, 113)];
    
    [b1 addTarget:self action:@selector(geren) forControlEvents:UIControlEventTouchUpInside];
    [b2 addTarget:self action:@selector(yinhang) forControlEvents:UIControlEventTouchUpInside];
    [b3 addTarget:self action:@selector(ziliao) forControlEvents:UIControlEventTouchUpInside];
    [b4 addTarget:self action:@selector(lianxi) forControlEvents:UIControlEventTouchUpInside];
    
    
    [back addSubview:b1];
    [back addSubview:b2];
    [back addSubview:b3];
    [back addSubview:b4];
    
    [self.view addSubview:_DataIntegrity];
    
    
    // Do any additional setup after loading the view.
    
    
    
    _anniu=[[UIButton alloc] initWithFrame:CGRectMake(16, heig-60-74, width-32, 44)];
    
    NSLog(@"--%f--%f-%f",width,heig,heig-64);
    
    _anniu.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1];
    
    [_anniu setTitle:@"确认申请" forState:UIControlStateNormal];
    
    [_anniu addTarget:self action:@selector(querenshenqing:) forControlEvents:UIControlEventTouchUpInside];
    [_anniu.layer setCornerRadius:5.0f];
    
    [_anniu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_anniu];
    
    
}

-(void)geren{
    
    PersonalnformationTVC *p=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Personalnformation"];
    p.delegate=self;
    [self.navigationController pushViewController:p animated:YES];
}

-(void)ziliao{
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    if ([[defaults3 objectForKey:@"LianXiRenXinXi_PhoneNum_Field"] isEqual:@""]||[defaults3 objectForKey:@"LianXiRenXinXi_PhoneNum_Field"]==nil) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请先填写完联系人信息再进入";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
    }else{

    DataUploadVC_XIB *p=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DataUploadVC"];
    p.delegate=self;
    [self.navigationController pushViewController:p animated:YES];
}
}

-(void)lianxi{
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    if ([[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"] isEqual:@""]||[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"]==nil) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请先填写完银行卡信息再进入";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
    }else{
        
        TheContactInformationTVC *p=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TheContactInformation"];
        p.delegate=self;
        [self.navigationController pushViewController:p animated:YES];
    }
}

-(void)yinhang{
    
    [self YinHangkaTiaoZhuan];
}

- (void)querenshenqing:(UIButton *)sender {
    
    if ([_shabi isEqualToString:@"hahah"] ) {
        ExamineCharacherTVC*vv=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExamineCharacher"];
        [self.navigationController pushViewController:vv animated:YES];
    }
    
    else if (self.DataIntegrity.text.intValue==100) {
        
        WoYao_chuangyeTableViewController* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"woyaochuangye"];
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        
    }else
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"完整度不足100%请继续填写";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
    }
    
    
    
}
- (void)YinHangkaTiaoZhuan {
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqual:@""]||[defaults3 objectForKey:@"GeRenXinXi_Name_Field"]==nil) {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请先填写完个人信息再进入";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
    }else{
        
        BankCardInformationTVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"BankCardInformation"];
        left3.delegate=self;
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
    }
    
}
-(void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender{
    
    PersonalnformationTVC *p=segue.destinationViewController;
    p.delegate=self;
    
    UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BankCardInformationTVC *b=[s instantiateViewControllerWithIdentifier:@"BankCardInformation"];
    b.delegate=self;
    
    DataUploadVC_XIB *d=segue.destinationViewController;
    d.delegate=self;
    
    TheContactInformationTVC *t=segue.destinationViewController;
    t.delegate=self;
    
}
-(void)hid1
{
    if (    self.imageyinhangka.hidden==YES) {
        self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
        
    }
    
    self.imageyinhangka.hidden=NO;
    
}
-(void)hid2
{
    if (self.imageziliao.hidden==YES) {
        self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
        
    }
    
    self.imageziliao.hidden=NO;
    
}
-(void)hid3
{
    if (self.imagelianxiren.hidden==YES) {
        self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
        
    }
    self.imagelianxiren.hidden=NO;
    
}
-(void)hid{
    
    if (self.image.hidden==YES) {
        self.DataIntegrity.text=[NSString stringWithFormat:@"%d%%",25+self.DataIntegrity.text.intValue];
        
        
    }
    self.image.hidden=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
