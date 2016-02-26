//
//  FenXiangXiaZaiVC.m
//  短借宝
//
//  Created by iMac21 on 15/9/1.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "FenXiangXiaZaiVC.h"
#import "UMSOcial.h"
#import "MBProgressHUD.h"


@interface FenXiangXiaZaiVC ()<UMSocialUIDelegate>{
    
    float width,heig;
}

@end

@implementation FenXiangXiaZaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(width/4, 50, width/2, width/2)];
    
    img.image=[UIImage imageNamed:@"qrcode.png"];
    
    UIButton *bb1=[[UIButton alloc] initWithFrame:CGRectMake(16, 100+width/2, width-32, 44)];
    
    [bb1 setTitle:@"点击分享" forState:UIControlStateNormal];
    [bb1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bb1 addTarget:self action:@selector(bun:) forControlEvents:UIControlEventTouchUpInside];
    bb1.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    
    [bb1.layer setCornerRadius:8.0f];
    
    [self.view addSubview:bb1];
   
    [self.view addSubview:img];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bun:(UIButton *)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56025bf7e0f55ab30c003242"
                                      shareText:@"短借宝 助你一“币”之力"
                                     shareImage:[UIImage imageNamed:@"Icon-60.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
    
    
    //    Qzone分享
    
   // [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
   // [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
    
    //[[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://star.xiziwang.net/uploads/allimg/140930/19_140930101146_1.jpg"];
    
    
    
    
    //[UMSocialData defaultData].extConfig.qzoneData.shareText = @"111";
    
    //[UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageNamed:@"qrcode.png"];
    
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        
//        MBProgressHUD *HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        HUD.mode=MBProgressHUDModeText;
//        
//        HUD.labelText=[NSString stringWithFormat:@"%@分享成功",@""];
//        
//        [HUD setRemoveFromSuperViewOnHide:YES];
//        
//        [HUD hide:YES afterDelay:2];
    
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
