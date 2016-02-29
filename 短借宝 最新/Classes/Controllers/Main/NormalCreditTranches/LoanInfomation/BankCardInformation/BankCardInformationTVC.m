//
//  BankCardInformationTVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "BankCardInformationTVC.h"
#import "IGLDropDownMenu.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "aaViewController.h"
#import "MBProgressHUD.h"

#import "Header.h"

@interface BankCardInformationTVC ()<IGLDropDownMenuDelegate>{
    
    MBProgressHUD *HUD;
    
    float width,heig;
    
    
    UITableView *mytable;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_yinhNGK;

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;

@property (weak, nonatomic) IBOutlet UITextField *bank;

@end

@implementation BankCardInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    _YinHangKaXinXi_KaiHuRenXingMing_Field.userInteractionEnabled=NO;
    
    
    [self quzhifangjiemian];

    [self.view endEditing:YES];
    NSArray *dataArray = @[@{@"image":@"",@"title":@"中国工商银行"},
                           @{@"image":@"",@"title":@"中国农业银行"},
                           @{@"image":@"",@"title":@"中国建设银行"},
                           @{@"image":@"",@"title":@"中国银行"},
                           @{@"image":@"",@"title":@"中国交通银行"},@{@"image":@"",@"title":@"哈尔滨银行"},
                           @{@"image":@"",@"title":@"中国光大银行"},
                           @{@"image":@"",@"title":@"兴业银行"},
                           @{@"image":@"",@"title":@"中国邮政储蓄银行"},
                           @{@"image":@"",@"title":@"招商银行"},@{@"image":@"",@"title":@"广发银行"},
                           
                           
                           ];
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArray.count; i++) {
        NSDictionary *dict = dataArray[i];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
        [item setText:dict[@"title"]];
        [dropdownItems addObject:item];
    }
    
    //    demo
    self.dropDownMenu = [[IGLDropDownMenu alloc] init];
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"bank"]isEqualToString:@"null"]) {
        self.dropDownMenu.menuText = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"bank"] ];
    }else{
    self.dropDownMenu.menuText = @"请选择银行";
    }
    self.dropDownMenu.dropDownItems = dropdownItems;
    
    self.dropDownMenu.paddingLeft =15;
    //    位置
    //    self.dropDownMenu.frame=self.bank.frame;
    
    
    [self.dropDownMenu setFrame:CGRectMake(self.bank.frame.origin.x, self.cell_yinhNGK.frame.origin.y+12, width, 30)];
    
    //    代理
    self.dropDownMenu.delegate = self;
    
    [self setUpParamsForDemo4];
    
    
    [self.dropDownMenu reloadView];
    
    
    [self.view addSubview:self.dropDownMenu];
    
    
    UIButton *bn=[[UIButton alloc] initWithFrame:CGRectMake(self.bank.frame.origin.x, self.cell_yinhNGK.frame.origin.y, width, self.cell_yinhNGK.frame.size.height)];
    [bn setTitle:@"请选择银行" forState:UIControlStateNormal];
    
    bn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [bn addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:bn];
    
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(16, 250, self.view.frame.size.width-32, 40)];
    ll.font=[UIFont systemFontOfSize:14];
    ll.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255  blue:97.0/255  alpha:1.0f];
    ll.text=@"    *银行卡开户人必须是当前登录的用户，请确保开户人姓名与个人信息中填写的姓名一致";
    ll.numberOfLines=2;
    
    [self.view addSubview:ll];
    
    [self.view sendSubviewToBack:ll];
    
    
    UIButton *bbba=[[UIButton alloc] initWithFrame:CGRectMake(16, heig-80-64, width-32, 40)];
    
    [bbba setTitle:@"确定" forState:UIControlStateNormal];
    [bbba setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    bbba.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1];
    [bbba.layer setCornerRadius:5.0f];
    
    [bbba addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bbba];
    
    [self.view sendSubviewToBack:bbba];
    
    
}

-(void)choose{
    
    
    [self.view endEditing:YES];
    
    
    
    
}




