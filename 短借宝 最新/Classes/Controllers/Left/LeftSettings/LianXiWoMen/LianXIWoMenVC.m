//
//  LianXIWoMenVC.m
//  短借宝
//
//  Created by iMac21 on 15/9/1.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LianXIWoMenVC.h"
#import "CommonMethod.h"

#import "WXApi.h"

#import <TencentOpenAPI/QQApiInterface.h>


@interface LianXIWoMenVC (){
    
    UITableView *weixindown;
    
    UITableView *qqdown;
    
    UITableView *rexiandown;
    
    float kuan,gao1,gao2,gao3,fromx;
    
    NSArray *dataArray2,*dataArray1,*dataArray;
    
    UILabel *FenXingMingZi;
    UILabel *QQ;
    UILabel *ShouJiHao;
    
    int index;
}

@end

@implementation LianXIWoMenVC


- (void)viewDidLoad {
    
    index=1;
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    UILabel *label=[[UILabel alloc]init];
    
    
    NSString *k=@"如有问题，可通过以下方式联系到我们，我们将尽快做出反馈。";
    CGFloat a=[CommonMethod heightForLabel:label WithText:k fontName:@"Heiti SC" fontSize:16 width:self.view.frame.size.width];
    
    label.frame=CGRectMake(self.view.frame.origin.x+15, self.view.frame.origin.y+15, self.view.frame.size.width-17, (int)a);
    label.text=k;
    label.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    [self.view addSubview:label];
    
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)/6, CGRectGetMaxY(label.frame)+self.view.frame.size.height/8,CGRectGetMaxX(self.view.frame)*2.0/3, 50)];
    v.backgroundColor=[UIColor whiteColor];
    [[v layer] setCornerRadius:10.0];//圆角
    [[v layer] setBorderColor:[UIColor colorWithRed:0/255.0 green:204/255.0 blue:176/255.0 alpha:1].CGColor];//线颜色
    [[v layer] setBorderWidth:2.0];//线宽
    [self.view addSubview:v];
    
    FenXingMingZi=[[UILabel alloc]initWithFrame:CGRectMake(v.frame.origin.x-45, v.frame.size.height/3.5, v.frame.size.width/2+30, 20)];
    FenXingMingZi.text=@"微信公众号: DJJRFW";
    FenXingMingZi.font=[UIFont fontWithName:@"Heiti SC" size:12];
    [v addSubview:FenXingMingZi];
    
    UIImageView *imageWeiXin=[[UIImageView alloc]initWithFrame:CGRectMake(v.frame.size.width-40, FenXingMingZi.frame.origin.y-5, 30, 30)];
    imageWeiXin.image=[UIImage imageNamed:@"ic_weixin"];
    [v addSubview:imageWeiXin];
    
    UIButton  *btn=[[UIButton alloc]initWithFrame:v.frame];
    [btn addTarget:self action:@selector(WeiXinKaiQi) forControlEvents:UIControlEventTouchUpInside];
    
    kuan=v.frame.size.width;
    gao1=v.frame.origin.y;
    fromx=v.frame.origin.x;
    
    //
    
    
    
    if (weixindown!=nil) {
        [weixindown removeFromSuperview];
        weixindown=nil;
    }
    
    weixindown = [[UITableView alloc] init];
    // weixindown.menuText = [NSString stringWithFormat:@"还款前%d天提醒",inm];
    weixindown.dataSource=self;
    weixindown.delegate=self;
    
    
    [weixindown setFrame:CGRectMake(fromx, gao1+50,kuan,250)];
    

    [self.view addSubview:btn];
    
 //
    UIView *vQQ=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)/6, CGRectGetMaxY(label.frame)+self.view.frame.size.height/8+v.frame.size.height*2,CGRectGetMaxX(self.view.frame)*2.0/3, 50)];
    vQQ.backgroundColor=[UIColor whiteColor];
    [[vQQ layer] setCornerRadius:10.0];//圆角
    [[vQQ layer] setBorderColor:[UIColor colorWithRed:0/255.0 green:204/255.0 blue:176/255.0 alpha:1].CGColor];//线颜色
    [[vQQ layer] setBorderWidth:2.0];//线宽
    [self.view addSubview:vQQ];

    QQ=[[UILabel alloc]initWithFrame:CGRectMake(v.frame.origin.x-45, v.frame.size.height/3.5, v.frame.size.width/2+30, 20)];
    QQ.text=@"QQ交流群: 485190938";
    QQ.font=[UIFont fontWithName:@"Heiti SC" size:12];
    [vQQ addSubview:QQ];
    
    UIImageView *imageQQ=[[UIImageView alloc]initWithFrame:CGRectMake(v.frame.size.width-40, QQ.frame.origin.y-5, 30, 30)];
    imageQQ.image=[UIImage imageNamed:@"ic_qq"];
    [vQQ addSubview:imageQQ];
    UIButton  *btnQQ=[[UIButton alloc]initWithFrame:vQQ.frame];
    [btnQQ addTarget:self action:@selector(QQKaiQi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnQQ];
    
    gao2=vQQ.frame.origin.y;
    
    
    //
    
    
    if (qqdown!=nil) {
        [qqdown removeFromSuperview];
        qqdown=nil;
    }
    
    qqdown = [[UITableView alloc] init];
    // weixindown.menuText = [NSString stringWithFormat:@"还款前%d天提醒",inm];
    qqdown.dataSource=self;
    qqdown.delegate=self;
    
    
    [qqdown setFrame:CGRectMake(fromx, gao1+50,kuan,250)];
    

  
    //

    
    
    UIView *vShouJiHao=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)/6, CGRectGetMaxY(label.frame)+self.view.frame.size.height/8+v.frame.size.height*4,CGRectGetMaxX(self.view.frame)*2.0/3, 50)];
    vShouJiHao.backgroundColor=[UIColor whiteColor];
    [[vShouJiHao layer] setCornerRadius:10.0];//圆角
    [[vShouJiHao layer] setBorderColor:[UIColor colorWithRed:0/255.0 green:204/255.0 blue:176/255.0 alpha:1].CGColor];//线颜色
    [[vShouJiHao layer] setBorderWidth:2.0];//线宽
    [self.view addSubview:vShouJiHao];
    ShouJiHao=[[UILabel alloc]initWithFrame:CGRectMake(v.frame.origin.x-45, v.frame.size.height/3.5, v.frame.size.width/2+30, 20)];
    ShouJiHao.text=@"客       服: 4001017767";
    ShouJiHao.font=[UIFont fontWithName:@"Heiti SC" size:12];
    [vShouJiHao addSubview:ShouJiHao];
    
    UIImageView *imageShouJiHao=[[UIImageView alloc]initWithFrame:CGRectMake(v.frame.size.width-40, ShouJiHao.frame.origin.y-5, 30, 30)];
    imageShouJiHao.image=[UIImage imageNamed:@"ic_kefu"];
    [vShouJiHao addSubview:imageShouJiHao];
    UIButton  *btnShouJiHao=[[UIButton alloc]initWithFrame:vShouJiHao.frame];
    [btnShouJiHao addTarget:self action:@selector(ShouJiHaoKaiQi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShouJiHao];

     gao3=vShouJiHao.frame.origin.y;
    
    //
   
    
    
    if (rexiandown!=nil) {
        [rexiandown removeFromSuperview];
        rexiandown=nil;
    }
    
    rexiandown = [[UITableView alloc] init];
    // weixindown.menuText = [NSString stringWithFormat:@"还款前%d天提醒",inm];
    rexiandown.dataSource=self;
    rexiandown.delegate=self;
    
    
    [rexiandown setFrame:CGRectMake(fromx, gao1+50,kuan,250)];
    
 

    
    //

    
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==weixindown) {
        return [dataArray count];
    }
    else if (tableView==qqdown)
        return [dataArray1 count];
    else
        return [dataArray2 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ce=@"idd";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ce];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ce];
    }
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *cv in arr) {
        [cv removeFromSuperview];
    }
    
    UILabel * ll1=[[UILabel alloc] initWithFrame:CGRectMake(20, 7, 80, 30)];
    
    
    if (tableView==weixindown)
    {
    ll1.text=[dataArray[indexPath.row] objectForKey:@"title"];
    }
    else if (tableView==qqdown)
    {
    ll1.text=[dataArray1[indexPath.row] objectForKey:@"title"];
    
    
    }
    else
    {
    ll1.text=[dataArray2[indexPath.row] objectForKey:@"title"];
    }
    
    ll1.font=[UIFont fontWithName:@"Heiti SC" size:12];
    
    ll1.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    UIImageView *mm=[[UIImageView alloc] initWithFrame:CGRectMake(kuan-40, 7, 30, 30)];
    
    
    
    if (tableView==weixindown)
    {
        mm.image=[UIImage imageNamed:@"ic_weixin"];
    }
    else if (tableView==qqdown)
    {
       mm.image=[UIImage imageNamed:@"ic_qq"];
    }
    else
    {
       mm.image=[UIImage imageNamed:@"ic_kefu"];
    }
    
    [cell.contentView addSubview:ll1];
    [cell.contentView addSubview:mm];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (index==1) {
        
        FenXingMingZi.text=[NSString stringWithFormat:@"微信公众号:%@",[dataArray[indexPath.row] objectForKey:@"title"]];
        
        [weixindown removeFromSuperview];
        
        if ([WXApi isWXAppInstalled]) {
            
//            [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"wxd930ea5d5a258f4f%d://",i]]];
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:[dataArray[indexPath.row] objectForKey:@"title"]];
            
            NSString *str = [NSString stringWithFormat:@"weixin://"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
            
//            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//            req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
//            req.bText = YES;
//            req.scene =WXSceneSession;
//            
//            [WXApi sendReq:req];
            
            
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您还没有安装微信" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
        }
        
    }
    else if (index==2)
    {
        QQ.text=[dataArray1[indexPath.row] objectForKey:@"title"];
        [qqdown removeFromSuperview];
        
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:[dataArray1[indexPath.row] objectForKey:@"title"]];
        
        NSLog(@"--%@",[dataArray1[indexPath.row] objectForKey:@"title"]);
        
        if ([QQApiInterface isQQInstalled]) {
       
        
       // NSString *str = [NSString stringWithFormat:@"mqq://"];
       // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wpa.qq.com/msgrd?v=3&uin=%@&site=qq&menu=yes",[dataArray1[indexPath.row] objectForKey:@"title"]]]];
            
            NSString *str = [NSString stringWithFormat:@"mqq://"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        else{

            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您还没有安装QQ!" delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil];
            [alertView show];
            
        }
    }
    
    else if (index==3)
    {
        ShouJiHao.text=[dataArray2[indexPath.row] objectForKey:@"title"];
        [rexiandown removeFromSuperview];
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[dataArray2[indexPath.row] objectForKey:@"title"]];
        
        //NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13206755376"];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
    
    
    
}

