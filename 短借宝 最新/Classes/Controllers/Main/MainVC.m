//
//  MainVC.m
//  借贷宝
//
//  Created by imac21 on 15/7/5.
//  Copyright (c) 2015年 imac21. All rights reserved.
//

#import "MainVC.h"
#import "LoanComprehendViewControllers.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "Networking.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "advertisementVC.h"
#import "LoanChoiceWriteVC.h"
#import "QuickLoanMoneyVC.h"
#import "JSONKit.h"
#import "Header.h"
#import "ViewController1.h"
#import "WoYao_chuangyeTableViewController.h"
#import "MBProgressHUD.h"
#import "LoanInfomationVC.h"
#import "LeftRegisterVC.h"
#import "ExamineCharacherTVC.h"
@interface MainVC ()<JCTopicDelegate>{
    
    float width,heig;
    MBProgressHUD *HUD;
}

@property (strong ,nonatomic)NSMutableArray *tempArray;

//装scroll的View
@property (weak, nonatomic) IBOutlet UIView *scorllOfView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrantWidth;
@property (strong, nonatomic) MainVC *main;

//@property(nonatomic,strong)JCTopic * Topic;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy)   NSString *zxbtA1;
@property (nonatomic, strong) UIImage *zxfmA1;


@end
@implementation MainVC
@synthesize zxbtA1,zxfmA1;


-(NSMutableArray*)tempArray{
    
    if (_tempArray==nil) {
        _tempArray=[NSMutableArray array];
    }
    return _tempArray;
}

//-(NSString*)zxnr1{
//
//    if (_zxnr1==nil) {
//        _zxnr1=[[NSString alloc]init];
//    }
//    return _zxnr1;
//}



-(void)updateViewConstraints {
    [super updateViewConstraints];
    self.constrantWidth.constant = SCREEN_WIDTH;
}
- (IBAction)JiSuDaiKuan_btn:(UIButton *)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",nil];
    //    NSLog(@"%@",[defaults3 objectForKey:@"zhid"]);
    
    NSString *strJson = [dataDictionary JSONString];
    //    NSLog(@"%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!queryHydk_flag.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"Success----: %@", responseObject);
        
        [defaults3 setObject:[responseObject[0] objectForKey:@"flag"] forKey:@"DaiKuanShiFouKeYi"];
        [defaults3 setObject:[responseObject[0] objectForKey:@"massages"] forKey:@"DaiKuanShuChuXinXi"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //        NSLog(@"%@",error);
        
    }];
    
    
    //判断
    
    //NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    
    if ([defaults3 integerForKey:@"true"]==1) {
        
        //    或有真则为真
        //            NSLog(@"测试null%d",[[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@"null"]);
        //            NSLog(@"测试nil%d",[defaults3 objectForKey:@"GeRenXinXi_Name_Field"]==nil);
        //            NSLog(@"%lu",(unsigned long)[[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] length]);
        
        
        if ([[defaults3 objectForKey:@"DaiKuanShiFouKeYi"] integerValue]==1) {
            
            
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText = [defaults3 objectForKey:@"DaiKuanShuChuXinXi"];
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:3];
            
            
            
        }else{
            
            if ([[defaults3 objectForKey:@"GeRenXinXi_SuoZaiDaXue_Field"] isEqual:@""]||[[defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"] isEqual:@""]||[[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"] isEqual:@""]||[[defaults3 objectForKey:@"zjz1"] isEqual:@""]||[[defaults3 objectForKey:@"GeRenXinXi_SuoZaiDaXue_Field"] isEqual:@"null"]||[[defaults3 objectForKey:@"LianXiRenXinXi_Name_Field"] isEqual:@"null"]||[[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"] isEqual:@"null"]||[[defaults3 objectForKey:@"zjz1"] isEqual:@"null"]) {
                
                
                
                //        四个圈
                LoanInfomationVC *l=[self.storyboard instantiateViewControllerWithIdentifier:@"LoanInfomation"];
                
                [self.navigationController pushViewController:l animated:YES];
                
            }else{
                
                
                WoYao_chuangyeTableViewController *l1=[self.storyboard instantiateViewControllerWithIdentifier:@"woyaochuangye"];
                
                [self.navigationController pushViewController:l1 animated:YES];
                
                
                
            }
        }
    }
    else
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请先登录";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:3];
        
        
        LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
        
        
        [self.navigationController
         pushViewController:left3 animated:YES];
        
        
        
        
    }
    
    
    
}
- (IBAction)PuDaiKuan_btn:(UIButton *)sender {
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    [defaults3 setObject:@"0" forKey:@"DaiKuanLeiXing"];
    
    QuickLoanMoneyVC* QL=[self.storyboard instantiateViewControllerWithIdentifier:@"QuickLoanMoney"];
    
    [self.navigationController pushViewController:QL animated:YES];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    
    UIView *vv=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    
    vv.backgroundColor=[UIColor blueColor];
    
    self.navigationItem.titleView=vv;
    
    [self shoyejiazai];
}


