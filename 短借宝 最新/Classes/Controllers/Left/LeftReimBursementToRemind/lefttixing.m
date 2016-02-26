//
//  lefttixing.m
//  短借宝
//
//  Created by appleyf on 15/8/30.
//  Copyright © 2015年 com.appleyf. All rights reserved.
//

#import "lefttixing.h"
#import "IGLDropDownMenu.h"

#import "AFNetworking.h"
#import "JSONKit.h"

#import "Header.h"

#import "MBProgressHUD.h"


@interface lefttixing ()<IGLDropDownMenuDelegate,UIAlertViewDelegate>{
    
    float width,heig;
    
    NSString *hksj;
    
    MBProgressHUD *hud;
    
    int flag;
}

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;

@property (strong, nonatomic)  UISwitch *sw;

@end

@implementation lefttixing{
    
    long b;
    UILocalNotification *localNotification;
    
    NSDictionary *mydic;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    flag=0;
    
    UIView *top=[[UIView alloc] initWithFrame:CGRectMake(0, 20, width, 50)];
    
    top.backgroundColor=[UIColor whiteColor];
    
    _tixin=[[UIView alloc] initWithFrame:CGRectMake(0, 71, width, 50)];
    
    _kaiqi=[[UILabel alloc] initWithFrame:CGRectMake(16, 10, 90, 30)];
    
    _sw=[[UISwitch alloc] initWithFrame:CGRectMake(width-60, 10, 40, 30)];
    
    [_sw addTarget:self action:@selector(swith:) forControlEvents:UIControlEventValueChanged];
    
    [top addSubview:_kaiqi];
    [top addSubview:_sw];
    
    [self.view addSubview:top];
    [self.view addSubview:_tixin];
    
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    self.sw.on=myDelegate.bo;
    
     _kaiqi.text=@"关闭提醒";
    
    if (myDelegate.bo) {
        
         _kaiqi.text=@"开启提醒";
        
        _tixin.hidden=NO;
        [self tixing];

    }
    else{
        
        _tixin.hidden=YES;
    }
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode=MBProgressHUDModeIndeterminate;
    
    hud.labelText=@"正在加载...";
    
    [hud setRemoveFromSuperViewOnHide:YES];
    
    
    
    [self DangQianDaiKuan];
    
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
        
        [hud hide:YES];
        
        NSLog(@"Success----: %@", responseObject);
        //        NSLog(@"Success: %@", [responseObject[0] objectForKey:@"flag"]);
        
        // if ([[responseObject[0] objectForKey:@"flag"] intValue]==0)
        // {
        [defaults3 setObject:[responseObject[0] objectForKey:@"flag"] forKey:@"DaiKuanShiFouKeYi"];
        [defaults3 setObject:[responseObject[0] objectForKey:@"massages"] forKey:@"DaiKuanShuChuXinXi"];
        
        if ([[defaults3 objectForKey:@"DaiKuanShiFouKeYi"] intValue]==1) {
            
            hksj=[NSString stringWithFormat:@"%@",[mydic objectForKey:@"yhksj"]];
            flag=1;
        }
        
        // }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [hud hide:YES];
        
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"未网络连接，请检查网络连接！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];

        
    }];
    
    
}


- (void)swith:(id)sender {
    
    BOOL isButtonOn = [self.sw isOn];
    if (isButtonOn) {
         _kaiqi.text=@"开启提醒";
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        myDelegate.bo=YES;
        
      [self tixing];
         _tixin.hidden=NO;
        
    }else {
        
        NSLog(@"提醒");
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"提示" message:@"如果超过还款期没有还款，可能会对信用度产生不良影响，是否继续？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        aler.tag=2001;
        [aler show];
        
        NSLog(@"否");
       
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    if (alertView.tag==2001) {
  
    if (buttonIndex==0) {
        
        _tixin.hidden=YES;
        
        _kaiqi.text=@"关闭提醒";
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        
        myDelegate.bo=NO;
        
        
        [self.dropDownMenu removeFromSuperview];
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
        
        
    }else{
        
        // _tixin.hidden=NO;
        self.sw.on=YES;
        
        
     }
    }
}

-(void)DangQianDaiKuan
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",@"1",@"pagenumber",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    //    NSLog(@"%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!selectdqjk.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",operation.responseObject);
        
        [hud hide:YES];
        
        if ([responseObject count]>0) {
            
            mydic=responseObject[0];
            
            hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.mode=MBProgressHUDModeIndeterminate;
            
            hud.labelText=@"正在加载...";
            
            [hud setRemoveFromSuperViewOnHide:YES];

            
            [self ShiFouFeYiDaiKuan];
        }
        
               
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hud hide:YES];
        
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"未网络连接，请检查网络连接！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
        
    }];
    
    
}




