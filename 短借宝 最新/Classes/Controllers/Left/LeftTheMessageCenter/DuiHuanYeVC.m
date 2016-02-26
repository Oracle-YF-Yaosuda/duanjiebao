//
//  DuiHuanYeVC.m
//  短借宝
//
//  Created by iMac21 on 15/9/2.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "DuiHuanYeVC.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "Header.h"
#import "MBProgressHUD.h"

@interface DuiHuanYeVC (){
    
    float width,heig;
    UITextField *TextXingMing;
    UITextField *TextShouHuoDiZhi;
    
    MBProgressHUD *HUD;
}

@end

@implementation DuiHuanYeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    
    UIScrollView *scl=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    scl.contentSize=CGSizeMake(width, 504);
    
    [self.view addSubview:scl];
       
    UIView *viewImage=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height/4)];
    viewImage.backgroundColor=[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    
    [scl addSubview:viewImage];
    
    
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(viewImage.frame.size.width/4,viewImage.frame.origin.y,viewImage.frame.size.width/2,viewImage.frame.size.height)];
    
    NSString *urlImage1=[NSString stringWithFormat:@"%@/%@",networkAddress,[_jieshu objectForKey:@"sptp"]];
    NSURL *uel=[NSURL URLWithString:urlImage1];
    [imageV sd_setImageWithURL:uel placeholderImage:[UIImage imageNamed:@"jifenback"]];
    
    imageV.layer.masksToBounds = YES; //没这句话它圆不起来
    imageV.layer.cornerRadius = 8.0; //设置图片圆角的尺度
    [viewImage addSubview:imageV];
    
    UIView *ViewShangPin=[[UIView alloc]initWithFrame:CGRectMake(viewImage.frame.origin.x, CGRectGetMaxY(viewImage.frame), viewImage.frame.size.width, viewImage.frame.size.height-35)];
    ViewShangPin.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    [scl addSubview:ViewShangPin];
    
    UILabel *lableShangPin=[[UILabel alloc]initWithFrame:CGRectMake(ViewShangPin.frame.origin.x+15,ViewShangPin.frame.size.height/7, ViewShangPin.frame.size.width, 20)];
    lableShangPin.text=[_jieshu objectForKey:@"spmc"];
    lableShangPin.textColor=[UIColor blackColor];
    [ViewShangPin addSubview:lableShangPin];
    
    UILabel *lableChangShang=[[UILabel alloc]initWithFrame:CGRectMake(ViewShangPin.frame.origin.x+15,lableShangPin.frame.size.height+25, ViewShangPin.frame.size.width, 20)];
    lableChangShang.text=@"生产厂商:";
    lableChangShang.textColor=[UIColor blackColor];
    [ViewShangPin addSubview:lableChangShang];
    
    UILabel *b=[[UILabel alloc]initWithFrame:CGRectMake(lableChangShang.frame.origin.x+80, lableChangShang.frame.origin.y+2, 80, 20)];
    b.text=[NSString stringWithFormat:@"%@",[_jieshu objectForKey:@"sccj"]];
    b.font=[UIFont fontWithName:@"Heiti SC" size:15];
    [ViewShangPin addSubview:b];
    
    
    UILabel *lableJiFen=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ViewShangPin.frame)-150,lableShangPin.frame.size.height+25, ViewShangPin.frame.size.width, 20)];
    lableJiFen.text=@"兑换积分:";
    lableJiFen.textColor=[UIColor blackColor];
    [ViewShangPin addSubview:lableJiFen];
    
    UILabel *c=[[UILabel alloc]initWithFrame:CGRectMake(width-75, lableJiFen.frame.origin.y-6, 75, 35)];
    c.text=[NSString stringWithFormat:@"%@",[_jieshu objectForKey:@"dhjfe"]];
    c.textColor=[UIColor orangeColor];
    c.font=[UIFont fontWithName:@"Heiti SC" size:30];
    [ViewShangPin addSubview:c];

    

    UILabel *lableJiaGe=[[UILabel alloc]initWithFrame:CGRectMake(ViewShangPin.frame.origin.x+15,lableChangShang.frame.size.height+55, ViewShangPin.frame.size.width, 20)];
    lableJiaGe.text=[NSString stringWithFormat:@"商品价格:"];
    lableJiaGe.textColor=[UIColor blackColor];
    [ViewShangPin addSubview:lableJiaGe];

    
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(lableJiaGe.frame.origin.x+80, lableJiaGe.frame.origin.y+2, 90, 20)];
    a.text=[NSString stringWithFormat:@"¥%@",[_jieshu objectForKey:@"scjg"]];
    a.font=[UIFont fontWithName:@"Heiti SC" size:15];
    [ViewShangPin addSubview:a];
    
    UIView *viewXingMing=[[UIView alloc]initWithFrame:CGRectMake(ViewShangPin.frame.origin.x, CGRectGetMaxY(ViewShangPin.frame)+5, self.view.frame.size.width, 50)];
    viewXingMing.backgroundColor=[UIColor whiteColor];
    [scl addSubview:viewXingMing];
    
    UILabel *lableXingMing=[[UILabel alloc]initWithFrame:CGRectMake(viewXingMing.frame.origin.x+10, viewXingMing.frame.origin.x, 40, viewXingMing.frame.size.height)];
    lableXingMing.text=@"姓名";
    [viewXingMing addSubview:lableXingMing];
    
    TextXingMing=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lableXingMing.frame)+5, viewXingMing.frame.origin.x, viewXingMing.frame.size.width, viewXingMing.frame.size.height)];
    
    TextXingMing.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"GeRenXinXi_Name_Field"];
    [viewXingMing addSubview:TextXingMing];
    
    UIView *viewShouHuoDiZhi=[[UIView alloc]initWithFrame:CGRectMake(ViewShangPin.frame.origin.x, CGRectGetMaxY(viewXingMing.frame)+5, self.view.frame.size.width, 50)];
    viewShouHuoDiZhi.backgroundColor=[UIColor whiteColor];
    NSLog(@"%f",CGRectGetMaxY(viewXingMing.frame)+5);
    [scl addSubview:viewShouHuoDiZhi];
    
    UILabel *lableShouHuoDiZhi=[[UILabel alloc]initWithFrame:CGRectMake(viewShouHuoDiZhi.frame.origin.x+10, viewShouHuoDiZhi.frame.origin.x, 40, viewShouHuoDiZhi.frame.size.height)];
    lableShouHuoDiZhi.text=@"地址";
    [viewShouHuoDiZhi addSubview:lableShouHuoDiZhi];
    
    TextShouHuoDiZhi=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lableShouHuoDiZhi.frame)+5, viewShouHuoDiZhi.frame.origin.x, viewShouHuoDiZhi.frame.size.width, viewShouHuoDiZhi.frame.size.height)];
    TextShouHuoDiZhi.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"SuSheDiZhi"]];
    [viewShouHuoDiZhi addSubview:TextShouHuoDiZhi];
    
    UIView *viewShouJiHao=[[UIView alloc]initWithFrame:CGRectMake(ViewShangPin.frame.origin.x, CGRectGetMaxY(viewShouHuoDiZhi.frame)+5, self.view.frame.size.width, 50)];
    viewShouJiHao.backgroundColor=[UIColor whiteColor];
    [scl addSubview:viewShouJiHao];
    
    UILabel *lableShouJiHao=[[UILabel alloc]initWithFrame:CGRectMake(viewShouJiHao.frame.origin.x+10, viewShouJiHao.frame.origin.x, 60, viewShouJiHao.frame.size.height)];
    lableShouJiHao.text=@"手机号";
    [viewShouJiHao addSubview:lableShouJiHao];
    
    UITextField *TextShouJiHao=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lableShouJiHao.frame)+5, viewShouJiHao.frame.origin.x, viewShouJiHao.frame.size.width, viewShouJiHao.frame.size.height)];
    TextShouJiHao.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    [viewShouJiHao addSubview:TextShouJiHao];

   // [self DangQianDaiKuan];
    
    UIButton *que=[[UIButton alloc] initWithFrame:CGRectMake(16, 440.0*width/320, width-32, 40)];
    
    [que setTitle:@"预订" forState:UIControlStateNormal];
    
    [que setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    que.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1];
    
    [que.layer setCornerRadius:5.0f];
    
    [que addTarget: self action:@selector(yuding) forControlEvents:UIControlEventTouchUpInside];
    
    [scl addSubview:que];
    
    
}


