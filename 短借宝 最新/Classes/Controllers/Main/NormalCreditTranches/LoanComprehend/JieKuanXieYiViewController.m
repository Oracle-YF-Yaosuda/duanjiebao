//
//  JieKuanXieYiViewController.m
//  短借宝
//
//  Created by ll on 15/9/30.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "JieKuanXieYiViewController.h"

#import "LeftAtPresentBorrowMoneyVC.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"

#import "Header.h"

#import "LeftRegisterVC.h"

@interface JieKuanXieYiViewController (){
    
    MBProgressHUD *HUD;
    
    float width,heig;
    
    UIView *bot;
    
    UIButton *top;
    int m;
    
    UIView *alertview;
    
    UIView *bai;

}

@end

@implementation JieKuanXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    self.title=@"借款协议";
    
    // Do any additional setup after loading the view.
    m=0;
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    UIScrollView *scl=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    
    scl.contentSize=CGSizeMake(width, 4250);
    
    [self.view addSubview:scl];
    
    
    UILabel *labelText=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, width-20, 30)];
    
    labelText.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    
    //[[df objectForKey:@"JinE"] floatValue]+
    
    float jine=[[df objectForKey:@"FeiLu"] floatValue];
    
    NSString *jiji=[NSString stringWithFormat:@"%f",jine];
    
    NSDate *now=[NSDate date];
    
    NSDateFormatter *form=[[NSDateFormatter alloc] init];
    [form setDateFormat:@"yyyy年MM月dd日"];
    NSString *xianzai=[form stringFromDate:now];
    
    NSTimeInterval tts=[now timeIntervalSince1970];
    
    int tianshu=[[df objectForKey:@"QiXian"] intValue];
    
    NSDate *to=[NSDate dateWithTimeIntervalSince1970:tts+tianshu*24*60*60];
    
    NSString *toshi=[form stringFromDate:to];
    
    
    NSString *qixian=[NSString stringWithFormat:@"自%@至%@止",xianzai,toshi];
    
    NSString *benjin=[NSString stringWithFormat:@"%.2f",[[df objectForKey:@"JinE"] floatValue]];
    
    NSString *benben=[self digitUppercase:benjin];
    
    
    
    labelText.text=[NSString stringWithFormat:@"甲方(出借人)：%@\n\n乙方（借款人）：\n真实姓名：%@\n身份证号：%@\n地   址：%@%@\n电   话：%@\n\n丙方（居间服务方）：黑龙江短借金融服务外包有限公司\n地址：黑龙江省哈尔滨市科技创新城金融港523室\n\n鉴于：丙方是一家在黑龙江省合法法成立并有效存续的有限公司，拥有借款手机应用“短借宝”及微信公共账号：“短借金融” （以下简称“该应用”及“该公众号”）的经营权，提供信用咨询，为交易提供信息服务；乙方已在该应用注册，并承诺其提供给丙方的信息是完全真实的；甲方均已和我方建立合作关系，承诺对本协议涉及的借款资金具有完全的支配能力，是其自有闲散资金，为其合法所得；并承诺其提供给丙方的信息是完全真实的；乙方有借款需求，甲方亦同意借款，双方有意成立借贷关系；各方经协商一致，达成如下协议，共同遵照履行：\n\n第一条 借款基本信息\n借款本金数额：人民币（大写）%@\n借款期限：%@（根据实际放款日期顺延）。\n还款方式：等额本息，按月还款\n成交管理费用：一次性扣除人民币%@元（详见本协议第三条）\n乙方确认：本合同签订时的借款利率为日利率0.06%%，在本合同有效期内如遇法定利率调整或计息方式变更，实行原利率。就本次借款乙方依照以下标准应向甲方支付服务费，每日服务费为2‰。\n\n第二条 各方权利与义务\n甲方的权利和义务甲方保证其所用于出借的资金来源合法，甲方是该资金的合法所有人，如果第三人对资金归属、合法性问题发生争议，由甲方自行解决并承担相关责任。在该等争议解决（以取得生效的判决、裁决或行政命令、通知为标志）之前，丙方有权根据政府机关、司法机关或仲裁机构出具且生效的法律文件拒绝向甲方支付丙方代其领受的相关款项。甲方应按合同约定的借款期限起始日期将足额的借款本金支付给乙方。甲方享有其所出借款项所带来的利息收益。甲方有权要求丙方提供其已获得的乙方信息，丙方应当提供。无须通知乙方，甲方可以根据自己的意愿进行本协议下其对乙方债权的转让。在甲方的债权转让后，乙方需对债权受让人继续履行本协议下其对甲方的还款义务，不得以未接到债权转让通知为由拒绝履行还款义务。甲方应主动缴纳由利息所得带来的可能的税费。如乙方实际还款金额少于本协议约定的本金、利息及违约金的，甲方各出借人同意各自按照其于本协议文首约定的借款比例收取还款。甲方应确保其提供信息和资料的真实性，不得提供虚假信息或隐瞒重要事实。本协议成立之时起，甲方不可撤销地授权丙方在本协议成立的同时将出借款项在扣除相关费用后划转、支付给乙方。甲方同意并授权丙方按本协议及该网站有关规则的约定对出借款项和相关费用进行划扣。\n乙方权利和义务乙方必须按期足额向甲方偿还本金和利息。乙方必须一次性向丙方支付成交综合管理费。乙方必须按期足额向丙方支付借款月管理费用。乙方必须支付与乙方逾期或提前还款有关的费用。(如有）乙方承诺所借款项不用于任何违法用途。乙方应确保其提供的信息和资料的真实性，不得提供虚假信息或隐瞒重要事实。乙方有权了解其在丙方的信用评审进度及结果。乙方不得将本协议项下的任何权利义务转让给任何其他方。乙方确认甲方可以根据自己的意愿对其根据本协议形成的对乙方的部分或全部债权进行转让，并特此同意甲方届时转让债权无需事前通知乙方；在债权转让后，甲方在本协议项下的权利和义务全部自动转移到债权受让人名下，乙方应按照本协议的约定向债权受让人支付每期应还借款本息。\n丙方的权利和义务，丙方有权根据乙方提供的各项信息及丙方独立获得的信息评定乙方在丙方处所拥有的个人信用等级，并根据对乙方个人信息的评审结果，决定是否审核通过并将乙方的借款需求向甲方进行推荐。丙方有权就为本协议借款所提供的服务向乙方收取借款管理费和成交综合管理费及本协议约定的他费用。甲方授权并委托丙方代其收取本协议文首所约定的出借人每月应收本息，代收后按照甲方的要求进行处置，乙方对此表示认可。甲方授权并委托丙方将其支付的出借本金直接划付至乙方账户，乙方对此表示认可。甲乙双方同意丙方有权代甲方在必要时对乙方进行借款的违约提醒及催收工作，包括但不限于电话通知、上门通知、发律师函、对乙方提起诉讼等。甲方在此确认委托丙方为其进行以上工作，并授权丙方可以将此工作委托给其他方进行。乙方对前述委托的提醒、催收事项已明确知晓并应积极配合，同时应承担因乙方逾期还款而产生的催收费用。丙方接受甲乙双方的委托行为所产生的法律后果由相应委托方承担。如因乙方或甲方或其他方（包括但不限于技术问题）造成的延误或错误，丙方不承担任何责任。丙方应对甲方和乙方的信息及本协议内容保密；如任何一方违约，或因相关权力部门要求（包括但不限于法院、仲裁机构、金融监管机构等），丙方有权披露。丙方根据本协议对乙方进行违约提醒及催收工作时，可在其认为必要时进行上门催收提醒，即丙方派出人员（至少2名）至乙方披露的住所地或经常居住地（联系地址）处催收和进行违约提醒，同时向乙方发送催收通知单，乙方应当签收，乙方不签收的，不影响上门催收提醒的进行。丙方采取上门催收提醒的，乙方应当向丙方支付上门提醒费用，收费标准为每次人民币1000.00元，此外，乙方还应向丙方支付进行上门催收提醒服务的差旅费（包括但不限于交通费、食宿费等）。\n\n第三条 借款管理费及成交综合管理费\n在本协议中，“借款管理费”和“成交综合管理费”是指因丙方为乙方提供信息服务、信用咨询、评估、还款提醒、账户管理、还款特殊情况沟通、本金保障等相关服务（统称“平台管理服务”）而由乙方支付给丙方的报酬。对于丙方向乙方提供的一系列平台管理服务，乙方同意在借款成功时向丙方支付本协议第一条约定借款本金成交综合管理费，成交综合管理费将视用户在丙方平台的信用评级结果，扣除本金总额1%-10%不等的费用。该成交综合管理费由乙方授权并委托丙方在丙方根据本协议规定的“丙方的权利和义务”第2款规定向乙方划付出借本金时从本金中予以扣除，即视为乙方已缴纳。在本协议约定的借款期限内，乙方应每日向丙方支付人民币2‰元作为借款管理费用，借款管理费的缴纳时间与本协议第一条约定的还款日一致。\n本条所称的“借款成功时”系指本协议签署日。如乙方和丙方协商一致调整借款管理费和成交综合管理费时，无需经过甲方同意。\n\n第四条 违约责任协议各方均应严格履行合同义务，非经各方协商一致或依照本协议约定，任何一方不得解除本协议。任何一方违约，违约方应承担因违约使得其他各方产生的费用和损失，包括但不限于调查、诉讼费、律师费等，应由违约方承担。如违约方为乙方的，甲方有权立即解除本协议，并要求乙方立即偿还未偿还的包括且不限于本金、利息、滞纳金等费用。此时，乙方还应向丙方支付所有应付的借款管理费。如本协议提前解除时，乙方在该应用的账户里有任何余款的，丙方有权按照本协议第四条第3项的清偿顺序将乙方的余款用于清偿，并要求乙方支付因此产生的相关费用。乙方的每期还款均应按照如下顺序清偿：\n1	根据本协议产生的其他全部费用；\n2	本协议第四条第4款约定的滞纳金；\n3	逾期利息；\n4	逾期本金；\n5	逾期的借款管理费；\n6	届期但未逾期的利息；\n7	届期但未逾期的本金；\n8	届期但未逾期的借款管理费；乙方应严格履行还款义务，如乙方逾期还款，则应按照下述条款向甲方支付逾期滞纳金，自逾期开始之后，逾期本金的正常利息停止计算。预期滞纳金总额 = 逾期本息总额×对应罚息利率(0.50%%)×逾期天数；如果乙方逾期支付任何一期还款超过天，或乙方在逾期后出现逃避、拒绝沟通或拒绝承认欠款事实等恶意行为，本协议项下的全部借款本息及借款管理费均提前到期，乙方应立即清偿本协议下尚未偿付的全部本金、利息、预期滞纳金、借款管理费及根据本协议产生的其他全部费用。如果乙方逾期支付任何一期还款超过7天，或乙方在逾期后出现逃避、拒绝沟通或拒绝承认欠款事实等恶意行为，丙方有权将乙方的“逾期记录”记入人民银行公民征信系统，丙方不承担任何法律责任。如果乙方逾期支付任何一期还款超过7天，或乙方在逾期后出现逃避、拒绝沟通或拒绝承认欠款事实等恶意行为，丙方有权将乙方违约失信的相关信息及乙方其他信息向媒体、用人单位、公安机关、检查机关、法律机关披露，丙方不承担任何责任。在乙方还清全部本金、利息、借款管理费、逾期滞纳金之前，预期滞纳金的计算不停止。本协议中的所有甲方与乙方之间的借款均是相互独立的，一旦乙方逾期未归还借款本息，甲方中的任何一个出借人均有权单独向乙方追索或者提起诉讼。如乙方逾期支付借款管理费或提供虚假信息的，丙方亦可单独向乙方追索或者提起诉讼。\n\n第五条 法律及争议解决\n本协议的签订、履行、终止、解释均适用中华人民共和国法律，并由北京市东城区人民法院管辖。\n\n第六条 附则本协议采用电子文本形式制成，并永久保存在丙方为此设立的专用服务器上备查，各方均认可该形式的协议效力。本协议自文本最终生成之日生效。本协议签订之日起至借款全部清偿之日止，乙方或甲方有义务在下列信息变更三日内提供更新后的信息给丙方：本人、本人的家庭联系人及紧急联系人、工作单位、居住地址、住所电话、手机号码、电子邮箱、银行账户的变更。若因任何一方不及时提供上述变更信息而带来的损失或额外费用应由该方承担。如果本协议中的任何一条或多条违反适用的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。\n\n附件：《征信授权书》乙方知晓并同意丙方依据《征信业管理条例》及相关法律法规，委托第三方征信机构，合法调查乙方信息，包括但不限于个人基本信息、借贷交易信息、银行卡交易信息、电商交易信息、公用事业信息、央行征信报告。所获取的信息，仅在此笔借贷业务的贷前审批和贷后管理工作中使用。丙方将对所获取的信息妥善进行保管，除为乙方提供信审服务/借款资金的合作方外，未经乙方授权，不得向其他机构或个人公开、编辑或透露信息内容。乙方知晓并同意丙方依据《征信业管理条例》及相关法律法规，向第三方征信机构提交乙方在此笔借贷业务中产生的相关信息，包括但不限于个人基本信息、借款申请信息、借款合同信息以及还款行为信息，并记录在征信机构的个人信用信息数据库中。乙方同意若乙方出现不良还款行为，丙方按合同所留联系方式对乙方进行提醒并告知，乙方若仍未履行还款义务，丙方可将乙方的不良还款信息提交至第三方征信机构，记录在征信机构的个人信用信息库中。乙方知晓并同意，乙方已被明确告知不良还款信息一旦记录在第三方征信机构的个人信用信息数据库中，在日后的经济活动中对乙方可能产生的不良影响。若乙方所约定的联络方式产生变化，乙方将及时通知亲亲小贷，若因未通知造成的相应损失，乙方愿承担相应责任。乙方知晓第三方征信机构。\n\n甲方：%@\n日期：%@\n乙方：%@\n日期：%@\n丙方：黑龙江短借金融服务外包有限公司\n日期：%@",@"哈尔滨市财源小额贷款有限责任公司",[df objectForKey:@"GeRenXinXi_Name_Field"],[df objectForKey:@"GeRenXinXi_ShenFenZhenHao_Field"],@"",@"",[df objectForKey:@"username"],benben,qixian,jiji,@"哈尔滨市财源小额贷款有限责任公司",xianzai,[df objectForKey:@"GeRenXinXi_Name_Field"],xianzai,xianzai];
    
    NSLog(@"--%@",[df objectForKey:@"JiaTingZhuZhi"]);
    
    labelText.font=[UIFont systemFontOfSize:14.0f];
    
    labelText.numberOfLines=0;
    
    [labelText sizeToFit];
    
    [scl addSubview:labelText];
    
    
    NSLog(@"shuchu---%@",[self digitUppercase:@"301"]);
    
    
    bot=[[UIView alloc] initWithFrame:CGRectMake(0, heig-80-64, width, 80)];
    bot.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0f];
    top=[[UIButton alloc] initWithFrame:CGRectMake(20, 5, width-40, 30)];
    [top setTitle:@"我同意以上借款协议" forState:UIControlStateNormal];
    
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
    
    scl.backgroundColor=[UIColor whiteColor];
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

