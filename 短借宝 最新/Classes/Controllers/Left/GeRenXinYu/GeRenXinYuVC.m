//
//  GeRenXinYuVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/29.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "GeRenXinYuVC.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#import "Header.h"

@interface GeRenXinYuVC ()
@property (strong, nonatomic) UILabel *JiFen_label;
@property (copy ,nonatomic) NSString *b;


@end

@implementation GeRenXinYuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self KuangJia];
    
}
-(void)KuangJia
{
    self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    UIView *view_Kuang=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width, self.view.frame.size.height/5)];
    view_Kuang.backgroundColor=[UIColor colorWithRed:0/255.0 green:204/255.0 blue:176/255.0 alpha:1];
    
    
    UIView *JiFen=[[UIView alloc]initWithFrame:CGRectMake(view_Kuang.frame.origin.x+10, view_Kuang.frame.origin.y+10, view_Kuang.frame.size.width-20, view_Kuang.frame.size.height-20)];
    JiFen.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    JiFen.layer.cornerRadius=8;
    JiFen.layer.masksToBounds = YES;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x+5, JiFen.frame.origin.y+5, JiFen.frame.size.width, 15)];
    label.text=@"当前信誉值";
    label.font=[UIFont fontWithName:@"Heiti SC" size:13];
    [JiFen addSubview:label];
    
    _JiFen_label=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x , CGRectGetMaxY(label.frame)+17, JiFen.frame.size.width, 30)];

    _JiFen_label.textColor=[UIColor colorWithRed:247/255.0 green:104/255.0 blue:0/255.0 alpha:1];
    [self labelTextF];
    [self WangLuoJieShou];
    
    
    //网络
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidIndexAction!queryxytx.action",networkAddress];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"url--%@",url2);
    
    [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"xinxigern--%@",responseObject);
        
        UILabel *XinYongYiJiA=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(view_Kuang.frame)+20, self.view.frame.size.width, 15)];
        NSString *a=[NSString stringWithFormat:@"%@:%@",@"信用一级",[responseObject objectForKey:@"xyyj"]];
        XinYongYiJiA.text=a;
        XinYongYiJiA.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:XinYongYiJiA];
        
        UILabel *XinYongErJiB=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(XinYongYiJiA.frame)+20, self.view.frame.size.width, 15)];
        NSString *b=[NSString stringWithFormat:@"%@:%@",@"信用二级",[responseObject objectForKey:@"xyej"]];
        XinYongErJiB.text=b;
        XinYongErJiB.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:XinYongErJiB];
        
        UILabel *XinYongSanJiC=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(XinYongErJiB.frame)+20, self.view.frame.size.width, 15)];
        NSString *c=[NSString stringWithFormat:@"%@:%@",@"信用三级",[responseObject objectForKey:@"xysaj"]];
        XinYongSanJiC.text=c;
        XinYongSanJiC.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:XinYongSanJiC];

        UILabel *XinYongSiJiD=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(XinYongSanJiC.frame)+20, self.view.frame.size.width, 15)];
        NSString *d=[NSString stringWithFormat:@"%@:%@",@"信用四级",[responseObject objectForKey:@"xysij"]];
        XinYongSiJiD.text=d;
        XinYongSiJiD.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:XinYongSiJiD];
        
        UILabel *XinYongWuJiF=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(XinYongSiJiD.frame)+20, self.view.frame.size.width, 15)];
        NSString *f=[NSString stringWithFormat:@"%@:%@",@"信用五级",[responseObject objectForKey:@"xywj"]];
        XinYongWuJiF.text=f;
        XinYongWuJiF.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:XinYongWuJiF];
        
        UILabel *HuanKuanJinE=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(XinYongWuJiF.frame)+20, self.view.frame.size.width, 15)];
        NSString *e=[NSString stringWithFormat:@"%@:%@元/信用值",@"正常还款金额信用比",[responseObject objectForKey:@"hkxyb"]];
        HuanKuanJinE.text=e;
        HuanKuanJinE.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:HuanKuanJinE];
        
        UILabel *WeiYueXinYongBiF=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x, CGRectGetMaxY(HuanKuanJinE.frame)+20, self.view.frame.size.width, 15)];
        NSString *z=[NSString stringWithFormat:@"%@:%@元/信用值",@"违约扣款信用比",[responseObject objectForKey:@"wyxyb"]];
        WeiYueXinYongBiF.text=z;
        WeiYueXinYongBiF.font=[UIFont fontWithName:@"Heiti SC" size:15];
        [self.view addSubview:WeiYueXinYongBiF];


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    [JiFen addSubview:_JiFen_label];
    
    [view_Kuang addSubview:JiFen];

    [self.view addSubview:view_Kuang];
    
}
-(void)WangLuoJieShou
{
 
}
-(void)labelTextF
{
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([defaults3 objectForKey:@"HuiYuanChengXinZhi"]==nil) {
        _b=@"0";
        
    }else{
        _b=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"HuiYuanChengXinZhi"]];
    
    }
    NSString *a=[NSString stringWithFormat:@"%@%@",_b,@"分"];
    //创建 NSMutableAttributedString
    NSMutableAttributedString *attribuedstr1=[[NSMutableAttributedString alloc]initWithString:a];
    
    //给所有字符设置字体为Zapfino，字体高度为15像素
    [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"Heiti SC" size: 29.0] range: NSMakeRange(0, a.length-1)];
    
    //    //分段控制，第5个字符开始的3个字符，即第5、6、7字符设置为红色
    //    [attribuedstr1 addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(4, 3)];
    //赋值给显示控件label01的 attributedText
    _JiFen_label.attributedText = attribuedstr1;

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
