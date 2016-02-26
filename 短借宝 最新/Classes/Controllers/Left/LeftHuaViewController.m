//
//  LeftHuaViewController.m
//  短借宝
//
//  Created by ll on 15/10/13.
//  Copyright © 2015年 com.appleyf. All rights reserved.
//

#import "LeftHuaViewController.h"

#import "LeftVC.h"
#import "MBProgressHUD.h"
#import "LeftRegisterVC.h"
#import "ExamineCharacherTVC.h"
#import "LeftAtPresentBorrowMoneyVC.h"
#import "LeftHistory.h"
#import "lefttixing.h"
#import "LeftTheMessageCenterVC.h"
#import "SheZhiTVC.h"
#import "MakeOutInformationTVC.h"
#import "GeRenXinYuVC.h"


@interface LeftHuaViewController ()<UIAlertViewDelegate>{
    
    MBProgressHUD *HUD;
    
    float width,heig;
    
    UILabel *lla;
}

@end

@implementation LeftHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=241;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    UITableView *mytable=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, heig-64)];
    
    UIImageView *oo=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, heig-64)];
    
    oo.image=[UIImage imageNamed:@"bg.png"];

    [mytable addSubview:oo];
    
    mytable.delegate=self;
    mytable.dataSource=self;
    
    [mytable sendSubviewToBack:oo];
    
    mytable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:mytable];
    
    UIButton *bb=[[UIButton alloc] initWithFrame:CGRectMake(16, heig-60, 241-32, 40)];
    [bb setTitle:@"注销" forState:UIControlStateNormal];
    
    [bb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [bb addTarget:self action:@selector(zhuxiao) forControlEvents:UIControlEventTouchUpInside];
    
    bb.titleLabel.font=[UIFont systemFontOfSize:15];
    
    bb.backgroundColor=[UIColor darkGrayColor];
    
    bb.alpha=0.7;
    
    [bb.layer setCornerRadius:5];

    [self.view addSubview:bb];
    
    
    //
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSDictionary*myDic2=[defaults dictionaryForKey:@"myDictionary"];
    
    if (([[defaults objectForKey:@"tag"]intValue]==1)&& myDic2!=nil) {
        
        lla.text= [myDic2 valueForKey:@"name"];
        
    }else
    {
        lla.text=@"点击登录/注册";
        
    }
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [button setTitle: @"自定义title" forState: UIControlStateNormal];
    [button sizeToFit];
    self.navigationItem.titleView = button;
    
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeloginstate) name:@"loginstate" object:nil];
    

    
    // Do any additional setup after loading the view.
}

-(void)zhuxiao{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"提示" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        lla.text=@"点击登录/注册";
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
    }
    
}



-(void)changeloginstate{
    
    NSString *user=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    lla.text=user;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    else
        
        return 6;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1;
  
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *as=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    as.backgroundColor=[UIColor lightGrayColor];
    
    return as;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString*my=@"ce";
    
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:my];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:my];
    }
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }
    
    cell.backgroundColor=[UIColor clearColor];
    
    if (indexPath.section==0) {
        
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(25, 16, 60, 60)];
        img.image=[UIImage imageNamed:@"cehua_31.png"];
        
        [cell.contentView addSubview:img];
        
        lla=[[UILabel alloc] initWithFrame:CGRectMake(95, 32, 130, 30)];
        lla.font=[UIFont systemFontOfSize:15];
        
        lla.text=@"点击登录／注册";
        
        lla.textColor=[UIColor whiteColor];
        
        [cell.contentView addSubview:lla];
        
    }
    else{
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(25, 16, 13, 15)];
        
        [cell.contentView addSubview:img];
        
       UILabel  *ll1=[[UILabel alloc] initWithFrame:CGRectMake(45, 8, 90, 30)];
        ll1.font=[UIFont systemFontOfSize:15];
        
        ll1.textColor=[UIColor whiteColor];
        
        [cell.contentView addSubview:ll1];
        
        if (indexPath.row==0) {
       
        ll1.text=@"当前借款";
        img.image=[UIImage imageNamed:@"cehua_06.png"];
        }
        else if (indexPath.row==1) {
            
            ll1.text=@"历史借款";
            img.image=[UIImage imageNamed:@"cehua_09.png"];
        }
        
        else if (indexPath.row==2) {
            
            ll1.text=@"还款提醒";
            img.image=[UIImage imageNamed:@"cehua_18.png"];
        }
        
        else if (indexPath.row==3) {
            
            ll1.text=@"个人信誉";
            img.image=[UIImage imageNamed:@"xinyu.png"];
        }
        
        else if (indexPath.row==4) {
            
            ll1.text=@"个人积分";
            img.image=[UIImage imageNamed:@"jifen.png"];
        }
        else if (indexPath.row==5) {
            
            ll1.text=@"设置";
            img.image=[UIImage imageNamed:@"cehua_12.png"];
        }
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 90;
    }
    else
        
        return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0 ) {
        
        lla.tag=11;
        
        
        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
        NSDictionary*myDic2=[defaults3 dictionaryForKey:@"myDictionary"];
        //([[defaults3 objectForKey:@"tag"]intValue]==1)&& myDic2!=nil &&
        if ([defaults3 objectForKey:@"true"]!=nil && [defaults3 integerForKey:@"true"]==1) {
            
            MakeOutInformationTVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MakeOutInformation"];
            
            
            [self.navigationController
             pushViewController:left3 animated:YES];
            
            
            
            //        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            //
            //        NSDictionary*myDic=[defaults dictionaryForKey:@"myDictionary"];
            
            //        self.ll.text=[myDic valueForKey:@"name"];
            //
        }
        
        else{
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"请先登录";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:1];
            
            
            LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
            
            
            [self.navigationController
             pushViewController:left3 animated:YES];
            
            
            lla.text=@"点击登录/注册";
            
            
        }

    }
    
    else{
        
        if (indexPath.row==0) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"true"]==1) {
                
                LeftAtPresentBorrowMoneyVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LeftAtPresentBorrowMoney"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
            }
            else
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"请先登录";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                
                LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
                
                lla.text=@"点击登录/注册";
                
            }

        }
        
        else if (indexPath.row==1){
            
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"true"]==1) {
                LeftHistory* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftHistory"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
            }
            else
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"请先登录";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                
                LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
                
                lla.text=@"点击登录/注册";
                
            }
            

        }
        
        else if (indexPath.row==2){
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"true"]==1) {
                lefttixing* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"lefttixing"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
            }
            else
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"请先登录";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
                
                lla.text=@"点击登录/注册";
                
            }

            
        }
        
        else if (indexPath.row==3){
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"true"]==1) {
                
                
                GeRenXinYuVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GeRenXinYu"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
            }
            else
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"请先登录";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                
                LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
                
                lla.text=@"点击登录/注册";
                
            }

            
            
        }
        
        else if (indexPath.row==4){
            
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"true"]==1) {
                LeftTheMessageCenterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftTheMessageCenter"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
            }
            else
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"请先登录";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                
                LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
                
                lla.text=@"点击登录/注册";
                
            }

        }
        
        else if (indexPath.row==5){
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([defaults integerForKey:@"true"]==1) {
                SheZhiTVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SheZhi"];
                
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                
            }
            else
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"请先登录";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                
                
                LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                [self.navigationController
                 pushViewController:left3 animated:YES];
                //
                
                lla.text=@"点击登录/注册";
                
            }

        }
        
       //
        
        
        
        
    }
    
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