-(void)ShouJiHaoKaiQi
{
    [rexiandown removeFromSuperview];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4001017767"]];
    NSLog(@"dianjile");

}
-(void)QQKaiQi
{
   
//    [qqdown removeFromSuperview];
//    if ([QQApiInterface isQQSupportApi]) {
//    
//    if ([QQApiInterface isQQInstalled]) {
//        
//        
//        // NSString *str = [NSString stringWithFormat:@"mqq://"];
//        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        
//        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wpa.qq.com/msgrd?v=3&uin=%@&site=qq&menu=yes",[dataArray1[indexPath.row] objectForKey:@"title"]]]];
//        
//        NSString *str = [NSString stringWithFormat:@"mqq://"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        
//    }
//    else{
//        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的QQ没有在线!" delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil];
//        [alertView show];
//        
//    }
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的QQ未允许此功能!" delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil];
//        [alertView show];
//    }
    

}
-(void)WeiXinKaiQi
{
    
    
//    [weixindown removeFromSuperview];
//    if([WXApi isWXAppSupportApi]){
//    
//    if ([WXApi isWXAppInstalled]) {
//        
//        //            [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"wxd930ea5d5a258f4f%d://",i]]];
//     
//        
//        NSString *str = [NSString stringWithFormat:@"weixin://"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        
//        
//                    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//                    req.text = @"15776420041";
//                    req.bText = YES;
//                    req.scene =WXSceneSession;
//        
//                    [WXApi sendReq:req];
//        
//        
//    }else
//    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的微信没有在线!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        
//    }
//    }
//    else{
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的微信未允许此功能!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [weixindown removeFromSuperview];
    [qqdown removeFromSuperview];
    [rexiandown removeFromSuperview];
    
}



- (IBAction)fanhui:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
