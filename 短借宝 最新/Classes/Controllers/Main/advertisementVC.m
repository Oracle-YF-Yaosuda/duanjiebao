//
//  advertisementVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/13.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "advertisementVC.h"
#import "MBProgressHUD.h"
@interface advertisementVC (){
    
    float width,heig;
    MBProgressHUD *hud;
}
@end

@implementation advertisementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    // Do any additional setup after loading the view.

    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSArray *shuju=[defaults objectForKey:@"zxxx"];
    
    NSString *pathxx=[NSString stringWithFormat:@"%@/Documents/xinxi.plist",NSHomeDirectory()];
    
    if (!shuju) {
        shuju=[NSArray arrayWithContentsOfFile:pathxx];
    }
    
    NSDictionary *dic=shuju[_index-1];;
    
    
    UIView *top=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 60)];
    top.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0f];
    
    UILabel *ll1=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
    ll1.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll1.font=[UIFont systemFontOfSize:14];
    
    if ([[dic objectForKey:@"zxly"] isEqual:[NSNull null]]) {
        ll1.text=[NSString stringWithFormat:@"来源：%@",@""];
    }
    else
    ll1.text=[NSString stringWithFormat:@"来源：%@",[dic objectForKey:@"zxly"]];
    [top addSubview:ll1];
    
    UILabel *ll2=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 150, 20)];
    ll2.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll2.font=[UIFont systemFontOfSize:14];
    
    if ([[dic objectForKey:@"fbry"] isEqual:[NSNull null]]) {
        ll2.text=[NSString stringWithFormat:@"发布人员：%@",@""];
    }
    else
    ll2.text=[NSString stringWithFormat:@"发布人员：%@",[dic objectForKey:@"fbry"]];
    [top addSubview:ll2];
    
    UILabel *ll3=[[UILabel alloc] initWithFrame:CGRectMake(width- 160, 10, 150, 20)];
    ll3.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll3.font=[UIFont systemFontOfSize:14];
    
    long time=[[dic objectForKey:@"fbsj"] longLongValue]/1000;

    NSDate *ddd=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *form=[[NSDateFormatter alloc] init];
    
    [form setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    ll3.text=[form stringFromDate:ddd];
    
    [top addSubview:ll3];
    
    [self.view addSubview:top];
    
    self.uiwed=[[UIWebView alloc] initWithFrame:CGRectMake(0, 60, width, heig-50-64)];
    
    [self.view addSubview:self.uiwed];
    
    [self.uiwed loadHTMLString:[dic objectForKey:@"zxnr"] baseURL:nil];

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