//首页加载
-(void)shoyejiazai
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidIndexAction!indexInit.action",networkAddress];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"url--%@",url2);
    
    [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"gg---%@",responseObject);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[resultDic objectForKey:@"jdlv"] forKey:@"jdlv"];
        
        
        
        NSArray *resultDic1=[resultDic objectForKey:@"zxxx"];
        
        [[NSUserDefaults standardUserDefaults] setObject:resultDic1 forKey:@"zxxx"];
        
        NSString *pathxx=[NSString stringWithFormat:@"%@/Documents/xinxi.plist",NSHomeDirectory()];
        
        [resultDic1 writeToFile:pathxx atomically:YES];
        
        
        for (int i=0; i<resultDic1.count; i++) {
            
            NSDictionary *d= [resultDic1 objectAtIndex:i];
            
            self.zxbtA1=[d objectForKey:@"zxbt"];
            
            self.zxfmA1=[d objectForKey:@"zxfm"];
            
            self.zxnr1=[d objectForKey:@"zxnr"];
            
            
            
            //        if (!_Topic) {
            //实例化
            self.Topic = [[JCTopic alloc]init];
            self.Topic.frame = self.scorllOfView.bounds;
            
            
            
            //代理
            self.Topic.JCdelegate = self;
            //创建数据
            //                NSMutableArray * tempArray = [NSMutableArray array];
            
            //网络图片加载失败
            
            UIImage * PlaceholderImage = [UIImage imageNamed:@"photo_edit_photos_btn_normal.png"];
            
            
            //网络图片
            //***********************//
            //key pic = 地址 NSString
            //key title = 显示的标题 NSString
            //key isLoc = 是否本地图片 Bool
            //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
            //***********************//
            
            NSString *urlImage1=[NSString stringWithFormat:@"%@%@",networkAddress,zxfmA1];
            
            [self.tempArray addObject:[NSDictionary dictionaryWithObjects:@[urlImage1,zxbtA1,@NO,PlaceholderImage,[d objectForKey:@"zxnr"]] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage",@"Uiwed"]]];
            
        }
        
        self.Topic.pics = self.tempArray;
        
        // NSLog(@"top---%@",self.tempArray);
        
        [self.Topic upDate];
        [self.scorllOfView addSubview:self.Topic];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"无法连接网络，请检查网络连接状态！";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    //停止自己滚动的timer
    [_Topic releaseTimer];
}

- (void)viewDidAppear:(BOOL)animated {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - JCTop delegate

-(void)didClick:(int)data{
    //    NSLog(@"vvvvvv%@",[data objectForKey:@"Uiwed"]);
    
    advertisementVC *aVC=[self.storyboard instantiateViewControllerWithIdentifier:@"advertisement"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    aVC.index=data;
    //[defaults setObject:[data objectForKey:@"Uiwed"] forKey:@"web"];
    //    NSLog(@"ddddddd-%d",data);
    
    //    [aVC.uiwed loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    [self.navigationController pushViewController:aVC animated:YES];
    
    
}
-(void)currentPage:(int)page total:(NSUInteger)total{
    
    _pageControl.numberOfPages = total;
    _pageControl.currentPage = page;
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