-(void)tixing{
    
    NSArray *dataArray = @[@{@"image":@"",@"title":@"还款前1天提醒"},
                           @{@"image":@"",@"title":@"还款前2天提醒"},
                           @{@"image":@"",@"title":@"还款前3天提醒"},
                           @{@"image":@"",@"title":@"还款前4天提醒"},
                           @{@"image":@"",@"title":@"还款前5天提醒"},@{@"image":@"",@"title":@"还款前6天提醒"},@{@"image":@"",@"title":@"还款前7天提醒"}];
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArray.count; i++) {
        NSDictionary *dict = dataArray[i];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
        [item setText:dict[@"title"]];
        [dropdownItems addObject:item];
    }
    
    //    demo
    
    int inm;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"index"]==nil) {
        inm=1;
    }
    else
    
    inm=[[[NSUserDefaults standardUserDefaults] objectForKey:@"index"] intValue];
    
    
    if (self.dropDownMenu!=nil) {
        [self.dropDownMenu removeFromSuperview];
        self.dropDownMenu=nil;
    }
    
    self.dropDownMenu = [[IGLDropDownMenu alloc] init];
    self.dropDownMenu.menuText = [NSString stringWithFormat:@"还款前%d天提醒",inm];
    self.dropDownMenu.dropDownItems = dropdownItems;
    self.dropDownMenu.paddingLeft =15;
    //    位置
    //    self.dropDownMenu.frame=self.bank.frame;
    
    
    [self.dropDownMenu setFrame:CGRectMake(0, 71, width,50)];
    
    //    代理
    self.dropDownMenu.delegate = self;
    
    [self setUpParamsForDemo4];
    
   
    
    [self selectedItemAtIndex:inm-1];
    
    [self.dropDownMenu reloadView];
    
    [self.view addSubview:self.dropDownMenu];
    
}


- (void)setUpParamsForDemo4
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
    
    
    self.dropDownMenu.flipWhenToggleView = YES;
}
- (void)selectedItemAtIndex:(int)index
{
    
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Tianshu"]!=nil)
//    {
    
       // int  mm=[[[NSUserDefaults standardUserDefaults] objectForKey:@"Tianshu"] intValue];
        
        
    IGLDropDownItem *item = self.dropDownMenu.dropDownItems[index];
    //取值
    
    //    self.bank.text = [NSString stringWithFormat:@"%@", item.text];
 
    NSString  *string = [item.text substringToIndex:4];//截取下标4之后的字符串
   
     NSString *str= [string substringFromIndex:3];//截取下标2之前的字符串
    NSLog(@"截取的值为：%@---%d",str,index);
        
        //NSString *JKSJ=[[NSUserDefaults standardUserDefaults] objectForKey:@"JKSJ"];
      //  NSString *DKSJ=[[NSUserDefaults standardUserDefaults]objectForKey:@"DKSJ"];
        
        NSTimeInterval now=[[NSDate date] timeIntervalSince1970];
    
    NSLog(@"dksj---%@",hksj);
    
    if (hksj!=nil && [hksj longLongValue]>0) {
  
    switch ([str integerValue]) {
        case 1:
//            这里写据还款时间还有多长时间
//            公式   ：还款时间戳－现在时间戳－1天＝触发时间
        {
            
            
            b= [hksj longLongValue]/1000-now- 24*3600;
        }
            
            break;
            
        case 2:
        {
            
            b= [hksj longLongValue]/1000-now-2*24*3600;
        }
            break;
        
        case 3:
        {
            
            b= [hksj longLongValue]/1000-now- 3*24*3600;
        }
            break;
        case 4:
        {
            
            
            b= [hksj longLongValue]/1000-now- 4*24*3600;
        }
            break;
        case 5:
        {
            
            
            b= [hksj longLongValue]/1000-now- 5*24*3600;
        }
            break;
        case 6:
        {
            
           b= [hksj longLongValue]/1000-now- 6*24*3600;
        }
            break;
        
        case 7:
        {
            
          b= [hksj longLongValue]/1000-now- 7*24*3600;
        }
            break;
            
        default:
            break;
    }
        
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"index"];
    
    
    //        通知
    
        
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
       
   localNotification=nil;
    
    NSLog(@"b===%ld",b);
    
   localNotification = [[UILocalNotification alloc] init];
    
    //设置本地通知的触发时间（如果要立即触发，无需设置），这里设置为20妙后
#warning 触发时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:b];
    //设置本地通知的时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //设置通知的内容
    localNotification.alertBody = @"您该还款了";
    //设置通知动作按钮的标题
    localNotification.alertAction = @"查看";
    //设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //        //设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
    //        //在规定的日期触发通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    }
    
    else if(hksj==nil){
        
        if (flag>0) {
        
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode=MBProgressHUDModeText;
        
        hud.labelText=@"当前还没有借款！";
        
        [hud setRemoveFromSuperViewOnHide:YES];
        
        [hud hide:YES afterDelay:2];
        

        }
        
        
    }
        
  //  }
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
