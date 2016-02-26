//
//  LeftBorrowMoneyNotarizeVC.m
//  短借宝
//
//  Created by iMac21 on 15/7/20.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.

#import "LeftBorrowMoneyNotarizeVC.h"
#import "JSONKit.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Header.h"
#import "LeftRegisterVC.h"

#import "ZhiFuBaoVC.h"
#import "WeiXinZhiFuVC.h"
#import "guitaiViewController.h"



//#define   BASE_URL  @"http://192.168.1.53:8080/androidIndexAction!schydkpz.action"
@interface LeftBorrowMoneyNotarizeVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    MBProgressHUD *HUD;
    
    float width,heig;
    
    UIView *alertview;
    UIView *bai;
}
@property (strong, nonatomic)  UIImageView *photo;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic)UIImage *image;
@property (strong,nonatomic)NSData *data;
@property(strong,nonatomic)UITextField *HuanKuanBeiZHu;

@end

@implementation LeftBorrowMoneyNotarizeVC


- (IBAction)phin:(UIButton *)sender {
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择文件来源" delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];

}
- (void)segConClick:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.HuanKuanShuoMing.hidden = NO;
            self.HuankuanQueren.hidden = YES;
            
            break;
        case 1:
            self.HuankuanQueren.hidden = NO;
            self.HuanKuanShuoMing.hidden = YES;
            break;
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://照相机
        {                 UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
            
            imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        case 1://本地相簿
        {                 UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage])
    {
        //先把图片转成NSData
        _image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (UIImagePNGRepresentation(_image) == nil)
        {
            _data = UIImageJPEGRepresentation(_image, 1.0);
        }
        else
        {
            _data = UIImagePNGRepresentation(_image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        
        //[fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image5"] contents:_data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        
        //        self.fileData = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //NSLog(@"%@",self.fileData);
        
        //关闭相册界面
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相簿
        
        self.photo.hidden=NO;
        
        self.photo.image=[UIImage imageWithData:_data];
    }
    
    
}
- (IBAction)BaoCun:(UIButton *)sender {
    
  [self getdangqianjk];
   
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    _segmentedControl=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"还款说明",@"还款确认", nil]];
                       
                       
   _segmentedControl.frame= CGRectMake(16, 12, width-32, 42);
    
    _segmentedControl.tintColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    
    [_segmentedControl addTarget:self action:@selector(segConClick:) forControlEvents:UIControlEventValueChanged];

    _segmentedControl.selectedSegmentIndex = 1;//设置默认选择项索引
    
    [self.view addSubview:_segmentedControl];
    
    
    _HuanKuanShuoMing=[[UIView alloc] initWithFrame:CGRectMake(0, 59, width, heig-59)];
    
    _HuanKuanShuoMing.backgroundColor=[UIColor clearColor];
    
    UIButton *zhifubao=[[UIButton alloc] initWithFrame:CGRectMake(16, 0, width-32, 40)];
    [zhifubao setTitle:@"支付宝还款说明" forState:UIControlStateNormal];
    [zhifubao setTitleColor:[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f] forState:UIControlStateNormal];
    zhifubao.backgroundColor=[UIColor whiteColor];
    
    [zhifubao addTarget:self action:@selector(zhifubao) forControlEvents:UIControlEventTouchUpInside];
    [_HuanKuanShuoMing addSubview:zhifubao];
    _HuanKuanShuoMing.hidden=YES;
    
    
    UIButton *weixin=[[UIButton alloc] initWithFrame:CGRectMake(16, 42, width-32, 40)];
    [weixin setTitle:@"微信还款说明" forState:UIControlStateNormal];
    [weixin setTitleColor:[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f] forState:UIControlStateNormal];
    weixin.backgroundColor=[UIColor whiteColor];
    
    [weixin addTarget:self action:@selector(weixin) forControlEvents:UIControlEventTouchUpInside];
    [_HuanKuanShuoMing addSubview:weixin];
    
    UIButton *guitai=[[UIButton alloc] initWithFrame:CGRectMake(16, 84, width-32, 40)];
    [guitai setTitle:@"柜台还款说明" forState:UIControlStateNormal];
    [guitai setTitleColor:[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f] forState:UIControlStateNormal];
    guitai.backgroundColor=[UIColor whiteColor];
    
    [guitai addTarget:self action:@selector(guitai) forControlEvents:UIControlEventTouchUpInside];
    [_HuanKuanShuoMing addSubview:guitai];

    [self.view addSubview:_HuanKuanShuoMing];
    
    
    _HuankuanQueren=[[UIView alloc] initWithFrame:CGRectMake(0, 59, width, heig-59)];
    
    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(16, 170, width-32, 48)];
    
    img1.image=[UIImage imageNamed:@"queren_15"];
    [_HuankuanQueren addSubview:img1];
    
    UIButton *bb23=[[UIButton alloc] initWithFrame:CGRectMake(16, 75, width-32, 254)];
    [bb23 addTarget:self action:@selector(phin:) forControlEvents:UIControlEventTouchUpInside];
    
    [_HuankuanQueren addSubview:bb23];
    
    _HuanKuanBeiZHu=[[UITextField alloc] initWithFrame:CGRectMake(16, 8, width-32, 41)];
    _HuanKuanBeiZHu.font=[UIFont systemFontOfSize:13.0f];
    _HuanKuanBeiZHu.placeholder=@"请添加还款备注（例如 姓名及还款时间）";
    
    [_HuanKuanBeiZHu.layer setBorderWidth:1.0f];
    [_HuanKuanBeiZHu.layer setCornerRadius:5.0f];

    [_HuanKuanBeiZHu.layer setBorderColor:[[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f] CGColor]];
    _HuanKuanBeiZHu.delegate=self;
    
    [_HuankuanQueren addSubview:_HuanKuanBeiZHu];
    
    UIButton *bb231;
    
    if (heig==480) {
    bb231=[[UIButton alloc] initWithFrame:CGRectMake(16, 293, width-32, 40)];
    }
    else
    bb231=[[UIButton alloc] initWithFrame:CGRectMake(16, 353, width-32, 40)];
    //[bb231 setImage:[UIImage imageNamed:@"enniuzhengchang2x_03"] forState:UIControlStateNormal];
    
    [bb231 setTitle:@"确认还款" forState:UIControlStateNormal];
    [bb231 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    bb231.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f];
    [bb231.layer setCornerRadius:5.0f];
    
    [bb231 addTarget:self action:@selector(BaoCun:) forControlEvents:UIControlEventTouchUpInside];
    
    [_HuankuanQueren addSubview:bb231];
    
    
    if (heig==480) {
        _photo=[[UIImageView alloc] initWithFrame:CGRectMake((width-100)/2, 57, 100, 100)];
    }
    else
    _photo=[[UIImageView alloc] initWithFrame:CGRectMake(16, 57, width-32, 288)];
    
    _photo.hidden=YES;
    [_HuankuanQueren addSubview:_photo];
    
    [self.view addSubview:_HuankuanQueren];
    
    
    NSData *ss=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/image5",NSHomeDirectory()]];
    
    
    //    self.photo.image=[UIImage imageWithData:ss];
    UIImage *m=[UIImage imageWithData:ss];
    
    NSData* imageData = UIImagePNGRepresentation(m);
    
    if (ss==nil) {
        
    }
    else{
        
        self.photo.hidden=NO;
        self.photo.image=[UIImage imageWithData:imageData];
    }
    
    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
    
    [defaults3 setObject:imageData forKey:@"zjz5"];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)zhifubao{
    
    ZhiFuBaoVC *zz=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ZhiFuBao"];
    
    [self.navigationController pushViewController:zz animated:YES];
    
}

