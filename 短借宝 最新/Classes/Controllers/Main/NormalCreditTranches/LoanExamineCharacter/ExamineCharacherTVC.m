//
//  ExamineCharacherTVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/5.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "ExamineCharacherTVC.h"

#import "QuickLoanMoneyVC.h"

#import "LoanComprehendViewControllers.h"

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "Header.h"

@interface ExamineCharacherTVC ()
@property (strong, nonatomic) IBOutlet UITableView *TVB;
@property (weak, nonatomic) IBOutlet UIView *view_btn;
@property (strong, nonatomic) UIButton *btn;
@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;

@end

@implementation ExamineCharacherTVC

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
    
   

    //        取值放界面
   // [self suoyouziliaohuoqu];
    
    _view_button_y=(CGRectGetMaxY(self.TVB.frame)-60);
    
    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TVB.frame.origin.x,_view_button_y, self.TVB.frame.size.width, 60)];
//    NSLog(@"%f",_view_button_y);
    
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

#warning 所有页面的值显示

-(void)suoyouziliaohuoqu
{
    //        取值放界面
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@"null"]) {
        
        
        
    }else{
        //    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        //贷款信息页面
        self.JinEw.text=[NSString stringWithFormat:@"%@元",[defaults3 objectForKey:@"JinE"]];
        self.QiXianw.text=[NSString stringWithFormat:@"%@天",[defaults3 objectForKey:@"QiXian"] ];
        self.LiXiw.text=[NSString stringWithFormat:@"%@元",[defaults3 objectForKey:@"FeiLu"] ];
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
     LoanComprehendViewControllers* QL=[self.storyboard instantiateViewControllerWithIdentifier:@"LoanComprehend"];
    
    [self.navigationController pushViewController:QL animated:YES];


}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
  
    return 1;
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    if (section==0) {
//        
//        return 28;
//    }else
//    {
//        return 3;
//    }
//}
@end
