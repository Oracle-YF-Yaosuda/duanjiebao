//
//  LoanComprehendViewControllers.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/7.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LoanComprehendViewControllers.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "LeftAtPresentBorrowMoneyVC.h"

#import "JieKuanXieYiViewController.h"

#import "Header.h"

@interface LoanComprehendViewControllers ()
{
    MBProgressHUD *HUD;
    
    float width,heig;
    
    UIView *bot;
    
    UIButton *top;
    int m;
}
@end
@implementation LoanComprehendViewControllers
- (void)viewDidLoad
{
    m=0;
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;

    UIScrollView *scl;
    
    scl=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    
    
    if (width==414) {
        scl=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, width, heig-64)];
    }
    
    scl.contentSize=CGSizeMake(width, 2440);
    
    [self.view addSubview:scl];
    
    
    UILabel *labelText=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, width, 30)];
    
    labelText.textColor=[UIColor darkGrayColor];
    
    labelText.text=@"一：使用须知";
    
    labelText.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText];
 
    
    UILabel *ll1=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, width-20, 20)];
    
    ll1.font=[UIFont systemFontOfSize:14.0f];
    ll1.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll1.text=@"1、 短借宝只接受持有中国有效身份证明的18周岁以上具有完全民事行为能力的自然人，且同时为全日制高校在校生成为用户。如您不符合资格，请勿注册，否则短借宝有权随时中止或终止您的用户资格。\n2、短借宝是一个真正实现纯线上申请、审批、放款的互联网借款平台。用户在注册成功并提交必要信息后，即可获得线上的借款。到期只需将应还款转入还款账户，即可完成还款。操作便捷、迅速，安全可靠。\n3、用户在使用短借宝之前，必须在短借宝完成注册，用户按照提示，填写用户名、身份证，所属院校、密码、实名登记的手机号码即可完成注册，成为短借宝用户。用户须填写准确的联系方式，尤其是手机号码，以便及时接收动态验证密码，享受后续服务。\n4、用户要确保个人资料信息的真实性、完整性和有效性，并承诺对个人资料信息及时进行更新。若因用户未提供有效联系方式，导致本公司未能提供或错误提供服务，造成的损失及法律后果，由用户自行承担。\n5、使用过程中，若用户出现逾期还款时，短借宝会根据规定征收逾期违约金和逾期罚金。";
    ll1.numberOfLines=0;
    [ll1 sizeToFit];
    
    [scl addSubview:ll1];
    
    UILabel *labelText1=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll1.frame)+10, width, 30)];
    
    labelText1.textColor=[UIColor darkGrayColor];
    
    labelText1.text=@"二：服务须知";
    
    labelText1.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText1];
    
    
    UILabel *ll2=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText1.frame)+10, width-20, 20)];
    
    ll2.font=[UIFont systemFontOfSize:14.0f];
    ll2.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll2.text=@"1、短借宝为用户提供的服务包括但不限于：受理用户的借款申请、进行交易管理、还款提醒等。具体内容以短借宝当前版本实际提供的服务内容为准。\n2、短借宝受理用户的借款申请。由于服务需要用户完成身份认证才能享用。若因用户未完成身份认证而无法享受服务的，短借宝不承担任何责任。\n3、短借宝为用户提供交易管理服务，包括借款资金的发放，还款资金及手续费、服务费等必要费用的扣划。用户使用短借宝，即视为用户同意短借宝进行借款的扣放款服务，短借宝应及时将扣放款的情况以短信、页面展现等形式告知用户。\n4、短借宝有权根据需要不时地修改本须知正文各条款或制定、修改各短借宝规则并在短借宝相关系统板块发布，无需另行单独通知。若您在本须知知正文相关条款和/或短借宝规则内容公告变更后继续使用短借宝网站及/或短借宝APP服务的，表示您已充分阅读、理解并接受修改后的内容，也将遵循修改后的本须知正文条款和/或短借宝规则使用短借宝的服务。\n5、 您通过自行或授权有关方根据本须知及短借宝有关规则、说明操作确认本须知后，本须知即在您和短借宝之间产生法律效力。您在此同意将全面接受和履行与短借宝其他用户在短借宝签订的任何电子法律文本，并承诺按该等法律文本享有和/或放弃相应的权利、承担和/或豁免相应的义务。";
    ll2.numberOfLines=0;
    [ll2 sizeToFit];
    
    [scl addSubview:ll2];
    
    UILabel *labelText2=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll2.frame)+10, width, 30)];
    
    labelText2.textColor=[UIColor darkGrayColor];
    
    labelText2.text=@"三：风险提示";
    
    labelText2.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText2];
    
    
    UILabel *ll3=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText2.frame)+10, width-20, 20)];
    
    ll3.font=[UIFont systemFontOfSize:14.0f];
    ll3.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll3.text=@"1、短借宝用户了解并认可，任何通过短借宝进行的交易并不能完全避免风险，短借宝不承诺对如下风险造成的用户损失负责，具体包括：\n    1）、因用户本人过错导致的身份盗用（包括泄露密码、密码被他人破解、手机丢失或被盗等）、操作不当、遗忘密码等造成的损失；\n    2）、相关监管部门的政策、法律、法规的调整，导致短借宝不能开展正常业务导致用户的损失；\n    3）、因自然灾害、黑客攻击、系统故障等不可抗力导致服务中断的风险。";
    ll3.numberOfLines=0;
    [ll3 sizeToFit];
    
    [scl addSubview:ll3];
    
    UILabel *labelText3=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll3.frame)+10, width, 30)];
    
    labelText3.textColor=[UIColor darkGrayColor];
    
    labelText3.text=@"四：账户安全";
    
    labelText3.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText3];
    
    
    UILabel *ll4=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText3.frame)+10, width-20, 20)];
    
    ll4.font=[UIFont systemFontOfSize:14.0f];
    ll4.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll4.text=@"1、短借宝用户了解并同意，账号和密码是短借宝判断用户身份的主要依据。用户有责任保管好本人的账号密码，不得向其他人泄露账户或密码，并不可使用其他人的账号或密码。\n2、短借宝通过用户账号及密码来识别用户的指令，用户同意，使用本人账户和密码登录后在短借宝上的一切行为均代表其本人，并由短借宝用户本人承担由此产生的全部责任。\n3、冒用他人账号及密码的，短借宝及其授权主体保留追究实际使用人连带责任的权利。\n4、用户发现其账号被冒用或盗用，或是存在泄漏嫌疑的，应当及时通过正规途径通知短借宝客服修改密码或注销账号。通知之日前的用户账户的行为均代表用户的本人行为，由用户本人承担全部责任。由于短借宝未能相应用户请求导致的进一步损失，由短借宝承担。";
    ll4.numberOfLines=0;
    [ll4 sizeToFit];
    
    [scl addSubview:ll4];
    
    UILabel *labelText4=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll4.frame)+10, width, 30)];
    
    labelText4.textColor=[UIColor darkGrayColor];
    
    labelText4.text=@"五：用户义务";
    
    labelText4.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText4];
    
    
    UILabel *ll5=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText4.frame)+10, width-20, 20)];
    
    ll5.font=[UIFont systemFontOfSize:14.0f];
    ll5.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll5.text=@"1、遵守短借宝用户注册协议条款的约定；\n2、不得损害其他短借宝用户的权利；\n3、不得利用短借宝进行违反国家法律法规规定的行为；";
    ll5.numberOfLines=0;
    [ll5 sizeToFit];
    
    [scl addSubview:ll5];
    
    UILabel *labelText5=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll5.frame)+10, width, 30)];
    
    labelText5.textColor=[UIColor darkGrayColor];
    
    labelText5.text=@"六：用户隐私保护";
    
    labelText5.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText5];
    
    
    UILabel *ll6=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText5.frame)+10, width-20, 20)];
    
    ll6.font=[UIFont systemFontOfSize:14.0f];
    ll6.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll6.text=@"1、用户同意，短借宝可从公开或第三方合作机构中收集用户的额外信息，以更好地掌握用户的实际情况，为用户提供更优质的服务。\n2、短借宝对于用户提供的、授权短借宝采集的、短借宝从其他渠道自行收集的及其他方式获取的用户个人信息，享有基于履行协议、提供服务、解决争议、保障交易安全等目的使用用户个人信息资料的权利。\n3、短借宝有义务根据有关法律要求向司法机关和政府部门提供用户的个人资料。\n4、若用户未能按照其与短借宝签订的协议履行应尽义务，短借宝有权披露用户个人信息及违约事实。由此给用户造成的任何损失，短借宝不承担法律责任。";
    ll6.numberOfLines=0;
    [ll6 sizeToFit];
    
    [scl addSubview:ll6];


    UILabel *labelText6=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll6.frame)+10, width, 30)];
    
    labelText6.textColor=[UIColor darkGrayColor];
    
    labelText6.text=@"七：知识产权保护";
    
    labelText6.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText6];
    
    
    UILabel *ll7=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText6.frame)+10, width-20, 20)];
    
    ll7.font=[UIFont systemFontOfSize:14.0f];
    ll7.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll7.text=@"1、短借宝上所有内容，包括文本、图片、数据、页面设计、平台架构等，均由短借宝及其权利人依法拥有的知识产权。\n2、未经短借宝及其权利人同意，任何人不得擅自复制、修改、使用或公开发布短借宝的程序或内容。\n3、尊重知识产权是用户应尽的义务，如有违反，短借宝保留一切追究权利。";
    ll7.numberOfLines=0;
    [ll7 sizeToFit];
    
    [scl addSubview:ll7];

    UILabel *labelText7=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(ll7.frame)+10, width, 30)];
    
    labelText7.textColor=[UIColor darkGrayColor];
    
    labelText7.text=@"八：法律适用说明";
    
    labelText7.font=[UIFont systemFontOfSize:17.0f];
    
    [scl addSubview:labelText7];
    
    
    UILabel *ll8=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(labelText7.frame)+10, width-20, 20)];
    
    ll8.font=[UIFont systemFontOfSize:14.0f];
    ll8.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll8.text=@"1、本须知自用户在短借宝注册之日起生效，其效力、解释、履行、争议的解决均适用于中华人民共和国法律。\n2、因本文所引起的任何纠纷及争议，应先友好协商解决，协商不成的，可将纠纷或争议提交合同签订地的人民法院诉讼解决。\n对于以上借款须知，请您务必认真阅知，已充分考虑违约失信的风险和成本。本借款须知拥有最终的解释权。本应用有关页面的相关名词可互相引用参照，如有不同理解，则以本须知条款为准。此外，若本须知的部分条款被认定为无效或者无法实施时，本须知中的其他条款仍然有效。";
    ll8.numberOfLines=0;
    [ll8 sizeToFit];
    
    [scl addSubview:ll8];
    
    
    bot=[[UIView alloc] initWithFrame:CGRectMake(0, heig-80, width, 80)];
    bot.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0f];
    top=[[UIButton alloc] initWithFrame:CGRectMake(20, 5, width-40, 30)];
    [top setTitle:@"我同意以上借款须知" forState:UIControlStateNormal];

    [top setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    top.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [top setImage:[UIImage imageNamed:@"denglu_18.png"] forState:UIControlStateNormal];
    top.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    
    [top addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    
    [bot addSubview:top];
    

    UIButton *butong=[[UIButton alloc] initWithFrame:CGRectMake((width/2-100)/2, 40, 100, 30)];
    
    [butong setTitle:@"不同意" forState:UIControlStateNormal];
    [butong setTitleColor:[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1] forState:UIControlStateNormal];
    butong.titleLabel.font=[UIFont systemFontOfSize:14];
    
    butong.backgroundColor=[UIColor whiteColor];
    [butong.layer setBorderWidth:1.0f];
    [butong.layer setBorderColor:[[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1] CGColor]];
    [butong.layer setCornerRadius:5];
    
    [butong addTarget:self action:@selector(NoLoan:) forControlEvents:UIControlEventTouchUpInside];
    
    [bot addSubview:butong];
    
    
    UIButton *tong=[[UIButton alloc] initWithFrame:CGRectMake(width/2+(width/2-100)/2, 40, 100, 30)];
    
    [tong setTitle:@"同意" forState:UIControlStateNormal];
    [tong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tong.titleLabel.font=[UIFont systemFontOfSize:14];
    
    tong.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:176.0/255 alpha:1];
    [tong.layer setCornerRadius:5];
    
    [tong addTarget:self action:@selector(YesLoan:) forControlEvents:UIControlEventTouchUpInside];
    
    [bot addSubview:tong];
    
    [self.view addSubview:bot];
}

-(void)agree:(UIButton*)asd{
    
    if (m==0) {
        
        [asd setImage:[UIImage imageNamed:@"denglu_15.png"] forState:UIControlStateNormal];
        m=1;
    }
    else{
        [asd setImage:[UIImage imageNamed:@"denglu_18.png"] forState:UIControlStateNormal];
        m=0;
        
    }
    
}

//同意协议
- (void)YesLoan:(UIButton *)sender
{
    if (m==1)
   
    {
        
        JieKuanXieYiViewController *lcVC = [[JieKuanXieYiViewController alloc] init];
        [self.navigationController pushViewController:lcVC animated:YES];
        
    }
    
    else{
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"请勾选同意以上借款须知";
        
        HUD.yOffset=100;
        
        [HUD show:YES];
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
        
    }
    
}

-(void)TiJiaoDingDan
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@androidIndexAction!hyjksq.action",networkAddress]]];
    [request setTimeoutInterval:20.0f];//
    [request setHTTPMethod:@"POST"];//POSt请求
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];//Form请求（重要）
    
    NSMutableData *postBody=[NSMutableData data];//包体，在请求最前面
    
    // zhid:会员账号id jkje：借款金额,jkqx：借款期限 ,sxf：借款手续费
    // skrxm：收款人姓名, skyhkh：收款银行卡号 ,skyh：收款银行 ,jklx：借款类型
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    NSLog(@"zhid=%@&jkje=%@&jkqx=%@&sxf=%@&skrxm=%@&skyhkh=%@&skyh=%@&jklx=%@&khhmc=%@",[defaults3 objectForKey:@"zhid"],[defaults3 objectForKey:@"JinE"],[defaults3 objectForKey:@"QiXian"],[defaults3 objectForKey:@"FeiLu"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],[defaults3 objectForKey:@"bank"],[defaults3 objectForKey:@"DaiKuanLeiXing"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"]);
    
    [postBody appendData:[[NSString stringWithFormat:@"zhid=%@&jkje=%@&jkqx=%@&sxf=%@&skrxm=%@&skyhkh=%@&skyh=%@&jklx=%@&khhmc=%@",[defaults3 objectForKey:@"zhid"],[defaults3 objectForKey:@"JinE"],[defaults3 objectForKey:@"QiXian"],[defaults3 objectForKey:@"FeiLu"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],[defaults3 objectForKey:@"bank"],[defaults3 objectForKey:@"DaiKuanLeiXing"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"]] dataUsingEncoding:NSUTF8StringEncoding]];//把要传送的键值对封装成UTF8，转换成包体（重要）
    
    
    [request setHTTPBody:postBody];//把包体给请求路径
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];//AF把request封装成一种格式
    
    
    
    //把AF请求解析成Json格式
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        NSLog(@"operation hasAcceptableStatusCode: %@", responseObject);
        
        //返回成功的值
//        NSLog(@"Success: %@", operation.responseString);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",[resultDic objectForKey:@"flag"]);
        [defaults3 setObject:[resultDic objectForKey:@"flag"] forKey:@"DaiKuanShiFouKeYi"];
        [defaults3 setObject:[resultDic objectForKey:@"massages"] forKey:@"DaiKuanShuChuXinXi"];
        
        
        
        
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"上传成功";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"请重新上传";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:1];
        
        if (error.code != NSURLErrorTimedOut) {
            NSLog(@"错误: %@", error);
        }
        
    }];
    //运行上面这个请求
    [operation start];
    
    
}
//不同意协议
- (void)NoLoan:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}





- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        LeftAtPresentBorrowMoneyVC *lcVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftAtPresentBorrowMoney"];
        [self.navigationController pushViewController:lcVC animated:YES];
    }
}


@end
