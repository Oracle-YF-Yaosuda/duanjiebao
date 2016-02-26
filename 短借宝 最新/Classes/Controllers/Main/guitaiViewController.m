//
//  guitaiViewController.m
//  短借宝
//
//  Created by ll on 15/9/29.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "guitaiViewController.h"

@interface guitaiViewController (){
    
    float width,heig;
}

@end

@implementation guitaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    
    
    UILabel *ll1=[[UILabel alloc] initWithFrame:CGRectMake(10, 74, width-20, 20)];
    ll1.text=@"柜台还款注意事项";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        ll1.font=[UIFont systemFontOfSize:14.0f weight:2];
    }
    else
        ll1.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll1];
    
    UILabel *ll2=[[UILabel alloc] initWithFrame:CGRectMake(10, 104, width-20, 20)];
    ll2.text=@"短借宝账号：";
    ll2.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll2.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll2];
    
    UILabel *ll3=[[UILabel alloc] initWithFrame:CGRectMake(10, 134, width-20, 20)];
    ll3.text=@"1218053044337058";
    ll3.textColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    ll3.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll3];
    
    UILabel *ll4=[[UILabel alloc] initWithFrame:CGRectMake(10, 164, width-20, 20)];
    ll4.text=@"账户名：";
    ll4.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll4.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll4];
    
    UILabel *ll5=[[UILabel alloc] initWithFrame:CGRectMake(10, 194, width-20, 20)];
    ll5.text=@"黑龙江短借金融服务外包有限公司";
    ll5.textColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    ll5.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll5];
    
    UILabel *ll6=[[UILabel alloc] initWithFrame:CGRectMake(10, 224, width-20, 20)];
    ll6.text=@"开户行";
    ll6.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll6.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll6];
    
    UILabel *ll7=[[UILabel alloc] initWithFrame:CGRectMake(10, 254, width-20, 20)];
    ll7.text=@"哈尔滨宣化支行";
    ll7.textColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    ll7.font=[UIFont systemFontOfSize:14.0f];
    
    [self.view addSubview:ll7];
    
  
    
    
    
    
    // Do any additional setup after loading the view.
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