-(void)quzhifangjiemian
{
    
    //        取值放界面
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([[defaults3 objectForKey:@"gerenname"]isEqual:@"null"]) {
        
        
        
    }else{
        
        self.YinHangKaXinXi_KaiHuRenXingMing_Field.text=[defaults3 objectForKey:@"gerenname"];//收款人姓名
        self.YinHangKaXinXi_YinHangKaHao_Field.text=[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"];//收款人卡号
        _YinHangKaXinXi_KaiHuRenXingMing_Field.text=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"]];
        self.bank.text=[defaults3 objectForKey:@"bank"];//银行
        self.YinHangKaXinXi_KaiHuMingCheng_Field.text = [defaults3 objectForKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"];
        
        
    }

}



- (void)setUpParamsForDemo4
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
        [self.view endEditing:YES];
    
    self.dropDownMenu.flipWhenToggleView = YES;
}
- (void)selectedItemAtIndex:(NSInteger)index
{
    IGLDropDownItem *item = self.dropDownMenu.dropDownItems[index];
    //取值
        [self.view endEditing:YES];
    self.bank.text = [NSString stringWithFormat:@"%@", item.text];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *vv=[[UIView alloc] init];
    
    return vv;
}

- (void)btn:(UIButton *)sender {
    
    
    if (
        [self.YinHangKaXinXi_KaiHuRenXingMing_Field.text isEqual:@""]||//收款人姓名
        [self.YinHangKaXinXi_YinHangKaHao_Field.text isEqual:@""]||//收款人卡号
        [self.bank.text isEqual:@""]||//银行
        [self.YinHangKaXinXi_KaiHuMingCheng_Field.text isEqual:@""]
        ) {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"信息填写错误";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
    }else
    {

    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //grxx_yhk是json格式数据，包括id：会员id，zhid:会员账号id，skrxm：收款人姓名，skyh:收款银行，skyhkh:收款银行卡号 hytxl:会员通讯录 json数组格式 包括：{lxrxm:联系人姓名 lxrdh:联系人电话}[defaults objectForKey:@"id"],[defaults objectForKey:@"zhid"]
    
        NSDictionary *ddd1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"wu",@"lxrdh",@"wu",@"lxrxm", nil];
        NSArray *arr1 = [NSArray arrayWithObjects:ddd1, nil];

    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"id"],@"id",[defaults3 objectForKey:@"zhid"],@"zhid",self.YinHangKaXinXi_KaiHuRenXingMing_Field.text,@"skrxm",self.bank.text,@"skyh",self.YinHangKaXinXi_YinHangKaHao_Field.text,@"skyhkh",arr1,@"hytxl", self.YinHangKaXinXi_KaiHuMingCheng_Field.text,@"khhmc", nil];
    
    NSLog(@"-----%@",[defaults3 objectForKey:@"shooujihaoJSON"]);
    
    NSString *strJson = [dataDictionary JSONString];
    //    NSLog(@"%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidLogAction!wscyyhk.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"－－－－url--%@",url1);
    
    [manager POST:url1 parameters:@{@"grxx_yhk":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try
        {
            NSLog(@"－－＝＝－－%@",responseObject);
            
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            
            NSDictionary *dic=[resultDic objectForKey:@"hyxx"];
            NSLog(@"0.0  开户行名称－－－－%@",dic);
            //        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
            
            [defaults3 setObject:[dic objectForKey:@"skrxm"] forKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"];//收款人姓名
            NSLog(@"%@",[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"]);
            [defaults3 setObject:[dic objectForKey:@"skyh"] forKey:@"bank"];//收款人银行
            [defaults3 setObject:[dic objectForKey:@"skyhkh"] forKey:@"YinHangKaXinXi_YinHangKaHao_Field"];//收款人卡号
            [defaults3 setObject:[NSString stringWithFormat:@"%@",_YinHangKaXinXi_KaiHuMingCheng_Field.text] forKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"];//开户名称
            
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"上传成功";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            
            //[self.delegate hid1];
            
            
            
            [self performSelector:@selector(tuitui) withObject:nil afterDelay:1];

            
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
        
        HUD.labelText = @"请重新上传";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
    }];
    
    }
    
}

-(void)tuitui{
    
    [HUD hide:YES];
    
    [self.navigationController
     popViewControllerAnimated:YES];
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
    return 4;
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
