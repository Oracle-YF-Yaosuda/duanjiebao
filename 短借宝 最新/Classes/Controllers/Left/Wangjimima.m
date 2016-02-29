//
//  Wangjimima.m
//  短借宝
//
//  Created by appleyf on 15/9/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "Wangjimima.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "Networking.h"
#import "MBProgressHUD.h"
#import "Header.h"

@interface Wangjimima (){
    
    UITableView *zhutable;
    
    float  width,heig;
    
    UITextField *phone;
    UITextField *yanzhengma;
    UITextField *newmima;
    UITextField *quemima;
    MBProgressHUD *HUD;
    
    UIButton *getcode;
    
    NSTimer *tt1;
    
    int count;
    
}

@end

@implementation Wangjimima

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count=60;
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    zhutable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    zhutable.dataSource=self;
    zhutable.delegate=self;
    
    [self.view addSubview:zhutable];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ce=@"idd";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ce ];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ce];
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }
    
    if (indexPath.section==0) {
 
    
    if (indexPath.row==0) {
        
        phone=[[UITextField alloc] initWithFrame:CGRectMake(16, 12, width-24, 20)];
        phone.delegate=self;
        
        phone.font=[UIFont systemFontOfSize:13.0f];
        
        phone.returnKeyType=UIReturnKeyNext;
        
        phone.placeholder=@"请输入注册的手机号码";
        phone.keyboardType=UIKeyboardTypeNumberPad;
        
        phone.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [cell.contentView addSubview:phone];
    }
    else if (indexPath.row==1) {
        
        yanzhengma=[[UITextField alloc] initWithFrame:CGRectMake(16, 12, width-24, 20)];
        yanzhengma.delegate=self;
        yanzhengma.font=[UIFont systemFontOfSize:13.0f];
        yanzhengma.returnKeyType=UIReturnKeyNext;
        yanzhengma.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        yanzhengma.placeholder=@"请输入验证码";
        
        [cell.contentView addSubview:yanzhengma];
        
        getcode=[[UIButton alloc] initWithFrame:CGRectMake(width-110, 7, 90, 30)];
        
        [getcode setTitle:@"发送验证码" forState:UIControlStateNormal];
        getcode.titleLabel.font=[UIFont systemFontOfSize:13.0f];
        
        [getcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [getcode.layer setCornerRadius:5.0f];
        
        getcode.backgroundColor=[UIColor colorWithRed:1.0 green:207.0/255 blue:75.0/255 alpha:1.0];
        
        [getcode addTarget:self action:@selector(getyancode) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:getcode];
        
        
        
    }
        
    }
    
    else if (indexPath.section==1){
     
    if (indexPath.row==0) {
        
        newmima=[[UITextField alloc] initWithFrame:CGRectMake(16, 12, width-24, 20)];
        newmima.delegate=self;
        newmima.font=[UIFont systemFontOfSize:13.0f];
        newmima.returnKeyType=UIReturnKeyNext;
        newmima.clearButtonMode=UITextFieldViewModeWhileEditing;
        newmima.secureTextEntry=YES;
        newmima.placeholder=@"新密码（6-14位字母、数字）";
        
        [cell.contentView addSubview:newmima];
    }
    else if (indexPath.row==1) {
        
        quemima=[[UITextField alloc] initWithFrame:CGRectMake(16, 12, width-24, 20)];
        quemima.delegate=self;
        quemima.clearButtonMode=UITextFieldViewModeWhileEditing;
        quemima.font=[UIFont systemFontOfSize:13.0f];
        quemima.returnKeyType=UIReturnKeyDone;
        quemima.placeholder=@"再次输入新密码";
        quemima.secureTextEntry=YES;
        [cell.contentView addSubview:quemima];
    

    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(0, 43, width, 1)];
    heng.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    [cell.contentView addSubview:heng];
        
    }
    }
    
    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(0, 43, width, 1)];
    heng.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    [cell.contentView addSubview:heng];
    
    return cell;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ( textField==newmima) {
        
        if (![self textvalidate:newmima.text]) {
            newmima.text=@"";
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = @"请输入6-14位字母、数字组成的密码";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];

            
        }
        
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField==phone)
        
    {
        
        long int length = textField.text.length;
        if (length > 10 && string.length >0)
            return NO;
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered =
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        return basic;
    }
    else
        return YES;
}



-(void)getyancode{
    
    if (phone.text.length>0) {
        // get code request
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:phone.text,@"sjhm",nil];
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSString *jasonString = [writer stringWithObject:dataDictionary];
        
        NSLog(@"%@",jasonString);
        
        //
        //    包括dxyzm:短信验证码 zcsjhm：用户注册手机号码 password：注册密码
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        HUD.mode =MBProgressHUDModeIndeterminate;
        
        HUD.labelText =@"正在加载...";
        
        HUD.margin = 10.f;
        
        
        NSString *url2 = [NSString stringWithFormat:@"%@androidLogAction!getczmmyzm.action?sjhm=%@",networkAddress,phone.text];
        
        NSLog(@"url---%@",url2);
        
        NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            @try
            {
                
                NSLog(@"aaaaaa%@",responseObject);
                
                if (HUD) {
                    HUD.removeFromSuperViewOnHide=YES;
                    [HUD hide:YES afterDelay:0];
                }
                
                NSString *requestTmp = [NSString stringWithString:operation.responseString];
                
                NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
                //系统自带JSON解析
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
                
                
                
                NSLog(@"yan--%@",resultDic);
                
                //        NSLog(@"%@",[resultDic objectForKey:@"flag"]);
                
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = [resultDic objectForKey:@"massages"];
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];
                
                
                if ([[resultDic objectForKey:@"flag"] intValue]==1) {
                    
                    tt1=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(run:) userInfo:nil repeats:YES];
                    
                    [[NSRunLoop currentRunLoop] addTimer:tt1 forMode:NSRunLoopCommonModes];
                    
                    getcode.userInteractionEnabled=NO;
                    
                }
                

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
            if (HUD) {
                HUD.removeFromSuperViewOnHide=YES;
                [HUD hide:YES afterDelay:0];
            }
            
        }];
        

        
        
        
    }
    else{
        
        //tishi
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请输入手机号";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
//        UIAlertView *tta=[[UIAlertView alloc] initWithTitle:nil message:@"请输入手机号！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [tta show];
//        
    }
    
    
}

