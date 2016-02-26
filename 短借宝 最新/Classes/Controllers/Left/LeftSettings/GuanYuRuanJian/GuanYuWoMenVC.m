//
//  GuanYuWoMenVC.m
//  短借宝
//
//  Created by iMac21 on 15/9/1.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "GuanYuWoMenVC.h"

@interface GuanYuWoMenVC ()
{
    
    float width,heig;
}

@end

@implementation GuanYuWoMenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    self.title=@"企业简介";
    UIScrollView *scl=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(16, 15, width-32, 100)];
    ll.text=@"\t黑龙江短借金融服务外包有限公司（以下简称短借金融）坐落于哈尔滨高新科技创新城金融港，是金融港唯一一家致力于大学生借款，创业资金扶持的金融机构。\n        短借金融本着\"客户满意、员工成长、企业发展、服务社会\"的宗旨，以\"诚信创造财富，创新引领行业\"为经营理念，致力于为有资金需求的大学生及大学生创业所需资金搭建一个专业、稳定、高效的服务平台。\n        大学生创业资金扶持可以让大学生通过创业的形式实现就业，解决了大学生就业难的问题。调查显示，有四成大学生认为，\"资金是创业的最大困难\"，没有资金，再好的创意也难以转换为现实的生产力，因此资金是大学生创业要翻越的一座山。我公司致力于为大学生提供创业资助，可以在很大程度上解决创业资金短缺问题。同时，我们还可以为有创业想法的大学生进行创业培训，专业指导，从而提高创业成功率。\n        我公司拥有一支专业的金融管理团队，不仅为在校大学生提供全面的创业咨询及资金扶持，同时还提供短期借款服务，包括借款方案设计、借款申请、借款相关手续的办理以及还款方式的对比分析，并且将大学生借款的全部利润用以支持大学生创业，完成大学生创业梦想。目前，短借金融针对黑龙江省内的在校大学生，随着需求的增加，公司将在两年内普及全国在校大学生。\n        我们将立足于行业，发展于两端，服务更多客户，全力实践企业的哲学与使命，同时在竞争与发展中不断改造与提高，通过建立学习型组织，追求竞争优势，建立常青企业，整合资源最终回馈广大学子。";
    ll.numberOfLines=0;
    
   
    if (width==414)
    ll.font=[UIFont systemFontOfSize:16.0f];
    else
    ll.font=[UIFont systemFontOfSize:14.0f];
    
    
    ll.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    //
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:ll.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, ll.text.length)];
    
    ll.attributedText = attributedString;
    [ll sizeToFit];
    
    [scl addSubview:ll];
    
    scl.contentSize=CGSizeMake(width, 70+CGRectGetMaxY(ll.frame));
    
    [self.view addSubview:scl];
    
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