-(void)weixin{
    
    WeiXinZhiFuVC *zz=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeiXinZhiFu"];
    
    [self.navigationController pushViewController:zz animated:YES];
}

-(void)guitai{
    
    guitaiViewController *zz=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"guitai"];
    
    [self.navigationController pushViewController:zz animated:YES];
    
}


-(void)TuPianShangChuan
{
    
    
    [self getweiyi];
    
    
}

-(void)getdangqianjk{
    
    
    //网络
    
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
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",@"1",@"pagenumber",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    //    NSLog(@"%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!selectdqjk.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"dangqian--%@",responseObject);
        [HUD hide:YES];
        [HUD removeFromSuperview];
        HUD=nil;
        
        if ([operation.responseObject count]==0) {
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.yOffset=100;
            
            UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
            ll.backgroundColor=[UIColor clearColor];
            
            ll.text=@"未借款，无法进行还款操作！";
            ll.textColor=[UIColor whiteColor];
            
            ll.numberOfLines=0;
            
            [ll sizeToFit];
            
            HUD.customView=ll;
            
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:2];
            
        }
        else
        {
        if ([[responseObject[0]  objectForKey:@"cwfkbs"]intValue]!=1 ) {
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
                        HUD.mode = MBProgressHUDModeCustomView;
            
                        HUD.yOffset=100;
            
            
                        UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
                        ll.backgroundColor=[UIColor clearColor];
            
                        ll.text=@"未放款，无法进行还款操作！";
                        ll.textColor=[UIColor whiteColor];
            
                        ll.numberOfLines=0;
            
                        [ll sizeToFit];
            
                        HUD.customView=ll;
                        
                        
                        HUD.removeFromSuperViewOnHide=YES;
                        
                        [HUD hide:YES afterDelay:2];
                        

           
            
        }
        else
        {
            if ([[responseObject[0] objectForKey:@"hksq"] intValue]!=0) {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeCustomView;
                
                HUD.yOffset=100;
                
                
                UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
                ll.backgroundColor=[UIColor clearColor];
                
                ll.text=@"已还款，无法再次进行还款操作！";
                ll.textColor=[UIColor whiteColor];
                
                ll.numberOfLines=0;
                
                [ll sizeToFit];
                
                HUD.customView=ll;
                
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:2];
            }
            else
            {
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject[0] objectForKey:@"id"] forKey:@"DaiKuanXinXiID"];
            
            [self popview1];
            }
        }

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [HUD hide:YES];
        [HUD removeFromSuperview];
        HUD=nil;
        
        NSLog(@"%@",error);
        
    }];
  
}

    
-(void)getweiyi{
    
    
   // 先获取是否唯一
    
    //网络
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    //HUD.dimBackground=YES;
    
    [HUD show:YES];
    

    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[defaults objectForKey:@"zhid"]],@"hyzhid",[defaults objectForKey:@"kkkey"],@"key", nil];
    
    
    NSString *strJson = [dataDictionary JSONString];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidLogAction!compareLP.action?compare=%@",networkAddress,strJson];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSLog(@"get--url--%@",url2);
    
    [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      //  NSLog(@"%@",responseObject);
        
        NSLog(@"dsa---%@",responseObject);
        
        [HUD hide:YES];
        
        [HUD removeFromSuperview];
        
        HUD=nil;
        
        
        
        if ([[responseObject objectForKey:@"flag"] intValue]==1)
        
        [self getshangchuan];
        
        else{
            
            [self popview];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [HUD hide:YES];
        
        [HUD removeFromSuperview];
        
        HUD=nil;
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"网络未连接，请重试！";
        
        HUD.margin = 10.f;
        
        [HUD hide:YES afterDelay:2];
        
    }];

    
}
-(void)popview1{
    
    
    alertview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    alertview.backgroundColor=[UIColor darkGrayColor];
    
    bai=[[UIView alloc] initWithFrame:CGRectMake(0, 120, width, 172)];
    
    bai.backgroundColor=[UIColor whiteColor];
    
    UILabel *ll11=[[UILabel alloc] initWithFrame:CGRectMake(25, 16, width-16, 20)];
    ll11.text=@"提示";
    ll11.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:ll11];
    
    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(16, 52, width-32, 1)];
    heng.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [bai addSubview:heng];
    
    UILabel  *tishi=[[UILabel alloc] initWithFrame:CGRectMake(25, 75, width-50, 20)];
    tishi.text=@"是否上传";
    
    tishi.numberOfLines=0;
    
    [tishi sizeToFit];
    tishi.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:tishi];
    
    UIView *heng1=[[UIView alloc] initWithFrame:CGRectMake(0, 122, width-32, 1)];
    heng1.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    [bai addSubview:heng1];
    
    UIButton *que=[[UIButton alloc] initWithFrame:CGRectMake(width/2, 123, width/2, 50)];
    
    [que setTitle:@"确认" forState:UIControlStateNormal];
    [que setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    que.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [que addTarget:self action:@selector(queding1) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:que];
    
    UIButton *quxiao=[[UIButton alloc] initWithFrame:CGRectMake(0, 123, width/2, 50)];
    
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f] forState:UIControlStateNormal];
    quxiao.backgroundColor=[UIColor whiteColor];
    [quxiao addTarget:self action:@selector(quxiaoba1) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:quxiao];
    alertview.alpha=0.7;
    [self.view addSubview:alertview];
    [self.view addSubview:bai];
    
    
    
}

