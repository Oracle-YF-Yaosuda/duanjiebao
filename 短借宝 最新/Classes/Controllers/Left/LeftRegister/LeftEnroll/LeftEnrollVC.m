
//
//  LeftEnrollVC.m
//  短借宝
//
//  Created by iMac21 on 15/7/20.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LeftEnrollVC.h"
#import "CAPTCHAviewC.h"
#import "LeftRegisterVC.h"

#import "MBProgressHUD.h"

@interface LeftEnrollVC ()<UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITextField *passwordNmu;

@property (weak, nonatomic) IBOutlet UITextField *passwordNmu2;



@end

@implementation LeftEnrollVC{
    MBProgressHUD *HUD;
    NSTimer*timer1;
    int a;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [timer1 invalidate];

    // Do any additional setup after loading the view.
    
    [_NumTF addTarget:self action:@selector(changePhoneNumValue) forControlEvents:UIControlEventEditingChanged];
    //    密码
    [_passwordNmu addTarget:self action:@selector(changePasswordNumValue) forControlEvents:UIControlEventEditingChanged];
    _passwordNmu.delegate=self;
    
    [_passwordNmu2 addTarget:self action:@selector(changePassword2NumValue) forControlEvents:UIControlEventEditingChanged];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [timer1 invalidate];
    if ([_q isEqualToString:@"0"]) {
        _q =@"1";
        NSUserDefaults*ppp=[NSUserDefaults standardUserDefaults];
        [ppp setObject:@"0" forKey:@"jish"];
        NSLog(@" tiaoguolaide \n\n%@",[ppp objectForKey:@"jish"]);
        timer1=nil;
    }else{
        timer1=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calcuRemainTime)userInfo:nil repeats:YES];
    }
    
     
}
-(void)viewWillDisappear:(BOOL)animated{
     [timer1 invalidate]; timer1=nil;
}
-(void)calcuRemainTime{
    NSUserDefaults*ppp=[NSUserDefaults standardUserDefaults];
    a=[[ppp objectForKey:@"jish"] intValue];
    NSLog(@"%d",a);
    if (a--<2) {
     
        [ppp setObject:[NSString stringWithFormat:@"%d",a] forKey:@"jish"];
        [timer1 invalidate];
        NSLog(@"%d",a);
        
    }
    [ppp setObject:[NSString stringWithFormat:@"%d",a] forKey:@"jish"];

}
-(void)changePhoneNumValue
{
    int MaxLen = 11;
    NSString* szText = [_NumTF text];
    if ([_NumTF.text length]> MaxLen)
    {
        _NumTF.text = [szText substringToIndex:MaxLen];
    }
}

-(void)changePasswordNumValue
{
    int MaxLen = 14;
    NSString* szText = [_passwordNmu text];
    if ([_passwordNmu.text length]>14)
    {
        _passwordNmu.text = [szText substringToIndex:MaxLen];
    }
}

-(void)changePassword2NumValue
{
    int MaxLen = 14;
    NSString* szText = [_passwordNmu2 text];
    if ([_passwordNmu2.text length]> MaxLen)
    {
        _passwordNmu2.text = [szText substringToIndex:MaxLen];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)verifyIDCardNumber:(NSString *)value{
    
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ( textField==_passwordNmu) {
        
        if (![self textvalidate:_passwordNmu.text]) {
            _passwordNmu.text=@"";
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"请输入6-14位字母、数字组成的密码";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];
            
            
        }
        
    }

}
-(BOOL)textvalidate:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,14}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

- (IBAction)zhuce:(UIButton *)sender {
    
    
    
    //    正则表达式判断是不是手机号码
    
    //    手机
    NSString *regex = @"[1][34578]\\d{9}";
    
    //    密码
    //    NSString *pasRegex =@"^[a-zA-Z0-9]{6,13}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_NumTF.text];
    
    if (!isMatch) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请输入正确的手机号码";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
    }
    else
    {
        
        
        
        //    验证码
        CAPTCHAviewC *cap=[[CAPTCHAviewC alloc] init];
        
        cap.left=self.NumTF.text;
        
        
        NSUserDefaults *mySettingData = [NSUserDefaults standardUserDefaults];
        //    传验证码
        [mySettingData setObject:cap.left forKey:@"left"];
        //    判断注册
        
        NSLog(@"检查是否注册成功!");
        
        NSString *regPassword = self.passwordNmu.text;
        
        //    NSLog(@"regPassword为%@",regPassword);
        
        NSString * regPassword2 = self.passwordNmu2.text;
        //    NSLog(@"regPassword1为%@",regPassword2);
        
        
        
        if([regPassword isEqualToString:@""] || regPassword == nil){
            NSLog(@"注册失败！");
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"密码不能为空!";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];
            
            
            
        }
        else if(regPassword.length < 6){
            
            //        NSLog(@"---%@",regPassword);
            NSLog(@"注册失败！");
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"密码输入不能少于6个!";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];
            
            
            
            self.passwordNmu.text=@"";
            self.passwordNmu2.text=@"";
            
        }
        else if(![regPassword isEqualToString:regPassword2]){
            NSLog(@"注册失败！");
            
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"两次密码输入不一致!";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];
            
            self.passwordNmu.text=@"";
            self.passwordNmu2.text=@"";
            
        }
        
        
        else if([self verifyIDCardNumber:_ShenFenZhengHao.text]==NO){
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"身份证输入不正确!";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];
            [_ShenFenZhengHao becomeFirstResponder];
        }
        
        
        
        else
        
        {
            
            
            
            //        网络请求加蒙版
            HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"请求中...";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:1];
            
            CAPTCHAviewC *l=[self.storyboard instantiateViewControllerWithIdentifier:@"CAPTCHA" ];
            
            [self.navigationController pushViewController:l animated:YES];

            
            
//            储存密码和账户
            NSDictionary *myDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.NumTF.text,regPassword,self.ShenFenZhengHao.text, nil] forKeys:[NSArray arrayWithObjects:@"name",@"pass",@"shenfenzhenghao", nil]];
            
            [mySettingData setObject:myDictionary forKey:@"myDictionary"];
            //  强制让数据立刻保存
            
            [mySettingData synchronize];
            
            
            
 
            
            
        }
        
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