-(void)run:(NSTimer*)mma{
    
    
    [getcode setTitle:[NSString stringWithFormat:@"%d秒重新获取",count] forState:UIControlStateNormal];
    [getcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getcode.backgroundColor=[UIColor grayColor];
    
    count--;
    
    if (count==0) {
        count=60;
        getcode.userInteractionEnabled=YES;
        [getcode setTitle:@"发送验证码" forState:UIControlStateNormal];
        getcode.titleLabel.font=[UIFont systemFontOfSize:13.0f];
        
        [getcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [getcode.layer setCornerRadius:5.0f];
        
        getcode.backgroundColor=[UIColor colorWithRed:1.0 green:207.0/255 blue:75.0/255 alpha:1.0];
        
        [tt1 invalidate];
        tt1=nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *ce=[tableView cellForRowAtIndexPath:indexPath];
    
    ce.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField==phone) {
        
        [yanzhengma becomeFirstResponder];
    }
    else if (textField==yanzhengma){
        
        [newmima becomeFirstResponder];
    }
    else if (textField==newmima){
        
        [quemima becomeFirstResponder];
    }
    else{
        
        [textField resignFirstResponder];
    }
    
    return YES;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *asd=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
    
    asd.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0f];
    
    return asd;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *vv=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    vv.backgroundColor=[UIColor  colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0f];
    
    UIButton *queren=[[UIButton alloc] initWithFrame:CGRectMake(20, 60, width-40, 40)];
    
    [queren setTitle:@"确认" forState:UIControlStateNormal];
    [queren setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    queren.backgroundColor=[UIColor colorWithRed:0 green:162.0/255 blue:154.0/255 alpha:1.0f];
    queren.layer.cornerRadius=5.0f;
    
    [queren addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    
    [vv addSubview:queren];
    
    return vv;
}

-(void)tijiao{
    
    if (phone.text.length>0 && yanzhengma.text.length>0 && newmima.text.length>0 && [quemima.text isEqualToString:newmima.text]) {
       
        // 发请求2
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:phone.text,@"sjhm",yanzhengma.text, @"dxyzm",newmima.text,@"password",nil];
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSString *jasonString = [writer stringWithObject:dataDictionary];
        
        NSLog(@"%@",jasonString);
        
        //
        //    包括dxyzm:短信验证码 zcsjhm：用户注册手机号码 password：注册密码
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        HUD.mode =MBProgressHUDModeIndeterminate;
        HUD.labelText =@"正在加载...";
        HUD.margin = 10.f;
        NSString *url2 = [NSString stringWithFormat:@"%@androidLogAction!resetpassword.action?resetpassword=%@",networkAddress,jasonString];
        
        NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"url--%@",url2);
        
        [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            @try
            {
                
                NSLog(@"aaaaaa--%@",responseObject);
                
                if (HUD) {
                    HUD.removeFromSuperViewOnHide=YES;
                    [HUD hide:YES afterDelay:0];
                }
                if ([[responseObject objectForKey:@"flag"] intValue]==1) {
                    //跳转到登录页
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = [responseObject objectForKey:@"massages"];
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];
                
                

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
            if (HUD) {
                HUD.removeFromSuperViewOnHide=YES;
                [HUD hide:YES afterDelay:0];
            }
            
        }];
        
    }
    else if (phone.text.length==0){
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"手机号不能为空";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];

        
        
    }
    else if (yanzhengma.text.length==0){
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"验证码不能为空";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];

        
        
    }
    else if (newmima.text.length==0){
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请输入新密码";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];

        
        
    }
    else if (![newmima.text isEqualToString:quemima.text]){
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"两次输入密码不一致";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];

    }
    
}

-(BOOL)textvalidate:(NSString *)name
{
        NSString *userNameRegex = @"^[A-Za-z0-9]{6,14}+$";
        NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
        BOOL B = [userNamePredicate evaluateWithObject:name];
        return B;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    if (section==0) {
        return 0;
    }
    return 300;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(void)chongzhi{
    
    
//    NSString *name = self.phone.text;
//    //获得密码输入框中的文字
//    NSString *password = self.password.text;
    
    //    上传用户注册
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:yanzhengma,@"dxyzm",shoujihao,@"sjhm",password,@"password",nil];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jasonString = [writer stringWithObject:dataDictionary];
    
    NSLog(@"%@",jasonString);
    
    //
    //    包括dxyzm:短信验证码 zcsjhm：用户注册手机号码 password：注册密码
    
    
    NSString *url2 = [NSString stringWithFormat:@"%@%@",@"http://192.168.1.53:8080/androidLogAction!resetpassword.action?resetpassword=",jasonString];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"aaaaaa%@",responseObject);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",resultDic);
        
        //        NSLog(@"%@",[resultDic objectForKey:@"flag"]);
        
        
        NSDictionary *dic=[resultDic objectForKey:@"hyxx"];
        
        NSDictionary *dic1=[resultDic objectForKey:@"hyzh"];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
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
