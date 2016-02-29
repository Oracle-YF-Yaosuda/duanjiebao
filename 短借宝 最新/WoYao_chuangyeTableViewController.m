//
//  WoYao_chuangyeTableViewController.m
//  短借宝
//
//  Created by suokun on 16/1/11.
//  Copyright © 2016年 com.appleyf. All rights reserved.
//

#import "WoYao_chuangyeTableViewController.h"
#import "Header.h"
#import "QuickLoanMoneyVC.h"
#import "LoanComprehendViewControllers.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "SBJsonWriter.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "MainVC.h"
#import "LianXIWoMenVC.h"
@interface WoYao_chuangyeTableViewController (){
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) IBOutlet UITableView *TVB;
- (IBAction)fanfan:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIView *view_btn;
@property (strong, nonatomic) UIButton *btn;
@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;

@end

@implementation WoYao_chuangyeTableViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self suoyouziliaohuoqu];
    
}
- (void)viewDidAppear:(BOOL)animated{
   
    UITableViewCell *ce=[_TVB cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    UIButton *bb1=(UIButton*)[ce viewWithTag:980];
    
    [bb1 addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view_button_y=(CGRectGetMaxY(self.TVB.frame)-60);
    
    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TVB.frame.origin.x,_view_button_y, self.TVB.frame.size.width, 60)];
    
    self.view_button.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:0.8];

    if (self.view.frame.size.height<569) {
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)/4, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+4)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 60)];
        ;
        self.view_btn.frame=v.frame;
        
    }else if(self.view.frame.size.height<668){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-50, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 100)];
        ;
        self.view_btn.frame=v.frame;
        
        
    }else if(self.view.frame.size.width==414){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-55, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+15)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 130)];
        ;
        self.view_btn.frame=v.frame;
        
    }
    
    //self.view_btn.backgroundColor=[UIColor blackColor];
    
    [self.btn setTitle:@"确认" forState:UIControlStateNormal];
    
    UIImage *imag=[UIImage imageNamed:@"enniuzhengchang2x_03"];
    
    [self.btn setBackgroundImage:imag forState:UIControlStateNormal];
    [self.view_button addSubview:self.btn];
    
    [self.TVB addSubview:self.view_button];
    
    
    [self.btn addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    _TVB.dataSource=self;
    _TVB.delegate=self;

}