-(void)getweiyi{
    
    
    // 先获取是否唯一
    
    //网络
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.mode =MBProgressHUDModeIndeterminate;

    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    [HUD setRemoveFromSuperViewOnHide:YES];

    
    
    
    
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
        
        
        if ([[responseObject objectForKey:@"flag"] intValue]==1)
            
            [self TiJiaoDingDan];
        
        else{
            
            [self popview];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [HUD hide:YES];
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode =MBProgressHUDModeIndeterminate;

        
        HUD.labelText =@"网络未连接，请重试！";
        
        HUD.margin = 10.f;
        
        [HUD setRemoveFromSuperViewOnHide:YES];
        
        [HUD hide:YES afterDelay:2];
        
    }];
    
    
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
    
    LeftRegisterVC* left3=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftRegister"];
    
    [self.navigationController pushViewController:left3 animated:YES];
    
    
    
}

-(void)quxiaoba{
    
    
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
}




//同意协议
- (void)YesLoan:(UIButton *)sender
{
    if (m==1)
        
        [self getweiyi];
    
    else{
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode =MBProgressHUDModeIndeterminate;

        
        HUD.labelText =@"请勾选同意以上借款协议";
        
        HUD.yOffset=100;
        
        [HUD show:YES];
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
        
    }
    
}


