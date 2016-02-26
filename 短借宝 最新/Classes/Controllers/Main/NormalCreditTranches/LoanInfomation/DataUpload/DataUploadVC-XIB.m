//
//  DataUploadVC-XIB.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/13.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "Header.h"
#import "DataUploadVC-XIB.h"
#import "OneselfPhotographUploadingVC.h"
#import "IdentityCardUploadingVC.h"
#import "StudentIdentityCardUploadingVC.h"
#import "OneselfPhotographUploadingVC.h"
#import "MBProgressHUD.h"
#import "ShenFenZhengFanMianVC.h"
#import "AFNetworking.h"

@interface DataUploadVC_XIB ()<tupianDelegate1,tupianDelegate2,tupianDelegate3>{
    int a;
    int b;
    int c;
    int d;
    
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UIButton *shenfen;

@property (weak, nonatomic) IBOutlet UIButton *shenfenFanMian;

@property (weak, nonatomic) IBOutlet UIButton *xuesheng;

@property (weak, nonatomic) IBOutlet UIButton *benren;

@end

@implementation DataUploadVC_XIB

-(void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender{
    
    
    
    IdentityCardUploadingVC *idebt=segue.destinationViewController;
    idebt.delegate=self;
    
    StudentIdentityCardUploadingVC *student=segue.destinationViewController;
    student.delegate=self;
    
    OneselfPhotographUploadingVC *one=segue.destinationViewController;
    one.delegate=self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    a=0;
    b=0;
    c=0;
    d=0;
    
    NSUserDefaults *d1=[NSUserDefaults standardUserDefaults];
    
    NSString *zjz11=[d1 objectForKey:@"zjz1"];
    NSString *zjz22=[d1 objectForKey:@"zjz2"];
    NSString *zjz33=[d1 objectForKey:@"zjz3"];
    NSString *zjz44=[d1 objectForKey:@"zjz4"];
    
    
    
    if (([d1 objectForKey:@"shenfenzflag"]!=nil && [[d1 objectForKey:@"shenfenzflag"] intValue]==1)|| zjz11.length>0) {
        
        [self.shenfen setImage:[UIImage imageNamed:@"ziliao01_03.png"] forState:UIControlStateNormal];
    }
    
    
    if (([d1 objectForKey:@"shenfenfflag"]!=nil && [[d1 objectForKey:@"shenfenfflag"] intValue]==1)||zjz22.length>0) {
        
        [self.shenfenFanMian setImage:[UIImage imageNamed:@"ziliao01_03.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    if (([d1 objectForKey:@"benrenzflag"]!=nil && [[d1 objectForKey:@"benrenzflag"] intValue]==1)||zjz33.length>0) {
        
        [self.benren setImage:[UIImage imageNamed:@"ziliao01_09.png"] forState:UIControlStateNormal];
    }
    
    
    if (([d1 objectForKey:@"xueshengzflag"]!=nil && [[d1 objectForKey:@"xueshengzflag"] intValue]==1)||zjz44.length>0) {
        
        [self.xuesheng setImage:[UIImage imageNamed:@"ziliao01_05.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    
    
}
- (IBAction)btn:(UIButton *)sender {
    //    上传
    //    上传
    NSThread*thread=[[NSThread alloc] initWithTarget:self selector:@selector(xiancheng) object:nil];
    [thread start];
    NSThread*thread1=[[NSThread alloc]initWithTarget:self selector:@selector(xianchengs) object:nil];
    [thread1 start];
   
    

}
-(void)xiancheng{
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    HUD.labelText = @"正在上传...";
    
    HUD.margin = 10.f;
    HUD.removeFromSuperViewOnHide=YES;
}
-(void)xianchengs{
    NSUserDefaults *d1=[NSUserDefaults standardUserDefaults];
    
    NSString *zjz11=[d1 objectForKey:@"zjz1"];
    NSString *zjz22=[d1 objectForKey:@"zjz2"];
    NSString *zjz33=[d1 objectForKey:@"zjz3"];
    NSString *zjz44=[d1 objectForKey:@"zjz4"];
    
    if (([[d1 objectForKey:@"shenfenzflag"] intValue]==1 && [d1 objectForKey:@"shenfenfflag"]!=nil && [d1 objectForKey:@"benrenzflag"]!=nil && [[d1 objectForKey:@"xueshengzflag"] intValue]==1) || (zjz11.length>0 && zjz22.length>0 && zjz33.length>0 && zjz44.length>0)) {
       
       
        
        
        //转换URL格式；
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@androidLogAction!wszlsc.action", networkAddress ]];
        //创建请求对象；
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //请求方式；
        request.HTTPMethod = @"POST";
        // 设置请求头信息-数据类型
        [request setValue:@"multipart/form-data; boundary=---------------------------7da213758061" forHTTPHeaderField:@"Content-Type"];
        
        // 拼接请求体,用来保存上传数据流；
        NSMutableData *data = [NSMutableData data];
        
        
        // 普通参数-hyid
        // 普通参数开始的一个标记
        [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 参数描述
        [data appendData:[@"Content-Disposition:form-data; name=\"id\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 参数值
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        //    NSLog(@"%@",[defaults objectForKey:@"id"]);
        
        NSString *str_hy = [NSString stringWithFormat:@"\r\n%@\r\n",[defaults objectForKey:@"id"]];
        [data appendData:[str_hy dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 文件参数-zjz1
        // 文件参数开始的一个标记
        [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件参数描述
        [data appendData:[@"Content-Disposition:form-data; name=\"zjz1\"; filename=\"image1.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件的MINETYPE
        [data appendData:[@"Content-Type:image/jpg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件内容
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //图片对象；
        
        NSString *filePath = [NSString stringWithFormat:@"%@/Documents/image1.jpg",NSHomeDirectory()];
        
        UIImage *image = [UIImage imageNamed:filePath];
        
        NSData *zjz1 = UIImageJPEGRepresentation(image, 0.5);
        
        [data appendData:zjz1];
        
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        // 文件参数-zjz2
        // 文件参数开始的一个标记
        [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件参数描述
        [data appendData:[@"Content-Disposition:form-data; name=\"zjz2\"; filename=\"image2.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件的MINETYPE
        [data appendData:[@"Content-Type:image/jpg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件内容
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //图片对象；
        
        NSString *filePath2 = [NSString stringWithFormat:@"%@/Documents/image2.jpg",NSHomeDirectory()];
        
        UIImage *image2 = [UIImage imageNamed:filePath2];
        
        NSData *zjz2 = UIImageJPEGRepresentation(image2, 0.5);
        
        [data appendData:zjz2];
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 文件参数-zjz3
        // 文件参数开始的一个标记
        [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件参数描述
        [data appendData:[@"Content-Disposition:form-data; name=\"zjz3\"; filename=\"image3.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件的MINETYPE
        [data appendData:[@"Content-Type:image/jpg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件内容
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //图片对象；
        NSString *filePath3 = [NSString stringWithFormat:@"%@/Documents/image3.jpg",NSHomeDirectory()];
        
        UIImage *image3 = [UIImage imageNamed:filePath3];
        
        NSData *zjz3 = UIImageJPEGRepresentation(image3, 0.5);
        
        [data appendData:zjz3];
        
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        
        // 文件参数-zjz4
        // 文件参数开始的一个标记
        [data appendData:[@"-----------------------------7da213758061\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件参数描述
        [data appendData:[@"Content-Disposition:form-data; name=\"zjz4\"; filename=\"image4.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件的MINETYPE
        [data appendData:[@"Content-Type:image/jpg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        // 文件内容
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //图片对象；
        NSString *filePath4 = [NSString stringWithFormat:@"%@/Documents/image4.jpg",NSHomeDirectory()];
        
        UIImage *image4 = [UIImage imageNamed:filePath4];
        
        NSData *zjz4 = UIImageJPEGRepresentation(image4, 0.5);
        
        [data appendData:zjz4];
        
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        // 参数结束的标识
        [data appendData:[@"-----------------------------7da2137580612--" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        
        [request setHTTPMethod:@"POST"];//定义方法为post.所以如果在PHP端接收的话，以$_POST["user"],$_POST["password"]结收数据
        [request setHTTPBody:data];//将内容加载到请求中
        
        NSData *respondse=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//创建连接
        NSString * myGet=[[NSString alloc] initWithData:respondse encoding:NSUTF8StringEncoding];//jsonstring接收数据
        [HUD hide:YES];
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"上传成功";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        //jsonstring转dictionary;
        
        
        //   [self.delegate hid2];
        NSData*ddt=[myGet dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary*ddd=[NSJSONSerialization JSONObjectWithData:ddt options:kNilOptions error:nil];
        NSLog(@"shoudaode -------%@",ddd);
        [d1 setObject:[[ddd objectForKey:@"hyxx"] objectForKey:@"zjz1"] forKey:@"zjz1"];
        [d1 setObject:[[ddd objectForKey:@"hyxx" ] objectForKey:@"zjz2"] forKey:@"zjz2"];
        [d1 setObject:[[ddd objectForKey:@"hyxx" ] objectForKey:@"zjz3"] forKey:@"zjz3"];
        [d1 setObject:[[ddd objectForKey:@"hyxx" ] objectForKey:@"zjz4"] forKey:@"zjz4"];
        NSLog(@"%@\n%@\n%@\n%@\n",[d1 objectForKey:@"zjz1"],[d1 objectForKey:@"zjz2"],[d1 objectForKey:@"zjz3"],[d1 objectForKey:@"zjz4"]);
      
        
        
        [HUD hide:YES];
        [self.navigationController
         popViewControllerAnimated:YES];
        
    }
    
    else
    {[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        //        提示
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"材料不足,请重新上传!";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
    }
    
    
    
}

-(void)tu1{
    a=10;
    [self.shenfen setImage:[UIImage imageNamed:@"ziliao01_03.png"] forState:UIControlStateNormal];
    
}
-(void)tu2{
    b=10;
    [self.xuesheng setImage:[UIImage imageNamed:@"ziliao01_05.png"] forState:UIControlStateNormal];
    
    
}
-(void)tu3{
    c=10;
    [self.benren setImage:[UIImage imageNamed:@"ziliao01_09.png"] forState:UIControlStateNormal];
    
}
-(void)tu4{
    d=10;
    [self.shenfenFanMian setImage:[UIImage imageNamed:@"ziliao01_03.png"] forState:UIControlStateNormal];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