-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)suoyouziliaohuoqu
{
    //        取值放界面
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@"null"]) {
        
        
        
    }else{
        //    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
       
        //个人信息
        self.PuTongName.text= [defaults3 objectForKey:@"GeRenXinXi_Name_Field"];//贷款人名
        self.XingBie.text=[defaults3 objectForKey:@"xingbie"];//贷款人性别
        self.PuTongShenFenZhengHao.text=[defaults3 objectForKey:@"GeRenXinXi_ShenFenZhenHao_Field"];//身份证号
        self.PuTongDaXueMing.text=[defaults3 objectForKey:@"GeRenXinXi_SuoZaiDaXue_Field"];//大学名
        self.PuTongZhuanYe.text=[defaults3 objectForKey:@"GeRenXinXi_SuoZaiZhuanYe_Field"]; //专业
        self.PuTongBanji.text=[defaults3 objectForKey:@"GeRenXinXi_BanJi_Field"];//班级
        self.XueHao.text=[defaults3 objectForKey:@"XUeHao"];//学号
        self.PuTongZhanghao.text=[defaults3 objectForKey:@"GeRenXinXi_XueXinWangZhangHao_Field"];//账号
        self.PuTongMiMa.text=[defaults3 objectForKey:@"GeRenXinXi_XueXinWangMiMai_Field"];//密码
        self.PuTongChuanhao.text=[defaults3 objectForKey:@"SuSheDiZhi"];//宿舍地址
        self.PuTongShengshi.text=[defaults3 objectForKey:@"GeRenXinXi_ShengShiQu_Field"];//省市区
        self.GongYuHao.text=[defaults3 objectForKey:@"GongYuHao"];//公寓号
        self.FangJianHao.text=[defaults3 objectForKey:@"FangJianHao"];//房间号
        self.PuTongShengRi.text=[defaults3 objectForKey:@"GeRenXinXi_ShengRi_Field"];//生日
        
        //联系人信息
        self.PuTongJiaZhangGuanXi.text=[defaults3 objectForKey:@"fumu"];//家长关系
        self.PuTongJiaZhangXingMing.text=[defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"];//家长姓名
        self.PuTongJiaZhangShouJiHao.text=[defaults3 objectForKey:@"LianXiRenXinXi_PhoneNum_Field"];//家长手机号
        self.PuTongDaoYuanXingMing.text=[defaults3 objectForKey:@"LianXiRenXinXi_DaoYuanName_Field"];//导员姓名
        self.PuTongDaoYuanShouJiHao.text=[defaults3 objectForKey:@"LianXiRenXinXi_DaoYuanPhoneNum_Field"];//导员手机号
        self.PuTongTongXueXingMing.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengName_Field"];;//同学1姓名
        self.PuTongTongXueShouJiHao.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengPhoneNum_Field"];//紧急联系人同学1手机号
        self.PuTongTongXue2XingMing.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengName2_Field"];//紧急联系人同学2姓名
        self.PuTongTongXue2ShouJiHao.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengPhoneNum2_Field"];//紧急联系人同学2手机号
        
        //银行卡号
        self.PuTongYinHang.text=[defaults3 objectForKey:@"bank"];//银行
        self.PuTongKaHao.text=[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"];//收款人卡号
        self.PuTongXingMing.text=[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"];//收款人姓名
        self.PuTongMingCheng.text = [defaults3 objectForKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"];
        
        //照片资料
        ////身份证
        //        NSString *filePath = [NSString stringWithFormat:@"%@/Documents/image1.jpg",NSHomeDirectory()];
        //        self.PuTongShenFenZheng.image=[UIImage imageNamed:filePath];
        //        ////学生证
        //        NSString *filePath2 = [NSString stringWithFormat:@"%@/Documents/image2.jpg",NSHomeDirectory()];
        //        self.PuTongXueShengZheng.image=[UIImage imageNamed:filePath2];
        //        ////本人自拍照
        //        NSString *filePath3 = [NSString stringWithFormat:@"%@/Documents/image3.jpg",NSHomeDirectory()];
        //        self.PuTongZiPaiiZhao.image=[UIImage imageNamed:filePath3];
        //        //身份证反面
        //        NSString *filePath4 = [NSString stringWithFormat:@"%@/Documents/image4.jpg",NSHomeDirectory()];
        //        self.ShenFenZhenFanMian.image=[UIImage imageNamed:filePath4];
        NSString *zjz1=[defaults3 objectForKey:@"zjz1"];
        NSString *zjz2=[defaults3 objectForKey:@"zjz2"];
        NSString *zjz3=[defaults3 objectForKey:@"zjz3"];
        NSString *zjz4=[defaults3 objectForKey:@"zjz4"];
        
        [self.PuTongShenFenZheng sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz1]]  placeholderImage:[UIImage imageNamed: @"ziliao_03"]];
        [self.ShenFenZhenFanMian sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz4]] placeholderImage:[UIImage imageNamed:@"ziliao_03"]];
        [self.PuTongXueShengZheng sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz2]] placeholderImage:[UIImage imageNamed:@"ziliao_09"]];
        
        [self.PuTongZiPaiiZhao sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz3]] placeholderImage:[UIImage imageNamed:@"ziliao_05"]];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.view_button.frame = CGRectMake(self.view_button.frame.origin.x, _view_button_y+self.tableView.contentOffset.y , self.view_button.frame.size.width, self.view_button.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)button:(UIButton *)kkk
{
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidCyAction!save_wycy.action",networkAddress];

    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"zhid"] ],@"zhid",nil];
    NSString *strJson = [dataDictionary JSONString];
    NSLog(@"-------------------\n\n\n---%@",[defaults3 objectForKey:@"zhid"]);
//    AFJSONResponseSerializer * responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
//    responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
   
    
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.weather.com.cn/data/101180601.html"]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    if(error==nil){
//    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
//    }else {
//        NSLog(@"shibai");
//    }
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        @try
        {
            if ([[responseObject valueForKey:@"flag"] intValue] == 1) {
                
                LianXIWoMenVC*lianxi=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LianXIWoMen"];
                [self.navigationController pushViewController:lianxi animated:YES];
                
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"提交成功";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                NSLog(@"提交成功");
                
            }else{
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"massages"]];
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                NSLog(@"zheshisha---------%@ ",[responseObject objectForKey:@"massages"]);
            }

        }@catch (NSException * e) {
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText=@"请检查你的网络连接!";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:1];
        }
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText=@"提交失败 ";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];

        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
      return 22;
     }
    else
    {
        return 0;
    }
}


- (IBAction)PuTongGeRenXinXi_BianJi_Buttton:(id)sender {
}

- (IBAction)PuTongYInHangKaXinXi_BianJi_Button:(id)sender {
}

- (IBAction)PuTongZhaoPian_BianJi_Button:(id)sender {
}

- (IBAction)PuTongLianXiRen_BianJi_Button:(id)sender {
}
- (IBAction)fanfan:(UIBarButtonItem *)sender {
//    
//    MainVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    
    
    [self.navigationController
    popToRootViewControllerAnimated:YES];
}
@end
