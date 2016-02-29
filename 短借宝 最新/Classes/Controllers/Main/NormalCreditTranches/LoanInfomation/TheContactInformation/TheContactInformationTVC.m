//
//  TheContactInformationTVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "TheContactInformationTVC.h"
#import "aaViewController.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"

#import "Header.h"

@interface TheContactInformationTVC (){
    NSInteger a;
        
        MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UITableView *TVB;
@property (weak, nonatomic) IBOutlet UIView *view_btn;
@property (strong, nonatomic) UIButton *btn;

@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;
@end
@implementation TheContactInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self quzhifangjiemian];
    _view_button_y=(CGRectGetMaxY(self.TVB.frame)-60);
    
    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TVB.frame.origin.x,_view_button_y, self.TVB.frame.size.width, 60)];
    //    NSLog(@"%f",_view_button_y);
    
    self.view_button.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:0.8];
    
    //self.view_button.backgroundColor=[UIColor blackColor];
    
    if (self.view.frame.size.height<569) {
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)/4, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+4)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 60)];
        ;
        self.view_btn.frame=v.frame;
        
    }else if(self.view.frame.size.height<668){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-70, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 100)];
        ;
        self.view_btn.frame=v.frame;
        
        
    }else if(self.view.frame.size.height<737){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-65, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+15)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 130)];
        ;
        self.view_btn.frame=v.frame;
        
    }
    
    [self.btn setTitle:@"保存" forState:UIControlStateNormal];
    
    UIImage *imag=[UIImage imageNamed:@"enniuzhengchang2x_03"];
    
    [self.btn setBackgroundImage:imag forState:UIControlStateNormal];
    [self.view_button addSubview:self.btn];
    
    [self.TVB addSubview:self.view_button];
    [self.btn addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self fuqin:nil];
}

-(void)quzhifangjiemian
{
    
    //        取值放界面
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"] isEqualToString:@"null"]) {
        
        
        
    }else{
//            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        
        if ([[defaults3 objectForKey:@"fumu"] isEqual:@"父亲"]) {
            self.LianXiRenXinXI_FuQin_Image.hidden=NO;
            self.LianXiRenXinXi_MuQin_Image.hidden=YES;
            
        }
        else{
            self.LianXiRenXinXI_FuQin_Image.hidden=YES;
            self.LianXiRenXinXi_MuQin_Image.hidden=NO;
        }
        
            self.LianXiRenXinXi_DaoYuanName_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_DaoYuanName_Field"];//紧急联系人导员姓名
            self.LianXiRenXinXi_DaoYuanPhoneNum_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_DaoYuanPhoneNum_Field"];//紧急联系人导员手机号
            self.LianXiRenXinXi_XueShengName_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengName_Field"];//紧急联系人同学1姓名
            self.LianXiRenXinXi_XueShengPhoneNum_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengPhoneNum_Field"];//紧急联系人同学1手机号
            self.LianXiRenXinXi_XueShengName2_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengName2_Field"];//紧急联系人同学2姓名
            self.LianXiRenXinXi_XueShengPhoneNum2_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_XueShengPhoneNum2_Field"];//紧急联系人同学2手机号
            self.LianXiRenXinXi_PhoneNum_Field.text=[defaults3 objectForKey:@"LianXiRenXinXi_PhoneNum_Field"];//紧急联系人（父&母）电话号
            self.LianXiRenXinXi_Name_Field.text= [defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"];

            
        }
    }

-(void)baocun
{
    
    
    if ( [self.LianXiRenXinXi_Name_Field.text isEqualToString:@""] || [self.LianXiRenXinXi_PhoneNum_Field.text isEqualToString:@""]
        
        ) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"信息填写错误";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
    }
    else
    {
        [self qingqiu];
        
    }
    
    
    
    
}

