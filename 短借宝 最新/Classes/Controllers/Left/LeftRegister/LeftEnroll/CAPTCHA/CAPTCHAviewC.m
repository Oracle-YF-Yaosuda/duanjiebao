//
//  CAPTCHAviewC.m
//  短借宝
//
//  Created by iMac21 on 15/8/3.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "CAPTCHAviewC.h"

#import "MBProgressHUD.h"

#import "LeftRegisterVC.h"
#import "AFNetworking.h"
#import "Networking.h"
#import "SBJsonWriter.h"

#import "Header.h"

@interface CAPTCHAviewC ()
@property (weak, nonatomic) IBOutlet UIButton *button_time;

@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (nonatomic ,strong)NSTimer *timer1;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UITextField *Yanzhengma;



@end

@implementation CAPTCHAviewC
{
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *mySettingDataR = [NSUserDefaults standardUserDefaults];
    
    
    
    NSString *string =[mySettingDataR objectForKey:@"left"];

    NSLog(@"值为：%@",string);
    
//    手机验证
    self.phone.text=[NSString stringWithFormat:@"请输入手机号为%@****%@收到的验证码",[string substringToIndex:3],[string substringFromIndex:7]];
    

    

//    验证码倒数时间
    self.timer1=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calcuRemainTime)userInfo:nil repeats:YES];
//  循环
    [[NSRunLoop currentRunLoop]addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    
    
    
    //上传手机号，获取验证码
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
    NSString *url = [NSString stringWithFormat:@"%@androidLogAction!getyhzcyzm.action?sjhm=",networkAddress];
    
    NSString *urlToo=[NSString stringWithFormat:@"%@%@",url,string];
    
            [manager GET:urlToo parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
                        NSString *requestTmp = [NSString stringWithString:operation.responseString];
                
                        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
                        //系统自带JSON解析
                        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
                
                NSLog(@"%@",[resultDic objectForKey:@"massages"]);
                HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = [resultDic objectForKey:@"massages"];
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];

                

        
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
    
    
    
    

    
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)OkButton:(UIButton *)sender {

    
    if (self.Yanzhengma.text.length==4) {
        
        //    上传用户注册
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        NSDictionary*myDic=[defaults dictionaryForKey:@"myDictionary"];
        
        
        
        
        
        NSNumber *aa=[NSNumber numberWithInteger:self.Yanzhengma.text.integerValue];
        NSLog(@"PassKey%@",aa);
        
        
        NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:aa,@"dxyzm",[myDic valueForKey:@"name"],@"zcsjhm",[myDic valueForKey:@"pass"],@"password",[myDic valueForKey:@"shenfenzhenghao"],@"sfzh",nil];
      
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        NSString *jasonString = [writer stringWithObject:dataDictionary];
        NSString *url2 = [NSString stringWithFormat:@"%@androidLogAction!register.action?register=%@",networkAddress,jasonString];
        NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
//            NSLog(@"%@",responseObject);
            
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            
            
            NSLog(@"验证%@",[resultDic objectForKey:@"massages"]);
            NSLog(@"%@",[resultDic objectForKey:@"flag"]);
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:[resultDic objectForKey:@"flag"] forKey:@"zhuce"];
            
            
            if ([defaults integerForKey:@"zhuce"]==1) {
                HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"用户注册成功！";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];
                
                LeftRegisterVC *l=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
                
                [self.navigationController pushViewController:l animated:YES];
            }else
            {
                
                HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = [resultDic objectForKey:@"massages"];
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];
                
                sleep(1);
                                
            }
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        
        
        
    }
    else
    {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"输入验证码错误，请重新输入";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
    }
    
    
    
    

    
   

}

-(void)calcuRemainTime
{
    
    self.button_time.userInteractionEnabled = NO;
    
    int a=self.time.text.intValue;
    
    if (--a<0) {
        
        
        [self.timer1 invalidate];
        
        self.time.text=@"";
        
//        self.button_time.titleLabel.text=@"点击再次发送";
        [self.button_time setTitle:@"点击再次发送" forState:UIControlStateNormal];
        
        self.button_time.userInteractionEnabled = YES;
        
    }else
    {
        self.time.text=[NSString stringWithFormat:@"%d",a];
        
    }
    
}


- (IBAction)button_time:(UIButton *)sender {
    
    self.time.text=@"60";
//    self.button_time.titleLabel.text=@"  秒后重发";
    [self.button_time setTitle:@"   秒后重发" forState:UIControlStateNormal];

    
    self.timer1=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(calcuRemainTime)
                                               userInfo:nil
                                                repeats:YES];
       [[NSRunLoop currentRunLoop]addTimer:self.timer1 forMode:NSDefaultRunLoopMode];
    



}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
         [self.navigationController popToRootViewControllerAnimated:YES];
        
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
