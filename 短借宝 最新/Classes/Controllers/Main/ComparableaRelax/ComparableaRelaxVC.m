//
//  ComparableaRelaxVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/26.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "ComparableaRelaxVC.h"

@interface ComparableaRelaxVC (){
    
    float width,heig;
}
@property (strong, nonatomic)  UILabel *labelText;

@end

@implementation ComparableaRelaxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    // Do any additional setup after loading the view.
    
    _chuangye=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    
    _chuangye.contentSize=CGSizeMake(320, 1470);
    
    [self.view addSubview:_chuangye];
    
    _labelText=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, width, 37)];
    
    _labelText.textColor=[UIColor blackColor];
    
    _labelText.text=@"创业改变命运，成就青春梦想";
    
    _labelText.textAlignment=NSTextAlignmentCenter;
    _labelText.font=[UIFont systemFontOfSize:20.0f];
    
    [_chuangye addSubview:_labelText];
    
    [self labelTextF];
    
    UILabel *ll1=[[UILabel alloc] initWithFrame:CGRectMake(16, 52, width-32, 20)];
    
    ll1.font=[UIFont systemFontOfSize:14.0f];
    ll1.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll1.text=@"     2014年我国高、校毕业生高达727万人，大学生就业的难度不断提高，创业还是择业成为了很多毕业生面临的一个难题。随着高效毕业生的逐年增加，就业压力逐渐增大，刚刚步入大学校门的学生也逐渐感受到就业的压力。面对这样的困境，身为大学生的你还要坐以待毙吗？还要等到毕业时到处碰壁却难以找到合适的工作吗？还要浪费青春将梦想埋葬在内心深处吗？\n      怀揣梦想的你一定想让梦想变成现实，创业便是改变命运的最好途径，从而成就你的职场梦想。可是大学生创业还面临个巨大的现实问题，资金问题。同学，当你看到这里的时候，资金已经不是问题，只要你有创业的想法，有创业项目，黑龙江短借金融服务外包有限公司可以提供资金支持，携手共创美好未来！";
    ll1.numberOfLines=0;
    [ll1 sizeToFit];
    
    [_chuangye addSubview:ll1];
    
    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(ll1.frame)+10, width-80, 219)];
    img1.image=[UIImage imageNamed:@"sss"];
    
    [_chuangye addSubview:img1];
    
    UILabel *ll2=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(img1.frame)+10, width-32, 20)];
    
    ll2.font=[UIFont systemFontOfSize:14.0f];
    
    ll2.text=@"     同学，还在等什么，还不快点申请加入我们创业的资金扶持项目，成就你的创业梦想！";
    ll2.textColor=[UIColor redColor];
    ll2.numberOfLines=0;
    [ll2 sizeToFit];
    
    [_chuangye addSubview:ll2];
    
    UILabel *ll3=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(ll2.frame)+10, width-32, 20)];
    
    ll3.font=[UIFont systemFontOfSize:17.0f];
    ll3.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll3.textAlignment=NSTextAlignmentCenter;
    ll3.text=@"创业资金扶持项目";
    
    [_chuangye addSubview:ll3];
    

        
        UILabel *llm=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(ll3.frame)+10, width-32, 20)];
    
    
     if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        llm.font=[UIFont systemFontOfSize:17 weight:2];
    else
        llm.font=[UIFont systemFontOfSize:17];
    
        llm.textColor=[UIColor blackColor];
      
        llm.text=@"项目背景：";
        
        [_chuangye addSubview:llm];
    
    UILabel *lln=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(llm.frame)+10, width-32, 20)];
    
    lln.font=[UIFont systemFontOfSize:14];
    lln.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    lln.text=@"2015年全国高校毕业生达到749万居多，大学生就业形势日渐严峻，创业将成为大学生就业的主流。黑龙江短借金融服务外包有限公司致力于为大学生提供金融服务，助你一“币”之力。让大学生的创业梦想得以实现。";
    lln.numberOfLines=0;
    [lln sizeToFit];
    
    [_chuangye addSubview:lln];


    UILabel *llm1=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lln.frame)+10, width-32, 20)];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        llm1.font=[UIFont systemFontOfSize:17 weight:2];
    else
        llm1.font=[UIFont systemFontOfSize:17];
    
    llm1.textColor=[UIColor blackColor];
    
    llm1.text=@"对象：";
    
    [_chuangye addSubview:llm1];
    
    UILabel *lln1=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(llm1.frame)+10, width-32, 20)];
    
    lln1.font=[UIFont systemFontOfSize:14];
    lln1.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    lln1.text=@"在校大学生或应届毕业生";
    
    [_chuangye addSubview:lln1];
    
    UILabel *llm2=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lln1.frame)+10, width-32, 20)];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        llm2.font=[UIFont systemFontOfSize:17 weight:2];
    else
        llm2.font=[UIFont systemFontOfSize:17];
    llm2.textColor=[UIColor blackColor];
    
    llm2.text=@"内容：";
    
    [_chuangye addSubview:llm2];
    
    UILabel *lln2=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(llm2.frame)+10, width-32, 20)];
    
    lln2.font=[UIFont systemFontOfSize:14];
     lln2.text=@"在线提交项目相关资料，我们会尽快与你取得联系，洽谈项目的具体问题。（详见扶持资金申请书）";
    lln2.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    lln2.numberOfLines=0;
    [lln2 sizeToFit];
    
    [_chuangye addSubview:lln2];
    
    
    UILabel *llm3=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lln2.frame)+10, width-32, 20)];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        llm3.font=[UIFont systemFontOfSize:17 weight:2];
    else
        llm3.font=[UIFont systemFontOfSize:17];
    llm3.textColor=[UIColor blackColor];
    
    llm3.text=@"特别声明：";
    
    [_chuangye addSubview:llm3];
    
    UILabel *lln3=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(llm3.frame)+10, width-32, 20)];
    
    lln3.font=[UIFont systemFontOfSize:14];
    lln3.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    lln3.text=@"本项目计划书内容涉及商业秘密，仅做项目扶持资金使用。";
    lln3.numberOfLines=0;
    [lln3 sizeToFit];
    [_chuangye addSubview:lln3];


    UILabel *ll31=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lln3.frame)+10, width-32, 20)];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        ll31.font=[UIFont systemFontOfSize:17 weight:2];
    else
        ll31.font=[UIFont systemFontOfSize:17];
    ll31.textColor=[UIColor blackColor ];
    ll31.textAlignment=NSTextAlignmentCenter;
    ll31.text=@"扶持资金申请书";
    
    [_chuangye addSubview:ll31];
    
    
    
    UILabel *lln4=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(ll31.frame)+10, width-32, 20)];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        lln4.font=[UIFont systemFontOfSize:14 weight:2];
    else
        lln4.font=[UIFont systemFontOfSize:14];
    lln4.textColor=[UIColor blackColor];
    
    lln4.text=@"注意：需要创业扶持资金的大学生需将以上内容用附件的形式发送到公司邮箱。djjrfw@aliyun.com  以便项目审核。您将会在1-2个工作日收到扶持资金项目组给与的答复。";
    lln4.numberOfLines=0;
    [lln4 sizeToFit];
    [_chuangye addSubview:lln4];

    
    UIImageView *img2=[[UIImageView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lln4.frame)+10, width-80, 219)];
    img2.image=[UIImage imageNamed:@"aaaa"];
    
    [_chuangye addSubview:img2];
}
-(void)labelTextF
{
    NSString *a=@"创业改变命运，成就青春梦想";
    
    //创建 NSMutableAttributedString
    NSMutableAttributedString *attribuedstr1=[[NSMutableAttributedString alloc]initWithString:a];
    //添加属性
    
    //给所有字符设置字体为Zapfino，字体高度为15像素
    [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName: @"Heiti SC" size: 30] range: NSMakeRange(0, 2)];
    
    
    //分段控制，最开始4个字符颜色设置成蓝色
    [attribuedstr1 addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, 2)];
    
    
    
    //分段控制，第5个字符开始的3个字符，即第5、6、7字符设置为红色
    
    [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName: @"Heiti SC" size: 30] range: NSMakeRange(11, 2)];
    
    [attribuedstr1 addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1.0f] range: NSMakeRange(11, 2)];
    
    //赋值给显示控件label01的 attributedText
    _labelText.attributedText = attribuedstr1;

    


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