-(void)queding1{
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
    
    [self TuPianShangChuan];
    
    
}

-(void)quxiaoba1{
    
    
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
}


-(void)popview{
    
    
    alertview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    alertview.backgroundColor=[UIColor darkGrayColor];
    
    bai=[[UIView alloc] initWithFrame:CGRectMake(0, 120, width, 172)];
    
    bai.backgroundColor=[UIColor whiteColor];
    
   UILabel *ll11=[[UILabel alloc] initWithFrame:CGRectMake(25, 16, width-16, 20)];
    ll11.text=@"提示";
    ll11.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:ll11];
    
    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(16, 52, width-32, 1)];
    heng.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [bai addSubview:heng];
    
   UILabel  *tishi=[[UILabel alloc] initWithFrame:CGRectMake(25, 75, width-50, 20)];
    tishi.text=@"该账号已在其他设备登陆，请重新登陆！";
    
    tishi.numberOfLines=0;
    
    [tishi sizeToFit];
    tishi.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:tishi];
    
   UIView *heng1=[[UIView alloc] initWithFrame:CGRectMake(0, 122, width-32, 1)];
    heng1.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    [bai addSubview:heng1];
    
   UIButton *que=[[UIButton alloc] initWithFrame:CGRectMake(width/2, 123, width/2, 50)];
    
    [que setTitle:@"确认" forState:UIControlStateNormal];
    [que setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    que.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [que addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:que];
    
    UIButton *quxiao=[[UIButton alloc] initWithFrame:CGRectMake(0, 123, width/2, 50)];
    
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f] forState:UIControlStateNormal];
    quxiao.backgroundColor=[UIColor whiteColor];
    [quxiao addTarget:self action:@selector(quxiaoba) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:quxiao];
    alertview.alpha=0.7;
    [self.view addSubview:alertview];
    [self.view addSubview:bai];
    
    
    
}