-(NSString *)digitUppercase:(NSString *)money
{
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *M=[[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(int i=moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
//        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
//        {
//            [M appendString:@"元整"];
//            break;
//        }
        [M appendString:MyScale[i-1]];
    }
     [M appendString:@"元整"];
    return M;
}

-(void)tijiaonewdd{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    [HUD  setRemoveFromSuperViewOnHide:YES];
    [HUD hide:YES afterDelay:2];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    NSLog(@"zhid=%@&jkje=%@&jkqx=%@&sxf=%@&skrxm=%@&skyhkh=%@&skyh=%@&jklx=%@&khhmc=%@",[defaults3 objectForKey:@"zhid"],[defaults3 objectForKey:@"JinE"],[defaults3 objectForKey:@"QiXian"],[defaults3 objectForKey:@"FeiLu"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],[defaults3 objectForKey:@"bank"],[defaults3 objectForKey:@"DaiKuanLeiXing"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"]);
    
    NSString *jinr=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"JinE"]];
    
    NSString *qix=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"QiXian"]];
    
    NSString *sxs=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"FeiLu"]];
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",[jinr substringToIndex:jinr.length-1],@"jkje",[qix substringToIndex:qix.length-1],@"jkqx",[sxs substringToIndex:sxs.length-1],@"sxf",[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],@"skrxm",[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],@"skyhkh",[defaults3 objectForKey:@"bank"],@"skyh",[defaults3 objectForKey:@"DaiKuanLeiXing"],@"jklx",[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuMingCheng_Field"],@"khhmc", nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidIndexAction!hyjksq.action",networkAddress];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"get--url--%@",url2);
    
    [manager POST:url1 parameters:dataDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //  NSLog(@"%@",responseObject);
        
        NSLog(@"dsASa---%@",responseObject);
       
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =[responseObject objectForKey:@"massages"];
        
        HUD.margin = 10.f;
        
        [HUD setRemoveFromSuperViewOnHide:YES];
        
        [HUD hide:YES afterDelay:2];
        
   
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
       
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"网络未连接，请重试！";
        
        HUD.margin = 10.f;
        
        [HUD setRemoveFromSuperViewOnHide:YES];
        
        [HUD hide:YES afterDelay:2];
        
        if (error.code != NSURLErrorTimedOut) {
            NSLog(@"错误: %@", error);
        }
        
    }];
    

}


