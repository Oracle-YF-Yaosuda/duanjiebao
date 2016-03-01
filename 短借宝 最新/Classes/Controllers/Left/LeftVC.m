//
//  LeftVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/10.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

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
#import "LianXIWoMenVC.h"

@interface LeftVC ()<UIAlertViewDelegate>{
    
    MBProgressHUD *HUD;
    
}
@property (weak, nonatomic) IBOutlet UILabel *geren;
@property (weak, nonatomic) IBOutlet UILabel *xinxi;

//@property (weak, nonatomic) IBOutlet UILabel *left_denglv;
@end

@implementation LeftVC

- (void)viewDidLoad {
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  NSDictionary*myDic2=[defaults dictionaryForKey:@"myDictionary"];
    
    if (([[defaults objectForKey:@"tag"]intValue]==1)&& myDic2!=nil) {
        
       // self.ll.text= [myDic2 valueForKey:@"name"];
        _xinxi.hidden=NO;
        _geren.hidden=NO;
        _ll.hidden=YES;
        
    }else
    {
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        
        self.ll.text=@"点击登录/注册";
        
    }
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [button setTitle: @"自定义title" forState: UIControlStateNormal];
    [button sizeToFit];
    self.navigationItem.titleView = button;
    
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeloginstate) name:@"loginstate" object:nil];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)changeloginstate{
    
    NSString *user=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    _xinxi.hidden=NO;
    _geren.hidden=NO;
    _ll.hidden = YES;
    //self.ll.text=user;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)denglv:(UIButton *)sender {
    
            self.ll.tag=11;

    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    NSDictionary*myDic2=[defaults3 dictionaryForKey:@"myDictionary"];
    //([[defaults3 objectForKey:@"tag"]intValue]==1)&& myDic2!=nil &&
    if ([defaults3 integerForKey:@"true"]==1) {
        
        MakeOutInformationTVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"MakeOutInformation"];
        
        
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
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
        
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"ture"]==1){
        _xinxi.hidden=NO;
        _geren.hidden=NO;
        _ll.hidden=YES;
    }else{
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        _ll.hidden=NO;
        self.ll.text=@"点击登录/注册";
    }
    if(self.view.frame.size.width<325){
        _ll.font=[UIFont systemFontOfSize:19];
    }
   // [self.navigationController setNavigationBarHidden:YES];
}

//判断当前借款

- (IBAction)dqjk:(UIButton *)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"true"]==1) {
        
        LeftAtPresentBorrowMoneyVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftAtPresentBorrowMoney"];
        
        
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
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
    }
}
//历史借款
- (IBAction)lsjk:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"true"]==1) {
        LeftHistory* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftHistory"];
        
        
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
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
    }
    
    
}
//还款提醒
- (IBAction)hktx:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"true"]==1) {
        lefttixing* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"lefttixing"];
        
        
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
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
    }
    
}
//个人信誉
- (IBAction)grxy:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"true"]==1) {
        
        
        GeRenXinYuVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"GeRenXinYu"];
        
        
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
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
    }
    
}
//个人积分
- (IBAction)grjf:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"true"]==1) {
        LeftTheMessageCenterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftTheMessageCenter"];
        
        
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
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
    }
    
}
//联系我们
- (IBAction)lianxi:(id)sender {
    LianXIWoMenVC *pp=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LianXIWoMen"];
    
    [self.navigationController pushViewController:pp animated:YES];
}

//设置
- (IBAction)sz:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"true"]==1) {
        SheZhiTVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"SheZhi"];
        
        
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
        
        

        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        [self.navigationController
         pushViewController:left3 animated:YES];
//
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        self.ll.text=@"点击登录/注册";
        
    }
}




//注销


- (IBAction)zhuxiao:(UIButton *)sender {
   
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请确认是否退出登录！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    
    [alert show];
    


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        _xinxi.hidden=YES;
        _geren.hidden=YES;
        _ll.hidden = NO;
        self.ll.text=@"点击登录/注册";
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
    }
    
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