-(void)queding{
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
    
    LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
    
    [self.navigationController pushViewController:left3 animated:YES];

    
    
}

-(void)quxiaoba{
    
    
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
}

-(void)getshangchuan{
    
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    //HUD.dimBackground=YES;
    
    [HUD show:YES];
    

    
    //转换URL格式；
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@androidIndexAction!schydkpz.action",networkAddress]];
    //创建请求对象；
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //请求方式；
   // request.HTTPMethod = @"POST";
    // 设置请求头信息-数据类型
    [request setValue:@"multipart/form-data; boundary=---------------------------7da213758061" forHTTPHeaderField:@"Content-Type"];
    
    // 拼接请求体,用来保存上传数据流；
    NSMutableData *data = [NSMutableData data];
    
    
    // 普通参数-hyid
    // 普通参数开始的一个标记
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];

    [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 参数描述
    // zhid:会员账号id，dkxxid:贷款信息id，hyxm:会员姓名，hkbz:还款备注 hkpz：还款凭证图片
    [data appendData:[@"Content-Disposition:form-data; name=\"zhid\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *str_hy = [NSString stringWithFormat:@"\r\n%@\r\n",[defaults3 objectForKey:@"zhid"]];
    
    NSLog(@"zhid---%@",str_hy);
    
    [data appendData:[str_hy dataUsingEncoding:NSUTF8StringEncoding]];

    [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Disposition:form-data; name=\"dkxxid\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *str_dk = [NSString stringWithFormat:@"\r\n%@\r\n",[defaults3 objectForKey:@"DaiKuanXinXiID"]];
    
    NSLog(@"str_dk---%@",str_dk);
    
    
    [data appendData:[str_dk dataUsingEncoding:NSUTF8StringEncoding]];

    [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Disposition:form-data; name=\"hyxm\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *str_xm = [NSString stringWithFormat:@"\r\n%@\r\n",[defaults3 objectForKey:@"GeRenXinXi_Name_Field"]];
    
    NSLog(@"str-xm---%@",str_xm);
    
    [data appendData:[str_xm dataUsingEncoding:NSUTF8StringEncoding]];

    [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Disposition:form-data; name=\"hkbz\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *str_hk = [NSString stringWithFormat:@"\r\n%@\r\n",self.HuanKuanBeiZHu.text];
    
    NSLog(@"str_hk---%@",str_hk);
    
    [data appendData:[str_hk dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 文件参数-hkpz
    // 文件参数开始的一个标记
    [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 文件参数描述
    [data appendData:[@"Content-Disposition:form-data; name=\"hkpz\"; filename=\"image5.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 文件的MINETYPE
    [data appendData:[@"Content-Type:image/jpg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 文件内容
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //图片对象；
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/image5",NSHomeDirectory()];
    
    NSFileManager *ff=[NSFileManager defaultManager];
    
    if ([ff fileExistsAtPath:filePath]) {
        NSLog(@"cunzai");
    }
    else
    {
        NSLog(@"dsadsameiyou");
        
    }
    UIImage *image = [UIImage imageNamed:filePath];
    
    NSData *hkpz = UIImageJPEGRepresentation(image, 0.5);
    
    [data appendData:hkpz];
    
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    // 参数结束的标识
    [data appendData:[@"-----------------------------7da2137580612--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPMethod:@"POST"];//定义方法为post.所以如果在PHP端接收的话，以$_POST["user"],$_POST["password"]结收数据
    [request setHTTPBody:data];//将内容加载到请求中
    
    NSData *respondse=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//创建连接
    
    NSString * myGet=[[NSString alloc] initWithData:respondse encoding:NSUTF8StringEncoding];//接收数据
    
    NSDictionary *sdf=[NSJSONSerialization JSONObjectWithData:respondse options:NSJSONReadingMutableLeaves error:nil];
   
    if (HUD) {
        
       [HUD removeFromSuperview];
        
        HUD=nil;
    }
    
    NSLog(@"\n\n\nsdf=== \n\n%@\n\n\n",sdf);
    if ([[sdf objectForKey:@"flag"] intValue]==0) {
      
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"还款凭证上传不成功，请重新上传！";
        
        HUD.margin = 10.f;
        
        [HUD show:YES];
        
        [HUD hide:YES afterDelay:2];
        
    }
    else{
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"还款凭证上传成功！";
        
        HUD.margin = 10.f;
        
        [HUD show:YES];
        
        // 清除还款图片
        
        NSString *filePath = [NSString stringWithFormat:@"%@/Documents/image5",NSHomeDirectory()];
        
        NSFileManager *ff=[NSFileManager defaultManager];

        [ff removeItemAtPath:filePath error:nil];
        
        
        [self performSelector:@selector(fanhh) withObject:nil afterDelay:2];

        
    }
    
    NSLog(@"receive--%@",myGet);
    
    // 上传是否成功？

}

-(void)fanhh{
    
     [HUD hide:YES afterDelay:2];
    [HUD removeFromSuperview];
    
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