-(void)TiJiaoDingDan{
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    NSString *url=[NSString stringWithFormat:@"%@androidIndexAction!hyjksq.action",networkAddress];
    NSString*url2=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",[defaults3 objectForKey:@"JinE"],@"jkje",[defaults3 objectForKey:@"QiXian"],@"jkqx",[defaults3 objectForKey:@"FeiLu"],@"sxf",[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],@"skrxm",[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],@"skyhkh",[defaults3 objectForKey:@"bank"],@"skyh",[defaults3 objectForKey:@"DaiKuanLeiXing"],@"jklx", nil];
    [manager POST:url2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"chenggong ");
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
                HUD.mode = MBProgressHUDModeText;
        
                HUD.labelText =[responseObject objectForKey:@"massages"];
        
                HUD.margin = 10.f;
        
                [HUD setRemoveFromSuperViewOnHide:YES];
                
                [HUD hide:YES afterDelay:1];
        LeftAtPresentBorrowMoneyVC*at=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftAtPresentBorrowMoney"];
        [self.navigationController pushViewController:at animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"shibai");
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText =@"网络连接失败";
        
        HUD.margin = 10.f;
        
        [HUD setRemoveFromSuperViewOnHide:YES];
        
        [HUD hide:YES afterDelay:1];
    }];
    