#pragma 封装请求
-(void)qingqiu{
    //    手机
//    NSString *regex = @"[1][34578]\\d{9}";
    
    //    密码
    //    NSString *pasRegex =@"^[a-zA-Z0-9]{6,13}$";
    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
//    
//    BOOL isMatch = [pred evaluateWithObject:_LianXiRenXinXi_PhoneNum_Field.text];
    
//    if (!isMatch) {
//        
//        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        
//        HUD.mode = MBProgressHUDModeText;
//        
//        HUD.labelText = @"请输入正确的手机号码";
//        
//        HUD.margin = 10.f;
//        
//        HUD.removeFromSuperViewOnHide=YES;
//        
//        [HUD hide:YES afterDelay:2];
//    }
//    else
    {

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //请求为json 请求 参数：grxx_lxr json格式，json中包括 ：id:会员信息的id lxrgx：联系人关系 lxrxm：联系人姓名 lxrdh: 联系人电话 jjlxr_tx1：紧急联系同学1 jjlxr_tx1sjh：同学1电话 jjlxr_tx2：紧急联系同学2 jjlxr_tx2sjh：紧急联系同学2电话
    //jjlxr_dy：紧急联系导员 jjlxr_dysjh：辅导员手机号
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"id"],@"id",[defaults objectForKey:@"fumu"],@"lxrgx",_LianXiRenXinXi_Name_Field.text,@"lxrxm",_LianXiRenXinXi_PhoneNum_Field.text,@"lxrdh",@"",@"jjlxr_tx1",@"",@"jjlxr_tx1sjh",@"",@"jjlxr_tx2",@"",@"jjlxr_tx2sjh",@"",@"jjlxr_dy",@"",@"jjlxr_dysjh",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    NSLog(@"-----------------********----------%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidLogAction!wslxrxx.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"grxx_lxr":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
             @try
        {
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"resultDic-------%@",resultDic);
            
            NSDictionary *dic=[resultDic objectForKey:@"hyxx"];
            
            
            
            NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
            
            
            [defaults3 setObject:[dic objectForKey:@"jjlxr_dy"] forKey:@"LianXiRenXinXi_DaoYuanName_Field"];//紧急联系人导员姓名
            [defaults3 setObject:[dic objectForKey:@"jjlxr_dysjh"] forKey:@"LianXiRenXinXi_DaoYuanPhoneNum_Field"];//紧急联系人导员手机号
            [defaults3 setObject:[dic objectForKey:@"jjlxr_tx1"] forKey:@"LianXiRenXinXi_XueShengName_Field"];//紧急联系人同学1姓名
            [defaults3 setObject:[dic objectForKey:@"jjlxr_tx1sjh"] forKey:@"LianXiRenXinXi_XueShengPhoneNum_Field"];//紧急联系人同学1手机号
            [defaults3 setObject:[dic objectForKey:@"jjlxr_tx2"] forKey:@"LianXiRenXinXi_XueShengName2_Field"];//紧急联系人同学2姓名
            [defaults3 setObject:[dic objectForKey:@"jjlxr_tx2sjh"] forKey:@"LianXiRenXinXi_XueShengPhoneNum2_Field"];//紧急联系人同学2手机号
            [defaults3 setObject:[dic objectForKey:@"lxrdh"] forKey:@"LianXiRenXinXi_PhoneNum_Field"];//紧急联系人（父&母）电话号
            [defaults3 setObject:[dic objectForKey:@"lxrgx"] forKey:@"fumu"];//紧急联系人选择（父&母）
            [defaults3 setObject:[dic objectForKey:@"lxrxm"] forKey:@"LianXiRenXinXi_Name_Field"];//紧急联系人（父&母）姓名
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"上传成功";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:1];
#pragma 更改
            //[self.delegate hid3];
            
            [self.navigationController
             popViewControllerAnimated:YES];
            
            
            
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
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请重新上传";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
        NSLog(@"%@",error);
        
    }];
    
    }
}

- (IBAction)shoujihao:(UIButton *)sender {
    
    //弹出系统通讯录界面
    ABPeoplePickerNavigationController * con = [[ABPeoplePickerNavigationController   alloc]init];
    con.peoplePickerDelegate=self;
    [self presentViewController:con animated:YES completion:nil];
}
//点击方法
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    
   
    //获取当前联系人的电话 数组
    NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
    ABMultiValueRef phones= ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
        [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
    }
    
    _LianXiRenXinXi_PhoneNum_Field.text=[NSString stringWithFormat:@"%@",phoneArr[0]];
  
    
}


- (void)HMUTVC:(aaViewController *)vc didSelectInfo:(NSString *)name phone:(NSString *)phone {
    
    switch (a) {
            
        case 5:
            self.LianXiRenXinXi_PhoneNum_Field.text = phone;
            
            break;
        case 6:
            self.LianXiRenXinXi_DaoYuanPhoneNum_Field.text = phone;
            
            break;
        case 7:
            self.LianXiRenXinXi_XueShengPhoneNum_Field.text = phone;
            
            break;
        case 8:
            self.LianXiRenXinXi_XueShengPhoneNum2_Field.text = phone;
            
            break;
            
            
        default:
            break;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

//父母

- (IBAction)fuqin:(id)sender {
    
    self.LianXiRenXinXI_FuQin_Image.image=[UIImage imageNamed:@"denglu_15"];
    
    self.LianXiRenXinXI_FuQin_Image.hidden=NO;
    self.LianXiRenXinXi_MuQin_Image.hidden=YES;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"父亲" forKey:@"fumu"];
    
    NSLog(@"%@",[defaults objectForKey:@"fumu"]);
}


- (IBAction)muqin:(id)sender {
    
    self.LianXiRenXinXi_MuQin_Image.image=[UIImage imageNamed:@"denglu_15"];
    self.LianXiRenXinXI_FuQin_Image.hidden=YES;
    self. LianXiRenXinXi_MuQin_Image.hidden=NO;
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"母亲" forKey:@"fumu"];
    
    NSLog(@"%@",[defaults objectForKey:@"fumu"]);
}


@end
