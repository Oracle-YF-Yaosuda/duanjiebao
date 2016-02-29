//
//  MakeOutInformationTVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/20.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "MakeOutInformationTVC.h"
#import "PersonalnformationTVC.h"
#import "BankCardInformationTVC.h"
#import "DataUploadVC-XIB.h"
#import "TheContactInformationTVC.h"
#import "JSONKit.h"
#import "Header.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "MBProgressHUD.h"

@interface MakeOutInformationTVC ()<hideDelegate,hideDelegate1,hideDelegate2,hideDelegate3>{
    MBProgressHUD*HUD;
}

@end

@implementation MakeOutInformationTVC


//-(void)hid{
//    
//    [self suoyouziliaohuoqu];
//
//
//}
-(void)viewWillAppear:(BOOL)animated{
    [self suoyouziliaohuoqu];
    MBProgressHUD* hud=[[MBProgressHUD alloc] init];
    [hud hide:YES afterDelay:1];
//    [self quanbujiazaoemian];

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
            
            NSLog(@"Success----: %@", [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"massages"] ]);
            
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
        
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self suoyouziliaohuoqu];
    [self.tableView reloadData];
  
   	
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)suoyouziliaohuoqu
{
    //        取值放界面
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
//    
//    if ([[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@"null"]) {
//        
//        
//        
//    }else{
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
//    if ([[defaults3 objectForKey:@"zjz1"]isEqual:@"null"]) {
//        
//    }else{
//                NSString *filePath = [NSString stringWithFormat:@"%@/Documents/image1",NSHomeDirectory()];
//                self.PuTongShenFenZheng.image=[UIImage imageNamed:filePath];
//                ////学生证
//                NSString *filePath2 = [NSString stringWithFormat:@"%@/Documents/image2",NSHomeDirectory()];
//                self.PuTongXueShengZheng.image=[UIImage imageNamed:filePath2];
//                ////本人自拍照
//                NSString *filePath3 = [NSString stringWithFormat:@"%@/Documents/image3",NSHomeDirectory()];
//                self.PuTongZiPaiiZhao.image=[UIImage imageNamed:filePath3];
//                //身份证反面
//                NSString *filePath4 = [NSString stringWithFormat:@"%@/Documents/image4",NSHomeDirectory()];
//                self.ShenFenZhenFanMian.image=[UIImage imageNamed:filePath4];
    
        NSString *zjz1=[defaults3 objectForKey:@"zjz1"];
        NSString *zjz2=[defaults3 objectForKey:@"zjz2"];
        NSString *zjz3=[defaults3 objectForKey:@"zjz3"];
        NSString *zjz4=[defaults3 objectForKey:@"zjz4"];
        
//        __block NSData *zdata1;
//        __block  NSData *zdata2;
//        __block  NSData *zdata3;
//        __block  NSData *zdata4;
//        
//        //
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_group_t group = dispatch_group_create();
//        dispatch_group_async(group, queue, ^{
//            
//            NSURL *zz1=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz1]];
//            
//            zdata1=[NSData dataWithContentsOfURL:zz1];
//            
//            
//        });
//        dispatch_group_async(group, queue, ^{
//            
//            NSURL *zz2=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz2]];
//            
//            zdata2=[NSData dataWithContentsOfURL:zz2];
//        });
//        dispatch_group_async(group, queue, ^{
//            NSURL *zz3=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz3]];
//            
//            zdata3=[NSData dataWithContentsOfURL:zz3];
//        });
//        dispatch_group_async(group, queue, ^{
//            NSURL *zz4=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz4]];
//            
//            zdata4=[NSData dataWithContentsOfURL:zz4];
//        });
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{//三个图片全部加载完毕后更
//            
//            
//            NSFileManager *fm=[NSFileManager defaultManager];
//            
//            NSString *path1=[NSString stringWithFormat:@"%@/Documents/image1",NSHomeDirectory()];
//            
//            [fm createFileAtPath:path1 contents:zdata1 attributes:nil];
//            
//            NSString *path2=[NSString stringWithFormat:@"%@/Documents/image2",NSHomeDirectory()];
//            
//            [fm createFileAtPath:path2 contents:zdata2 attributes:nil];
//            
//            NSString *path3=[NSString stringWithFormat:@"%@/Documents/image3",NSHomeDirectory()];
//            
//            [fm createFileAtPath:path3 contents:zdata3 attributes:nil];
//            
//            NSString *path4=[NSString stringWithFormat:@"%@/Documents/image4",NSHomeDirectory()];
//            
//            [fm createFileAtPath:path4 contents:zdata4 attributes:nil];
//            
//            
//            NSLog(@"--sd-%@",NSHomeDirectory());
//            
//            
//        });
   
    
        [self.PuTongShenFenZheng sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz1]]  placeholderImage:[UIImage imageNamed: @"ziliao_03"]];
        [self.ShenFenZhenFanMian sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz4]] placeholderImage:[UIImage imageNamed:@"ziliao_03"]];
        [self.PuTongXueShengZheng sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz2]] placeholderImage:[UIImage imageNamed:@"ziliao_09"]];
        
         [self.PuTongZiPaiiZhao sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",networkAddress,zjz3]] placeholderImage:[UIImage imageNamed:@"ziliao_05"]];
    
    
}

- (IBAction)LianXiRen:(UIButton *)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"]isEqualToString:@""]) {
        MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"请先填写完银行卡信息再进入";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
    }else{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DaiKuanShiFouKeYi"] intValue]!=1) {
   TheContactInformationTVC* left1=[self.storyboard instantiateViewControllerWithIdentifier:@"TheContactInformation"];
    left1.delegate=self;

        [self.navigationController pushViewController:left1 animated:YES];}
    
    else{
        
    
        
      MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"您有未还清借款不能编辑！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
    }
    }
}
- (IBAction)ZiLiao:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"LianXiRenXinXi_PhoneNum_Field"]isEqualToString:@""]) {
        MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"请先填写完联系人信息再进入";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
    }else{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DaiKuanShiFouKeYi"] intValue]!=1) {
    DataUploadVC_XIB* left2=[self.storyboard instantiateViewControllerWithIdentifier:@"DataUploadVC"];
    left2.delegate=self;

    [self.navigationController pushViewController:left2 animated:YES];
    }
    else{
        
      
        
       MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"您有未还清借款不能编辑！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
        
    }
    }
}
- (IBAction)YinHangKa:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"GeRenXinXi_Name_Field"]isEqualToString:@""]) {
        MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"请先填写完个人信息再进入";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
    }else{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DaiKuanShiFouKeYi"] intValue]!=1) {
    BankCardInformationTVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"BankCardInformation"];
    left3.delegate=self;
        [self.navigationController pushViewController:left3 animated:YES];}
    else{
        
      
        MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"您有未还清借款不能编辑！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
        
    }
    }
}
//个人信息
- (IBAction)GeRenXinXi:(UIButton *)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DaiKuanShiFouKeYi"] intValue]!=1) {
    
    PersonalnformationTVC* left4=[self.storyboard instantiateViewControllerWithIdentifier:@"Personalnformation"];
    left4.delegate=self;
    [self.navigationController pushViewController:left4 animated:YES];
        
    }
    else{
        
        MBProgressHUD  *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"您有未还清借款不能编辑！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
        
        
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==0) {
        
        return 22;
    }else
    {
        return 0 ;
    }
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section==0) {
        return 0;
    }
    else{
    return 0;
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