-(void)yuding{
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    //HUD.dimBackground=YES;
    
    [HUD show:YES];

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    //keyword是json格式数据，包括zhid:会员账号id，jflpid:礼品id，xfjf:消费积分，shrxm:收货人姓名 shrdz:收货地址 shrsjh：收货人手机号
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",[_jieshu objectForKey:@"id"],@"jflpid",[_jieshu objectForKey:@"dhjfe"],@"xfjf",TextXingMing.text,@"shrxm",TextShouHuoDiZhi.text,@"shrdz",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],@"shrsjh",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!huydjflp.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"hui---%@",responseObject);
        
        [HUD hide:YES];
        
        [HUD removeFromSuperview];
        
        HUD=nil;
        
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        if ([[resultDic objectForKey:@"flag"] intValue]==1) {
            
            int yuanfen=[[[NSUserDefaults standardUserDefaults] objectForKey:@"HuiYuanJiFen"] intValue];
            int fufen=[[_jieshu objectForKey:@"dhjfe"] intValue];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",yuanfen-fufen] forKey:@"HuiYuanJiFen"];
            
            
            if (HUD) {
                [HUD removeFromSuperview];
            }
            
            
            HUD=[[MBProgressHUD alloc] initWithView:self.view];
            
            [self.view addSubview:HUD];
            
            
            HUD.mode =MBProgressHUDModeText;
            
           // HUD.labelText =@"积分礼品预订成功！";
            HUD.labelText =[resultDic objectForKey:@"massages"];

            HUD.margin = 10.f;
            
            [HUD show:YES];
            
            [self performSelector:@selector(wan) withObject:nil afterDelay:2];
            
        }
        else{
            
            if (HUD) {
                [HUD removeFromSuperview];
            }
          
            
            HUD=[[MBProgressHUD alloc] initWithView:self.view];
            
            [self.view addSubview:HUD];
            
            
            HUD.mode =MBProgressHUDModeText;
            
            HUD.labelText =[resultDic objectForKey:@"massages"];
            
            HUD.margin = 10.f;
            
            [HUD hide:YES afterDelay:2];

            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (HUD) {
            [HUD removeFromSuperview];
        }
        HUD=nil;
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"网络未连接，请重试！";
        
        HUD.margin = 10.f;
        
        [HUD hide:YES afterDelay:2];

        
        NSLog(@"%@",error);
        
    }];
    

    
}

-(void)wan{
    
    [HUD removeFromSuperview];
    HUD=nil;
    
    [self.navigationController popViewControllerAnimated:YES];
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