{
   
    
    
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@androidIndexAction!hyjksq.action",networkAddress]]];
//    [request setTimeoutInterval:20.0f];//
//    [request setHTTPMethod:@"POST"];//POSt请求
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];//Form请求（重要）
//    
//    NSMutableData *postBody=[NSMutableData data];//包体，在请求最前面
//    
//    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
//    
//    
//    NSLog(@"zhid=%@&jkje=%@&jkqx=%@&sxf=%@&skrxm=%@&skyhkh=%@&skyh=%@&jklx=%@",[defaults3 objectForKey:@"zhid"],[defaults3 objectForKey:@"JinE"],[defaults3 objectForKey:@"QiXian"],[defaults3 objectForKey:@"FeiLu"],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],[defaults3 objectForKey:@"bank"],[defaults3 objectForKey:@"DaiKuanLeiXing"]);
//    
//    NSString *jinr=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"JinE"]];
//    
//    NSString *qix=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"QiXian"]];
//    
//    NSString *sxs=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"FeiLu"]];
//    
//    
//    [postBody appendData:[[NSString stringWithFormat:@"zhid=%@&jkje=%@&jkqx=%@&sxf=%@&skrxm=%@&skyhkh=%@&skyh=%@&jklx=%@",[defaults3 objectForKey:@"zhid"],[jinr substringToIndex:jinr.length-1],[qix substringToIndex:qix.length-1],[sxs substringToIndex:sxs.length-1],[defaults3 objectForKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"],[defaults3 objectForKey:@"YinHangKaXinXi_YinHangKaHao_Field"],[defaults3 objectForKey:@"bank"],[defaults3 objectForKey:@"DaiKuanLeiXing"]] dataUsingEncoding:NSUTF8StringEncoding]];//把要传送的键值对封装成UTF8，转换成包体（重要）
//    
//    
//    [request setHTTPBody:postBody];//把包体给请求路径
//    
//    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];//AF把request封装成一种格式
//    
//    
//    
//    //把AF请求解析成Json格式
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        //        NSLog(@"operation hasAcceptableStatusCode: %@", responseObject);
//        
//        //返回成功的值
//        //        NSLog(@"Success: %@", operation.responseString);
//        
//        NSString *requestTmp = [NSString stringWithString:operation.responseString];
//        
//        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//        //系统自带JSON解析
//        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",[resultDic objectForKey:@"flag"]);
//        [defaults3 setObject:[resultDic objectForKey:@"flag"] forKey:@"DaiKuanShiFouKeYi"];
//        [defaults3 setObject:[resultDic objectForKey:@"massages"] forKey:@"DaiKuanShuChuXinXi"];
//        
//        
//        
//        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        HUD.mode = MBProgressHUDModeText;
//        
//        HUD.labelText =[resultDic objectForKey:@"massages"];
//        
//        HUD.margin = 10.f;
//        
//        [HUD setRemoveFromSuperViewOnHide:YES];
//        
//        [HUD hide:YES afterDelay:1];
//        
//        [self performSelector:@selector(huiqu) withObject:nil afterDelay:1];
//    
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        
//        HUD.mode = MBProgressHUDModeText;
//        
//        HUD.labelText = @"请重新上传";
//        
//        HUD.margin = 10.f;
//        
//        HUD.removeFromSuperViewOnHide=YES;
//        
//        [HUD hide:YES afterDelay:1];
//        
//        if (error.code != NSURLErrorTimedOut) {
//            NSLog(@"错误: %@", error);
//        }
//        
//    }];
//    //运行上面这个请求
//    [operation start];
    
    
}
}
-(void)huiqu{
    
[self.navigationController popToRootViewControllerAnimated:YES];

}
    //不同意协议
- (void)NoLoan:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
