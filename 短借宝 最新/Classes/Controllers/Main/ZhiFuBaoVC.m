//
//  ZhiFuBaoVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/26.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "ZhiFuBaoVC.h"

@interface ZhiFuBaoVC (){
    
    float width,heig;
}
@property (strong, nonatomic) UIScrollView *zhifubao;

@end

@implementation ZhiFuBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    
    _zhifubao=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    
    _zhifubao.contentSize=CGSizeMake(width,2800);
    
    UILabel *ll1=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, width-20, 20)];
    ll1.text=@"支付宝还款注意事项";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        ll1.font=[UIFont systemFontOfSize:14.0f weight:2];
    }
    else
        ll1.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll1];
    
    UILabel *ll2=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, width-20, 20)];
    ll2.text=@"短借宝支付账号：";
    ll2.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll2.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll2];
    
    UILabel *ll3=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, width-20, 20)];
    ll3.text=@"1140048893@qq.com";
    ll3.textColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    ll3.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll3];
    
    UILabel *ll4=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, width-20, 20)];
    ll4.text=@"账户名：";
    ll4.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll4.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll4];
    
    UILabel *ll5=[[UILabel alloc] initWithFrame:CGRectMake(10, 130, width-20, 20)];
    ll5.text=@"黑龙江短借金融服务外包有限公司";
    ll5.textColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    ll5.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll5];
    
    UILabel *ll6=[[UILabel alloc] initWithFrame:CGRectMake(10, 170, width-20, 20)];
    ll6.text=@"还款时请填写\"捎句话\"";
    ll6.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll6.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll6];
    
    UILabel *ll7=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, width-20, 20)];
    ll7.text=@"XXXXX.XXXXX";
    ll7.textColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    ll7.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll7];
    
    
    UILabel *ll8=[[UILabel alloc] initWithFrame:CGRectMake(10, 230, width-20, 20)];
    ll8.text=@"以免造成还款失败";
    ll8.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll8.font=[UIFont systemFontOfSize:14.0f];
    
    [_zhifubao addSubview:ll8];
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 260, width, 2500)];
    
    img.image=[UIImage imageNamed:@"zfbk"];
    
    [_zhifubao addSubview:img];
    
    [self.view addSubview:_zhifubao];
    
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
