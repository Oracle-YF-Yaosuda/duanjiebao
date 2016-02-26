//
//  PersonalnformationTVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "PersonalnformationTVC.h"
#import "AFNetworking.h"
#import "Networking.h"
#import "JSONKit.h"
#import "CommonMethod.h"
#import "MBProgressHUD.h"
#import "Header.h"
#import "AutocompletionTableView.h"
@interface PersonalnformationTVC ()<UITextFieldDelegate>
{
    
    MBProgressHUD *HUD;
    CGFloat width;
    UIView *vv;
}
@property (nonatomic, strong) AutocompletionTableView *autoCompleter;
@property (weak, nonatomic) IBOutlet UIView *view_fa;
@property (strong, nonatomic) IBOutlet UITableView *TableV_frame;
@property (strong, nonatomic) NSString *areaValue, *cityValue;


@property (weak, nonatomic) IBOutlet UITextField *areaText;

@property (strong, nonatomic) UIButton *btn;
@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;
@end
@implementation PersonalnformationTVC
//@synthesize areaText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;



//重写set
-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        self.areaText.text = areaValue;
    }
}

-(void)setCityValue:(NSString *)cityValue
{
    if (![_cityValue isEqualToString:cityValue]) {
    }
}

//代理实现

#pragma mark - TextField delegate
//开始启动
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
    if(textField == self.XUeHao){
        return NO;
    }
    
    return YES;
    
    
}
-(void)zhuanke{
    
    self.XUeHao.text = @"专科";
    [vv removeFromSuperview];
    
}
-(void)benke{
    
    self.XUeHao.text = @"本科";
    [vv removeFromSuperview];
    
}
-(void)shuoshi{
    
    self.XUeHao.text = @"硕士";
    [vv removeFromSuperview];
    
}

-(void)viewWillAppear:(BOOL)animated{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",@"1",@"pagenumber",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!querylsjd.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [HUD hide:YES];
        
        if ([responseObject isEqual:@""]||[responseObject isEqual:[NSNull null]]||[responseObject count]==0) {
            _GeRenXinXi_Name_Field.userInteractionEnabled=YES;
        }else{
            _GeRenXinXi_Name_Field.userInteractionEnabled=NO;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [HUD hide:YES];
        
        HUD.mode =MBProgressHUDModeIndeterminate;
        
        HUD.labelText =@"网络未连接，请重试！";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD show:YES];
        
        [HUD hide:YES afterDelay:2];
        
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
}

-(void)DangQianDaiKuan
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",[NSString stringWithFormat:@"%d",1],@"pagenumber",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!querylsjd.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [HUD hide:YES];
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSMutableArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (resultDic.count>0) {
            
            self.GeRenXinXi_Name_Field.enabled=NO;
            
        }
        else
            
            self.GeRenXinXi_Name_Field.enabled=YES;
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [HUD hide:YES];
        
        HUD.mode =MBProgressHUDModeIndeterminate;
        
        HUD.labelText =@"网络未连接，请重试！";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD show:YES];
        
        [HUD hide:YES afterDelay:2];
        
    }];
    
    
}

- (AutocompletionTableView *)autoCompleter
{
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[AutocompletionTableView alloc] initWithTextField:self.GeRenXinXi_SuoZaiDaXue_Field inViewController:self withOptions:options];
        _autoCompleter.suggestionsDictionary = [NSArray arrayWithObjects:
                                                // 安徽
                                                @"中国科学技术大学",
                                                @"合肥工业大学",
                                                @"安徽大学",
                                                @"安徽师范大学",
                                                @"安徽农业大学",
                                                @"安徽医科大学",
                                                @"安徽理工大学",
                                                @"安徽工业大学",
                                                @"安徽中医学院",
                                                @"安徽工程科技学院",
                                                @"安徽财经大学",
                                                @"安庆师范学院",
                                                @"安徽科技学院",
                                                @"淮北煤炭师范学院",
                                                @"皖西学院",
                                                @"皖南医学院",
                                                @"合肥学院",
                                                @"安徽建筑工业学院",
                                                @"蚌埠医学院",
                                                @"淮南师范学院",
                                                @"宿州学院",
                                                @"阜阳师范学院",
                                                @"铜陵学院",
                                                @"巢湖学院",
                                                @"中国计算机函授学院",
                                                @"黄山学院",
                                                @"解放军电子工程学院",
                                                @"安徽广播电视大学",
                                                @"铜陵职业技术学院",
                                                @"滁州学院",
                                                @"蚌埠学院",
                                                @"安徽商贸职业技术学院",
                                                @"安徽财贸职业学院",
                                                @"合肥师范学院",
                                                @"安徽新华学院",
                                                @"池州学院",
                                                @"安徽工商职业学院",
                                                @"安徽三联学院",
                                                @"安徽电子信息职业技术学院",
                                                @"安徽工贸职业技术学院",
                                                @"安徽国防科技职业学院",
                                                @"芜湖职业技术学院",
                                                @"安徽公安职业学院",
                                                @"安徽广播影视职业技术学院",
                                                @"安徽水利水电职业技术学院",
                                                @"安徽城市管理职业学院",
                                                @"安徽交通职业技术学院",
                                                @"安徽警官职业学院",
                                                @"安徽冶金科技职业学院",
                                                @"安徽工业职业技术学院",
                                                @"安徽外国语职业技术学院",
                                                @"安徽新闻出版学院",
                                                @"安徽职业技术学院",
                                                @"安徽国际商务职业学院",
                                                @"安徽艺术职业学院",
                                                @"安徽邮电职业技术学院",
                                                @"亳州师范高等专科学校",
                                                @"安徽体育运动职业技术学院",
                                                @"安徽中医药高等专科学校",
                                                @"安庆职业技术学院",
                                                @"合肥经济技术职业学院",
                                                @"安徽医学高等专科学校",
                                                @"巢湖职业技术学院",
                                                @"池州职业技术学院",
                                                @"马鞍山师范高等专科学校",
                                                @"安徽中澳科技职业学院",
                                                @"淮南职业技术学院",
                                                @"六安职业技术学院",
                                                @"文达电脑专修学院",
                                                @"亳州职业技术学院",
                                                @"宿州职业技术学院",
                                                @"万博科技职业学院",
                                                @"宣城职业技术学院",
                                                @"合肥通用职业技术学院",
                                                // 北京
                                                @"清华大学",
                                                @"北京大学",
                                                @"北京师范大学",
                                                @"中国人民大学",
                                                @"北京航空航天大学",
                                                @"中国协和医科大学",
                                                @"北京理工大学",
                                                @"中国农业大学",
                                                @"北京工业大学",
                                                @"中国石油大学北京",
                                                @"北京科技大学",
                                                @"北京交通大学",
                                                @"北京化工大学",
                                                @"北京邮电大学",
                                                @"中央音乐学院",
                                                @"北京外国语大学",
                                                @"中国地质大学北京",
                                                @"北京中医药大学",
                                                @"首都师范大学",
                                                @"外交学院",
                                                @"对外经济贸易大学",
                                                @"首都医科大学",
                                                @"中国政法大学",
                                                @"北京语言大学",
                                                @"国际关系学院",
                                                @"中央民族大学",
                                                @"北京林业大学",
                                                @"北京体育大学",
                                                @"首都经济贸易大学",
                                                @"中央财经大学",
                                                @"华北电力大学",
                                                @"中国传媒大学",
                                                @"中国青年政治学院",
                                                @"北京大学医学部",
                                                @"北京服装学院",
                                                @"中央美术学院",
                                                @"中央戏剧学院",
                                                @"北京工商大学",
                                                @"北京物资学院",
                                                @"北京电子科技学院",
                                                @"北京第二外国语学院",
                                                @"北京建筑工程学院",
                                                @"中国音乐学院",
                                                @"北京联合大学",
                                                @"北京信息科技大学",
                                                @"中国人民公安大学",
                                                @"北方工业大学",
                                                @"北京农学院",
                                                @"北京城市学院",
                                                @"北京电影学院",
                                                @"北京石油化工学院",
                                                @"首钢工学院",
                                                @"中华女子学院",
                                                @"中国人民武装警察部队学院",
                                                @"北京印刷学院",
                                                @"中国劳动关系学院",
                                                @"燕京研究院",
                                                @"北京舞蹈学院",
                                                @"中国戏曲学院",
                                                @"中央广播电视大学",
                                                @"北京吉利大学",
                                                @"北京东方大学",
                                                @"首都体育学院",
                                                @"北大方正软件技术学院",
                                                @"中国矿业大学北京",
                                                @"北京电子科技职业学院",
                                                @"北京工业职业技术学院",
                                                @"北京京北职业技术学院",
                                                @"北京财贸职业学院",
                                                @"北京经济技术职业学院",
                                                @"北京科技职业学院",
                                                @"北京联合大学应用文理学院",
                                                @"北京交通职业技术学院",
                                                @"北京经贸职业学院",
                                                @"北京信息职业技术学院",
                                                @"防灾科技学院",
                                                @"北京农业职业学院",
                                                @"华侨学院",
                                                @"北京科技经营管理学院",
                                                @"北京培黎职业学院",
                                                // 上海
                                                @"上海交通大学",
                                                @"复旦大学",
                                                @"同济大学",
                                                @"华东师范大学",
                                                @"华东理工大学",
                                                @"上海财经大学",
                                                @"东华大学",
                                                @"上海大学",
                                                @"上海中医药大学",
                                                @"上海外国语大学",
                                                @"上海师范大学",
                                                @"上海体育学院",
                                                @"上海理工大学",
                                                @"上海音乐学院",
                                                @"上海海事大学",
                                                @"华东政法大学",
                                                @"上海海洋大学",
                                                @"上海戏剧学院",
                                                @"上海对外贸易学院",
                                                @"上海工程技术大学",
                                                @"上海电力学院",
                                                @"上海金融学院",
                                                @"上海应用技术学院",
                                                @"上海杉达学院",
                                                @"上海第二工业大学",
                                                @"上海商学院",
                                                @"上海电机学院",
                                                @"上海立信会计学院",
                                                @"第二军医大学",
                                                @"上海市经济管理干部学院",
                                                @"上海海关学院",
                                                @"上海电视大学",
                                                @"上海济光职业技术学院",
                                                @"上海政法学院",
                                                @"上海城市管理职业技术学院",
                                                @"上海中侨职业技术学院",
                                                @"上海科学技术职业学院",
                                                @"上海建峰职业技术学院",
                                                @"上海邦德学院",
                                                @"上海电影艺术学院",
                                                @"上海建桥学院",
                                                @"上海海事职业技术学院",
                                                @"上海工商外国语职业学院",
                                                @"上海农林职业技术学院",
                                                @"上海思博职业技术学院",
                                                @"上海交通职业技术学院",
                                                @"上海立达职业技术学院",
                                                @"上海工艺美术职业学院",
                                                @"上海中华职业技术学院",
                                                @"上海医药高等专科学校",
                                                @"上海托普信息技术学院",
                                                @"上海民远职业技术学院",
                                                @"上海震旦职业学院",
                                                @"上海新侨职业技术学院",
                                                // 天津
                                                @"南开大学",
                                                @"天津大学",
                                                @"天津医科大学",
                                                @"天津财经大学",
                                                @"天津科技大学",
                                                @"天津理工大学",
                                                @"天津工业大学",
                                                @"天津体育学院",
                                                @"天津外国语学院",
                                                @"天津商业大学",
                                                @"天津师范大学",
                                                @"天津城市建设学院",
                                                @"天津农学院",
                                                @"天津音乐学院",
                                                @"天津美术学院",
                                                @"天津工程师范学院",
                                                @"天津渤海职业技术学院",
                                                @"中国民航大学",
                                                @"天津广播电视大学",
                                                @"天津中医药大学",
                                                @"天津机电职业技术学院",
                                                @"天津工程职业技术学院",
                                                @"天津医学高等专科学校",
                                                @"天津职业大学",
                                                @"天津电子信息职业技术学院",
                                                @"天津国土资源和房屋职业学院",
                                                @"天津公安警官职业学院",
                                                @"天津滨海职业学院",
                                                @"天津天狮学院",
                                                @"天津冶金职业技术学院",
                                                @"天津轻工职业技术学院",
                                                @"天津现代职业技术学院",
                                                @"天津中德职业技术学院",
                                                @"天津交通职业学院",
                                                @"天津艺术职业学院",
                                                @"天津对外经济贸易职业学院",
                                                @"天津石油职业技术学院",
                                                @"天津铁道职业技术学院",
                                                @"天津开发区职业技术学院",
                                                // 重庆
                                                @"重庆大学",
                                                @"西南大学",
                                                @"西南政法大学",
                                                @"重庆医科大学",
                                                @"重庆工商大学",
                                                @"重庆师范大学",
                                                @"重庆理工大学",
                                                @"四川外语学院",
                                                @"重庆交通大学",
                                                @"长江师范学院",
                                                @"四川美术学院",
                                                @"重庆文理学院",
                                                @"重庆三峡学院",
                                                @"重庆电子工程职业学院",
                                                @"重庆房地产职业学院",
                                                @"重庆科技学院",
                                                @"重庆城市管理职业学院",
                                                @"达州职业技术学院",
                                                @"重庆工业职业技术学院",
                                                @"重庆邮电大学",
                                                @"重庆电子工程职业学院",
                                                @"重庆工贸职业技术学院",
                                                @"重庆城市管理职业学院",
                                                @"第三军医大学",
                                                @"重庆信息技术职业学院",
                                                @"重庆电力高等专科学校",
                                                @"重庆三峡职业学院",
                                                @"重庆海联学院",
                                                @"重庆水利电力职业技术学院",
                                                @"重庆警官职业学院",
                                                @"重庆工商职业学院",
                                                @"重庆工程职业技术学院",
                                                @"重庆民生职业技术学院",
                                                @"重庆医药高等专科学校",
                                                @"重庆正大软件职业技术学院",
                                                @"重庆航天职业技术学院",
                                                @"重庆三峡医药高等专科学校",
                                                @"重庆机电职业技术学院",
                                                // 河北
                                                @"河北工业大学",
                                                @"华北电力大学",
                                                @"燕山大学",
                                                @"河北大学",
                                                @"河北师范大学",
                                                @"河北农业大学",
                                                @"河北医科大学",
                                                @"河北科技大学",
                                                @"河北经贸大学",
                                                @"承德医学院",
                                                @"华北煤炭医学院",
                                                @"河北工程大学",
                                                @"石家庄铁道学院",
                                                @"华北科技学院",
                                                @"河北北方学院",
                                                @"唐山师范学院",
                                                @"河北科技师范学院",
                                                @"石家庄经济学院",
                                                @"河北建筑工程学院",
                                                @"唐山学院",
                                                @"中央司法警官学院",
                                                @"邢台学院",
                                                @"河北体育学院",
                                                @"河北传媒学院",
                                                @"衡水学院",
                                                @"邯郸学院",
                                                @"石家庄学院",
                                                @"东北大学秦皇岛分校",
                                                @"北华航天工业学院",
                                                @"河北理工大学",
                                                @"廊坊师范学院",
                                                @"河北石油职业技术学院",
                                                @"河北旅游职业学院",
                                                @"保定学院",
                                                @"邯郸职业技术学院",
                                                @"河北建材职业技术学院",
                                                @"保定职业技术学院",
                                                @"河北金融学院",
                                                @"邢台职业技术学院",
                                                @"河北工业职业技术学院",
                                                @"承德石油高等专科学校",
                                                @"石家庄职业技术学院",
                                                @"河北广播电视大学",
                                                @"邢台医学高等专科学校",
                                                @"唐山工业职业技术学院",
                                                @"河北旅游职业学院",
                                                @"石家庄计算机职业学院",
                                                @"石家庄外国语职业学院",
                                                @"河北政法职业学院",
                                                @"石家庄邮电职业技术学院",
                                                @"石家庄铁路职业技术学院",
                                                @"河北机电职业技术学院",
                                                @"河北工程技术高等专科学校",
                                                @"沧州师范专科学校",
                                                @"河北艺术职业学院",
                                                @"石家庄外语翻译职业学院",
                                                @"沧州医学高等专科学校",
                                                @"石家庄法商职业学院",
                                                @"石家庄东方美术学院",
                                                @"河北交通职业技术学院",
                                                @"张家口职业技术学院",
                                                @"廊坊职业技术学院",
                                                @"河北软件职业技术学院",
                                                @"河北司法警官职业学院",
                                                @"石家庄信息工程职业学院",
                                                // 河南
                                                @"郑州大学",
                                                @"河南大学",
                                                @"河南农业大学",
                                                @"河南师范大学",
                                                @"河南中医学院",
                                                @"河南科技大学",
                                                @"河南理工大学",
                                                @"河南工业大学",
                                                @"河南财经学院",
                                                @"洛阳师范学院",
                                                @"中原工学院",
                                                @"信阳师范学院",
                                                @"新乡医学院",
                                                @"黄河科技学院",
                                                @"河南科技学院",
                                                @"郑州轻工业学院",
                                                @"南阳师范学院",
                                                @"郑州航空工业管理学院",
                                                @"华北水利水电学院",
                                                @"安阳师范学院",
                                                @"许昌学院",
                                                @"周口师范学院",
                                                @"郑州科技学院",
                                                @"安阳工学院",
                                                @"平顶山学院",
                                                @"南阳理工学院",
                                                @"商丘师范学院",
                                                @"焦作师范高等专科学校",
                                                @"洛阳理工学院",
                                                @"焦作大学",
                                                @"河南城建学院",
                                                @"河南工程学院",
                                                @"开封大学",
                                                @"河南商业高等专科学校",
                                                @"黄淮学院",
                                                @"郑州大学升达经贸管理学院",
                                                @"平顶山工业职业技术学院",
                                                @"郑州电力高等专科学校",
                                                @"信阳农业高等专科学校",
                                                @"新乡学院",
                                                @"黄河水利职业技术学院",
                                                @"漯河医学高等专科学校",
                                                @"洛阳理工学院",
                                                @"河南交通职业技术学院",
                                                @"河南公安高等专科学校",
                                                @"商丘医学高等专科学校",
                                                @"郑州牧业工程高等专科学校",
                                                @"郑州工业安全职业学院",
                                                @"中州大学",
                                                @"郑州职业技术学院",
                                                @"河南机电高等专科学校",
                                                @"永城职业学院",
                                                @"郑州澍请医学高等专科学校",
                                                @"商丘职业技术学院",
                                                @"郑州师范高等专科学校",
                                                @"河南职业技术学院",
                                                @"河南财政税务高等专科学校",
                                                @"许昌职业技术学院",
                                                @"嵩山少林武术职业学院",
                                                @"济源职业技术学院",
                                                @"河南农业职业学院",
                                                @"商丘科技职业学院",
                                                @"郑州旅游职业学院",
                                                @"郑州科技学院",
                                                @"郑州电子信息职业技术学院",
                                                @"郑州经贸职业学院",
                                                @"河南经贸职业学院",
                                                @"河南检察职业学院",
                                                @"漯河职业技术学院",
                                                @"河南质量工程职业学院",
                                                @"郑州铁路职业技术学院",
                                                @"郑州华信学院",
                                                @"鹤壁职业技术学院",
                                                @"郑州交通学院",
                                                @"周口职业技术学院",
                                                // 山西
                                                @"山西大学",
                                                @"太原理工大学",
                                                @"山西医科大学",
                                                @"山西财经大学",
                                                @"山西农业大学",
                                                @"山西师范大学",
                                                @"中北大学",
                                                @"太原科技大学",
                                                @"太原师范学院",
                                                @"长治医学院",
                                                @"太原大学",
                                                @"山西中医学院",
                                                @"长治学院",
                                                @"运城学院",
                                                @"忻州师范学院",
                                                @"太原工业学院",
                                                @"山西广播电视大学",
                                                @"山西大同大学",
                                                @"晋中学院",
                                                @"山西工商职业学院",
                                                @"山西警官职业学院",
                                                @"太原广播电视大学",
                                                @"山西大学工程学院",
                                                @"山西交通职业技术学院",
                                                @"晋城职业技术学院",
                                                @"吕梁高等专科学校",
                                                @"山西大学商务学院",
                                                @"山西旅游职业学院",
                                                @"临汾职业技术学院",
                                                @"山西省财政税务专科学校",
                                                @"山西水利职业学院",
                                                @"太原旅游职业学院",
                                                @"山西信息职业技术学院",
                                                @"山西艺术职业学院",
                                                @"山西生物应用职业技术学院",
                                                @"山西国际商务职业学院",
                                                @"山西兴华职业学院",
                                                // 黑龙江
                                                @"哈尔滨工业大学",
                                                @"哈尔滨工程大学",
                                                @"哈尔滨医科大学",
                                                @"东北林业大学",
                                                @"东北农业大学",
                                                @"黑龙江中医药大学",
                                                @"哈尔滨理工大学",
                                                @"黑龙江大学",
                                                @"大庆石油学院",
                                                @"哈尔滨师范大学",
                                                @"哈尔滨商业大学",
                                                @"黑龙江八一农垦大学",
                                                @"哈尔滨学院",
                                                @"齐齐哈尔大学",
                                                @"佳木斯大学",
                                                @"哈尔滨体育学院",
                                                @"牡丹江师范学院",
                                                @"黑龙江科技学院",
                                                @"黑龙江工程学院",
                                                @"牡丹江医学院",
                                                @"齐齐哈尔医学院",
                                                @"绥化学院",
                                                @"黑龙江东方学院",
                                                @"大庆师范学院",
                                                @"大庆职业学院",
                                                @"黑河学院",
                                                @"哈尔滨广播电视大学",
                                                @"黑龙江广播电视大学",
                                                @"黑龙江畜牧兽医职业学院",
                                                @"黑龙江林业职业技术学院",
                                                @"牡丹江大学",
                                                @"鸡西大学",
                                                @"黑龙江农垦职业学院",
                                                @"大庆职业学院",
                                                @"齐齐哈尔师范高等专科学校",
                                                @"黑龙江司法警官职业学院",
                                                @"哈尔滨职业技术学院",
                                                @"伊春职业学院",
                                                @"黑龙江农业职业技术学院",
                                                @"黑龙江农业工程职业学院",
                                                @"大兴安岭职业学院",
                                                @"黑龙江农业经济职业学院",
                                                @"齐齐哈尔职业学院",
                                                @"哈尔滨铁道职业技术学院",
                                                @"黑龙江旅游职业技术学院",
                                                @"三江美术职业学院",
                                                @"哈尔滨电力职业技术学院",
                                                @"黑龙江艺术职业学院",
                                                @"华夏计算机职业技术学院",
                                                @"黑龙江农垦农业职业技术学院",
                                                @"黑龙江工商职业技术学院",
                                                @"黑龙江煤炭职业技术学院",
                                                @"黑龙江信息技术职业学院",
                                                @"黑龙江公安警官职业学院",
                                                @"黑龙江生态工程职业学院",
                                                @"黑龙江民族职业学院",
                                                @"哈尔滨现代公共关系职业学院",
                                                @"哈尔滨应用职业技术学院",
                                                @"黑龙江商业职业学院",
                                                @"黑龙江生物科技职业学院",
                                                // 辽宁
                                                @"大连理工大学",
                                                @"东北大学",
                                                @"中国医科大学",
                                                @"东北财经大学",
                                                @"辽宁大学",
                                                @"大连海事大学",
                                                @"沈阳药科大学",
                                                @"辽宁师范大学",
                                                @"沈阳农业大学",
                                                @"大连医科大学",
                                                @"沈阳工业大学",
                                                @"大连工业大学",
                                                @"辽宁石油化工大学",
                                                @"大连交通大学",
                                                @"沈阳大学",
                                                @"辽宁工业大学",
                                                @"辽宁工程技术大学",
                                                @"沈阳建筑大学",
                                                @"辽宁科技大学",
                                                @"大连大学",
                                                @"渤海大学",
                                                @"大连水产学院",
                                                @"沈阳化工学院",
                                                @"辽宁医学院",
                                                @"沈阳师范大学",
                                                @"沈阳理工大学",
                                                @"沈阳航空工业学院",
                                                @"鞍山师范学院",
                                                @"大连外国语学院",
                                                @"鲁迅美术学院",
                                                @"大连民族学院",
                                                @"沈阳医学院",
                                                @"辽宁科技学院",
                                                @"辽宁广播电视大学",
                                                @"沈阳音乐学院",
                                                @"沈阳体育学院",
                                                @"辽东学院",
                                                @"沈阳工程学院",
                                                @"辽宁金融职业学院",
                                                @"辽宁中医药大学",
                                                @"中国刑事警察学院",
                                                @"辽宁对外经贸学院",
                                                @"辽宁机电职业技术学院",
                                                @"大连职业技术学院",
                                                @"辽宁省交通高等专科学校",
                                                @"抚顺师范高等专科学校",
                                                @"营口职业技术学院",
                                                @"辽宁石化职业技术学院",
                                                @"朝阳师范高等专科学校",
                                                @"辽宁警官高等专科学校",
                                                @"大连商务职业学院",
                                                @"渤海船舶职业学院",
                                                @"辽宁广告职业学院",
                                                @"辽阳职业技术学院",
                                                @"辽宁林业职业技术学院",
                                                @"辽宁农业职业技术学院",
                                                @"盘锦职业技术学院",
                                                @"抚顺职业技术学院",
                                                @"辽宁美术职业学院",
                                                @"大连艺术职业学院",
                                                @"辽宁信息职业技术学院",
                                                @"沈阳航空职业技术学院",
                                                @"辽宁商贸职业学院",
                                                @"辽宁职业学院",
                                                @"沈阳职业技术学院",
                                                @"辽宁理工职业学院",
                                                @"大连枫叶职业技术学院",
                                                @"大连软件学院",
                                                @"大连翻译职业学院",
                                                // 吉林
                                                @"吉林大学",
                                                @"东北师范大学",
                                                @"延边大学",
                                                @"长春工业大学",
                                                @"长春理工大学",
                                                @"长春中医药大学",
                                                @"长春工程学院",
                                                @"北华大学",
                                                @"吉林化工学院",
                                                @"吉林工程技术师范学院",
                                                @"吉林农业大学",
                                                @"长春税务学院",
                                                @"吉林师范大学",
                                                @"长春大学",
                                                @"长春师范学院",
                                                @"吉林建筑工程学院",
                                                @"吉林体育学院",
                                                @"通化师范学院",
                                                @"吉林艺术学院",
                                                @"白城师范学院",
                                                @"吉林华桥外国语学院",
                                                @"延边大学",
                                                @"吉林工商学院",
                                                @"吉林农业科技学院",
                                                @"东北电力大学",
                                                @"长春汽车工业高等专科学校",
                                                @"长春金融高等专科学校",
                                                @"长春医学高等专科学校",
                                                @"白城医学高等专科学校",
                                                @"吉林医药学院",
                                                @"吉林司法警官职业学院",
                                                @"吉林农业工程职业技术学院",
                                                @"吉林交通职业技术学院",
                                                @"吉林电子信息职业技术学院",
                                                @"长春信息技术职业学院",
                                                @"长春职业技术学院",
                                                @"长春东方职业学院",
                                                // 江苏
                                                @"南京大学",
                                                @"东南大学",
                                                @"南京理工大学",
                                                @"南京航空航天大学",
                                                @"南京农业大学",
                                                @"苏州大学",
                                                @"南京师范大学",
                                                @"中国矿业大学",
                                                @"河海大学",
                                                @"南京医科大学",
                                                @"南京林业大学",
                                                @"南京工业大学",
                                                @"江南大学",
                                                @"江苏大学",
                                                @"中国药科大学",
                                                @"扬州大学",
                                                @"南京财经大学",
                                                @"南京邮电大学",
                                                @"徐州医学院",
                                                @"徐州师范大学",
                                                @"南通大学",
                                                @"江苏科技大学",
                                                @"江苏工业学院",
                                                @"苏州科技学院",
                                                @"南京信息工程大学",
                                                @"南京晓庄学院",
                                                @"淮阴师范学院",
                                                @"盐城师范学院",
                                                @"南京工程学院",
                                                @"盐城工学院",
                                                @"南京审计学院",
                                                @"南京艺术学院",
                                                @"江苏技术师范学院",
                                                @"淮阴工学院",
                                                @"南京体育学院",
                                                @"淮海工学院",
                                                @"常州工学院",
                                                @"常熟理工学院",
                                                @"江苏警官学院",
                                                @"徐州工程学院",
                                                @"金陵科技学院",
                                                @"江苏教育学院",
                                                @"中国人民解放军理工大学",
                                                @"江苏广播电视大学",
                                                @"南京化工职业技术学院",
                                                @"三江学院",
                                                @"南通航运职业技术学院",
                                                @"镇江市高等专科学校",
                                                @"淮安信息职业技术学院",
                                                @"南通职业大学",
                                                @"南京人口管理干部学院",
                                                @"泰州职业技术学院",
                                                @"无锡工艺职业技术学院",
                                                @"徐州建筑职业技术学院",
                                                @"南通纺织职业技术学院",
                                                @"河海大学常州校区",
                                                @"健雄职业技术学院",
                                                @"常州纺织服装职业技术学院",
                                                @"盐城纺织职业技术学院",
                                                @"应天职业技术学院",
                                                @"南京铁道职业技术学院",
                                                @"扬州工业职业技术学院",
                                                @"宿迁学院",
                                                @"无锡城市职业技术学院",
                                                @"连云港师范高等专科学校",
                                                @"钟山学院",
                                                @"金山职业技术学院",
                                                @"南京森林公安高等专科学校",
                                                @"无锡商业职业技术学院",
                                                @"扬州江海职业技术学院",
                                                @"扬州职业大学",
                                                @"沙洲职业工学院",
                                                @"苏州工艺美术职业技术学院",
                                                @"苏州市职业大学",
                                                @"连云港职业技术学院",
                                                @"南京工业职业技术学院",
                                                @"正德职业技术学院",
                                                @"无锡职业技术学院",
                                                @"苏州农业职业技术学院",
                                                @"无锡南洋职业技术学院",
                                                @"金肯职业技术学院",
                                                @"江苏畜牧兽医职业技术学院",
                                                @"常州信息职业技术学院",
                                                @"炎黄职业技术学院",
                                                @"常州机电职业技术学院",
                                                @"九州职业技术学院",
                                                @"硅湖职业技术学院",
                                                @"常州轻工职业技术学院",
                                                @"南京特殊教育职业技术学院",
                                                @"南京信息职业技术学院",
                                                @"江苏农林职业技术学院",
                                                @"江阴职业技术学院",
                                                @"江苏经贸职业技术学院",
                                                @"江苏信息职业技术学院",
                                                @"苏州经贸职业技术学院",
                                                @"江苏食品职业技术学院",
                                                @"扬州环境资源职业技术学院",
                                                @"苏州工业职业技术学院",
                                                @"无锡科技职业学院",
                                                @"江苏海事职业技术学院",
                                                @"州托普信息职业技术学院",
                                                @"南通农业职业技术学院",
                                                @"江苏联合职业技术学院",
                                                @"南京视觉艺术学院",
                                                @"昆山登云科技职业学院",
                                                @"建东职业技术学院",
                                                @"紫琅职业技术学院",
                                                // 浙江
                                                @"浙江大学",
                                                @"浙江工业大学",
                                                @"杭州电子科技大学",
                                                @"浙江中医药大学",
                                                @"浙江理工大学",
                                                @"中国美术学院",
                                                @"宁波大学",
                                                @"浙江工商大学",
                                                @"浙江师范大学",
                                                @"杭州师范大学",
                                                @"浙江林学院",
                                                @"浙江财经学院",
                                                @"温州大学",
                                                @"浙江警察学院",
                                                @"浙江海洋学院",
                                                @"中国计量学院",
                                                @"绍兴文理学院",
                                                @"温州医学院",
                                                @"浙江科技学院",
                                                @"嘉兴学院",
                                                @"浙江万里学院",
                                                @"湖州师范学院",
                                                @"宁波工程学院",
                                                @"台州学院",
                                                @"浙江传媒学院",
                                                @"丽水学院",
                                                @"浙江医学高等专科学校",
                                                @"浙江树人大学",
                                                @"台州广播电视大学",
                                                @"浙江广播电视大学",
                                                @"浙江越秀外国语学院",
                                                @"浙江教育学院",
                                                @"浙江艺术职业学院",
                                                @"宁波诺丁汉大学",
                                                @"宁波大红鹰学院",
                                                @"浙江水利水电专科学校",
                                                @"温州职业技术学院",
                                                @"浙江交通职业技术学院",
                                                @"金华职业技术学院",
                                                @"浙江医药高等专科学校",
                                                @"公安海警高等专科学校",
                                                @"浙江工贸职业技术学院",
                                                @"浙江商业职业技术学院",
                                                @"浙江海洋学院",
                                                @"浙江长征职业技术学院",
                                                @"浙江工业职业技术学院",
                                                @"浙江建设职业技术学院",
                                                @"台州职业技术学院",
                                                @"浙江警官职业学院",
                                                @"浙江经济职业技术学院",
                                                @"浙江经贸职业技术学院",
                                                @"浙江工商职业技术学院",
                                                @"浙江旅游职业学院",
                                                @"杭州职业技术学院",
                                                @"浙江广厦建设职业技术学院",
                                                @"宁波职业技术学院",
                                                @"绍兴托普信息职业技术学院",
                                                @"衢州职业技术学院",
                                                @"嘉兴南洋职业技术学院",
                                                @"浙江机电职业技术学院",
                                                @"湖州职业技术学院",
                                                @"杭州万向职业技术学院",
                                                @"浙江东方职业技术学院",
                                                @"浙江育英职业技术学院",
                                                @"浙江邮电职业技术学院",
                                                @"宁波城市职业技术学院",
                                                @"嘉兴职业技术学院",
                                                // 福建
                                                @"厦门大学",
                                                @"福州大学",
                                                @"福建师范大学",
                                                @"福建农林大学",
                                                @"福建医科大学",
                                                @"福建中医学院",
                                                @"华侨大学",
                                                @"集美大学",
                                                @"漳州师范学院",
                                                @"泉州师范学院",
                                                @"闽江学院",
                                                @"仰恩大学",
                                                @"三明学院",
                                                @"龙岩学院",
                                                @"福建工程学院",
                                                @"厦门理工学院",
                                                @"福建广播电视大学",
                                                @"漳州城市职业学院",
                                                @"福建教育学院",
                                                @"福建警察学院",
                                                @"福州职业技术学院",
                                                @"黎明职业大学",
                                                @"武夷学院",
                                                @"宁德师范高等专科学校",
                                                @"福建华南女子学院",
                                                @"福建交通职业技术学院",
                                                @"闽西职业技术学院",
                                                @"厦门华厦职业学院",
                                                @"漳州职业技术学院",
                                                @"泉州理工学院",
                                                @"闽南理工学院",
                                                @"福州英华职业学院",
                                                @"福州外语外贸职业技术学院",
                                                @"福建警官职业学院",
                                                @"泉州华光摄影艺术学院",
                                                @"福建电力职业技术学院",
                                                @"福建水利电力职业技术学院",
                                                @"福建信息职业技术学院",
                                                @"泉州纺织服装学院",
                                                @"厦门华天涉外学院",
                                                @"福建金融管理干部学院",
                                                @"湄洲湾职业技术学院",
                                                @"泉州经贸职业技术学院",
                                                @"福州海峡职业技术学院",
                                                @"福州科技职业技术学院",
                                                @"泉州信息学院",
                                                @"闽北职业技术学院",
                                                @"福建对外经济贸易职业技术学院",
                                                @"厦门兴才学院",
                                                @"厦门南洋学院",
                                                @"厦门演艺职业学院",
                                                @"福建林业职业技术学院",
                                                @"西安工程大学福州服装学院",
                                                @"福州黎明职业技术学院",
                                                @"福建省海峡国际学院",
                                                @"福建商业高等专科学校",
                                                @"福建卫生职业技术学院",
                                                @"福建生物工程职业技术学院",
                                                @"泉州儿童发展职业学院",
                                                @"福建农业职业技术学院",
                                                @"泉州医学高等专科学校",
                                                @"福建省政法管理干部学院",
                                                @"厦门医学高等专科学校",
                                                @"厦门海洋职业技术学院",
                                                @"宁德职业技术学院",
                                                @"漳州卫生职业学院",
                                                // 江西
                                                @"南昌大学",
                                                @"江西师范大学",
                                                @"江西财经大学",
                                                @"江西中医学院",
                                                @"江西农业大学",
                                                @"江西理工大学",
                                                @"南昌航空大学",
                                                @"东华理工大学",
                                                @"华东交通大学",
                                                @"景德镇陶瓷学院",
                                                @"江西科技师范学院",
                                                @"赣南师范学院",
                                                @"宜春学院",
                                                @"赣南医学院",
                                                @"井冈山大学",
                                                @"上饶师范学院",
                                                @"江西教育学院",
                                                @"九江学院",
                                                @"南昌理工学院",
                                                @"南昌大学医学院",
                                                @"萍乡高等专科学校",
                                                @"南昌工程学院",
                                                @"江西科技学院",
                                                @"江西公安专科学校",
                                                @"江西制造职业技术学院",
                                                @"上饶职业技术学院",
                                                @"赣西科技职业学院",
                                                @"新余高等专科学校",
                                                @"江西青年职业学院",
                                                @"景德镇高等专科学校",
                                                @"江西应用技术职业学院",
                                                @"宜春职业技术学院",
                                                @"九江职业大学",
                                                @"江西中医药高等专科学校",
                                                @"江西司法警官职业学院",
                                                @"江西航空职业技术学院",
                                                @"九江职业技术学院",
                                                @"江西陶瓷工艺美术学院",
                                                @"江西渝州科技学院",
                                                @"江西电力职业技术学院",
                                                @"江西信息应用职业技术学院",
                                                @"江西农业工程职业学院",
                                                @"江西城市职业学院",
                                                @"江西赣江职业技术学院",
                                                @"江西现代职业技术学院",
                                                @"江西工业工程职业技术学院",
                                                @"江西财经职业学院",
                                                @"江西环境工程职业学院",
                                                @"江西工业贸易职业技术学院",
                                                @"江西科技职业学院",
                                                @"江西服装职业技术学院",
                                                @"鹰潭职业技术学院",
                                                @"抚州职业技术学院",
                                                @"江西先锋软件职业技术学院",
                                                @"江西生物科技职业学院",
                                                @"江西大宇职院",
                                                @"江西经济管理学院",
                                                // 山东
                                                @"山东大学",
                                                @"中国海洋大学",
                                                @"中国石油大学华东",
                                                @"青岛大学",
                                                @"山东中医药大学",
                                                @"山东师范大学",
                                                @"山东农业大学",
                                                @"山东理工大学",
                                                @"山东科技大学",
                                                @"烟台大学",
                                                @"青岛科技大学",
                                                @"山东财政学院",
                                                @"聊城大学",
                                                @"山东经济学院",
                                                @"曲阜师范大学",
                                                @"青岛农业大学",
                                                @"山东工商学院",
                                                @"青岛理工大学",
                                                @"济南大学",
                                                @"山东轻工业学院",
                                                @"潍坊医学院",
                                                @"潍坊学院",
                                                @"鲁东大学",
                                                @"济宁医学院",
                                                @"滨州医学院",
                                                @"泰山医学院",
                                                @"德州学院",
                                                @"泰山学院",
                                                @"山东交通学院",
                                                @"临沂师范学院",
                                                @"山东艺术学院",
                                                @"山东体育学院",
                                                @"山东工艺美术学院",
                                                @"山东交通学院",
                                                @"山东建筑大学",
                                                @"山东警察学院",
                                                @"枣庄学院",
                                                @"山东政法学院",
                                                @"烟台南山学院",
                                                @"滨州学院",
                                                @"菏泽学院",
                                                @"青岛滨海学院",
                                                @"山东广播电视大学",
                                                @"山东大王职业学院",
                                                @"济宁职业技术学院",
                                                @"青岛飞洋职业技术学院",
                                                @"山东教育学院",
                                                @"烟台职业学院",
                                                @"山东科技大学济南校区",
                                                @"山东大学威海分校",
                                                @"山东万杰医学院",
                                                @"青岛港湾职业技术学院",
                                                @"中华女子学院山东分院",
                                                @"济南职业学院",
                                                @"山东协和职业技术学院",
                                                @"山东华宇职业技术学院",
                                                @"山东医学高等专科学校",
                                                @"泰山职业技术学院",
                                                @"济南工程职业技术学院",
                                                @"山东旅游职业学院",
                                                @"山东电子职业技术学院",
                                                @"山东铝业职业学院",
                                                @"淄博师范高等专科学校",
                                                @"山东电力高等专科学校",
                                                @"济南铁道职业技术学院",
                                                @"山东外事翻译学院",
                                                @"日照职业技术学院",
                                                @"山东中医药高等专科学校",
                                                @"山东菏泽医学专科学校",
                                                @"济宁学院",
                                                @"威海职业学院",
                                                @"山东劳动职业技术学院",
                                                @"莱芜职业技术学院",
                                                @"聊城职业技术学院",
                                                @"山东中西医结合大学",
                                                @"德州科技职业学院",
                                                @"曲阜远东职业技术学院",
                                                @"青岛职业技术学院",
                                                @"潍坊职业学院",
                                                @"山东科技职业学院",
                                                @"潍坊科技学院",
                                                @"山东力明科技职业学院",
                                                @"山东英才学院",
                                                @"东营职业学院",
                                                @"山东滨州职业学院",
                                                @"山东服装职业学院",
                                                @"山东信息职业技术学院",
                                                @"青岛酒店管理学院",
                                                @"山东畜牧兽医职业学院",
                                                @"淄博职业学院",
                                                @"山东化工职业学院",
                                                @"淄博科技职业学院",
                                                @"山东外贸职业学院",
                                                @"山东交通职业学院",
                                                @"青岛求实职业技术学院",
                                                @"山东胜利职业学院",
                                                @"青岛黄海职业学院",
                                                @"山东现代职业学院",
                                                @"山东经贸职业学院",
                                                @"山东药品食品职业学院",
                                                @"山东工业职业学院",
                                                @"青岛恒星职业技术学院",
                                                @"山东杏林科技职业学院",
                                                @"山东凯文科技职业学院",
                                                // 内蒙古
                                                @"内蒙古大学",
                                                @"内蒙古农业大学",
                                                @"内蒙古师范大学",
                                                @"内蒙古医学院",
                                                @"内蒙古工业大学",
                                                @"内蒙古科技大学",
                                                @"内蒙古民族大学",
                                                @"内蒙古财经学院",
                                                @"呼伦贝尔学院",
                                                @"包头职业技术学院",
                                                @"赤峰学院",
                                                @"集宁师范学院",
                                                @"呼和浩特职业学院",
                                                @"内蒙古商贸职业学院",
                                                @"内蒙古警察职业学院",
                                                @"兴安职业技术学院",
                                                @"内蒙古电子信息职业技术学院",
                                                @"通辽职业学院",
                                                @"乌兰察布职业学院",
                                                @"内蒙古科尔沁艺术职业学院",
                                                @"内蒙古交通职业技术学院",
                                                @"包头钢铁职业技术学院",
                                                @"内蒙古大学艺术学院",
                                                @"内蒙古经贸外语职业学院",
                                                // 湖北
                                                @"武汉大学",
                                                @"华中科技大学",
                                                @"华中师范大学",
                                                @"华中农业大学",
                                                @"武汉理工大学",
                                                @"中国地质大学",
                                                @"中南财经政法大学",
                                                @"湖北大学",
                                                @"武汉科技大学",
                                                @"湖北中医学院",
                                                @"中南民族大学",
                                                @"江汉大学",
                                                @"三峡大学",
                                                @"武汉体育学院",
                                                @"武汉科技学院",
                                                @"长江大学",
                                                @"咸宁学院",
                                                @"武汉工程大学",
                                                @"湖北工业大学",
                                                @"武汉工业学院",
                                                @"湖北师范学院",
                                                @"襄樊学院",
                                                @"鄂州职业大学",
                                                @"武汉音乐学院",
                                                @"黄冈师范学院",
                                                @"郧阳医学院",
                                                @"三峡职业技术学院",
                                                @"湖北民族学院",
                                                @"湖北美术学院",
                                                @"湖北汽车工业学院",
                                                @"湖北交通职业技术学院",
                                                @"孝感学院",
                                                @"湖北警官学院",
                                                @"湖北经济学院",
                                                @"武汉铁路职业技术学院",
                                                @"武汉生物工程学院",
                                                @"湖北第二师范学院",
                                                @"同济医学院",
                                                @"武汉航海职业技术学院",
                                                @"黄石理工学院",
                                                @"郧阳师范高等专科学校",
                                                @"湖北第二师范学院",
                                                @"黄冈职业技术学院",
                                                @"湖北广播电视大学",
                                                @"武汉职业技术学院",
                                                @"湖北中医药高等专科学校",
                                                @"湖北轻工职业技术学院",
                                                @"武汉广播电视大学",
                                                @"武汉船舶职业技术学院",
                                                @"武汉交通职业学院",
                                                @"荆州职业技术学院",
                                                @"荆楚理工学院",
                                                @"湖北艺术职业学院",
                                                @"襄樊职业技术学院",
                                                @"湖北开放学院",
                                                @"沙市大学",
                                                @"武汉商业服务学院",
                                                @"长江职业学院",
                                                @"武汉软件工程职业学院",
                                                @"咸宁职业技术学院",
                                                @"荆楚理工学院",
                                                @"武汉工程职业技术学院",
                                                @"湖北国土资源职业学院",
                                                @"十堰职业技术学院",
                                                @"仙桃职业学院",
                                                @"武汉信息传播职业技术学院",
                                                @"黄冈科技职业学院",
                                                @"湖北水利水电职业技术学院",
                                                @"武汉商贸职业学院",
                                                @"湖北财税职业学院",
                                                @"长江工程职业技术学院",
                                                @"武汉电力职业技术学院",
                                                @"武汉工业职业技术学院",
                                                @"武汉民政职业学院",
                                                @"武汉警官职业学院",
                                                @"湖北生物科技职业学院",
                                                @"江汉艺术职业学院",
                                                @"鄂东职业技术学院",
                                                @"湖北生态工程职业技术学院",
                                                // 湖南
                                                @"中南大学",
                                                @"湖南大学",
                                                @"湖南师范大学",
                                                @"湘潭大学",
                                                @"湖南农业大学",
                                                @"长沙理工大学",
                                                @"南华大学",
                                                @"湖南科技大学",
                                                @"吉首大学",
                                                @"湖南理工学院",
                                                @"湖南文理学院",
                                                @"湖南工程学院",
                                                @"湖南商学院",
                                                @"衡阳师范学院",
                                                @"邵阳学院",
                                                @"湖南人文科技学院",
                                                @"怀化学院",
                                                @"湖南科技学院",
                                                @"湖南城市学院",
                                                @"湘南学院",
                                                @"长沙学院",
                                                @"长沙医学院",
                                                @"湖南涉外经济学院",
                                                @"国防科学技术大学",
                                                @"中南大学湘雅医学院",
                                                @"湖南中医药大学",
                                                @"怀化医学高等专科学校",
                                                @"中南大学铁道学院",
                                                @"湖南广播电视大学",
                                                @"湖南理工专修学院",
                                                @"长沙师范专科学校",
                                                @"中南林业科技大学",
                                                @"湖南税务高等专科学校",
                                                @"湖南工业大学",
                                                @"长沙通信职业技术学院",
                                                @"湖南公安高等专科学校",
                                                @"湖南科技职业学院",
                                                @"湖南工学院",
                                                @"长沙民政职业技术学院",
                                                @"湖南中医药高等专科学校",
                                                @"湖南铁路科技职业技术学院",
                                                @"湖南第一师范学校",
                                                @"湖南铁道职业技术学院",
                                                @"湖南师范大学医学院",
                                                @"湖南机电职业技术学院",
                                                @"湖南财经高等专科学校",
                                                @"长沙电力职业技术学院",
                                                @"湖南大众传媒学院",
                                                @"湖南同德职业学院",
                                                @"湖南理工职业技术学院",
                                                @"湖南工艺美术职业学院",
                                                @"湖南环境生物学院",
                                                @"益阳职业技术学院",
                                                @"张家界航空工业职业技术学院",
                                                @"湖南女子学院",
                                                @"湖南科技经贸职业学院",
                                                @"湘潭职业技术学院",
                                                @"湖南商务职业技术学院",
                                                @"湖南冶金职业技术学院",
                                                @"湖南水利水电职业技术学院",
                                                @"湖南艺术职业学院",
                                                @"长沙航空职业技术学院",
                                                @"保险职业学院",
                                                @"衡阳财经工业学院",
                                                @"湖南工程职业技术学院",
                                                @"潇湘职业学院",
                                                @"湖南城建职业技术学院",
                                                @"郴州职业技术学院",
                                                @"湖南司法警官职业学院",
                                                @"湖南信息科学职业学院",
                                                @"常德职业技术学院",
                                                @"湖南信息职业技术学院",
                                                @"岳阳职业技术学院",
                                                @"湘西民族职业技术学院",
                                                @"长沙商贸旅游职业技术学院",
                                                @"怀化职业技术学院",
                                                @"邵阳职业技术学院",
                                                @"湖南工业职业技术学院",
                                                @"湖南安全技术职业学院",
                                                @"长沙南方职业学院",
                                                @"湖南交通职业技术学院",
                                                @"长沙环境保护职业技术学院",
                                                @"湖南网络工程职业学院",
                                                @"湖南民族职业学院",
                                                @"长沙社会安全学院",
                                                @"湖南化工职业技术学院",
                                                // 广东
                                                @"中山大学",
                                                @"华南理工大学",
                                                @"暨南大学",
                                                @"华南师范大学",
                                                @"华南农业大学",
                                                @"汕头大学",
                                                @"广州中医药大学",
                                                @"广东外语外贸大学",
                                                @"深圳大学",
                                                @"广东工业大学",
                                                @"广州大学",
                                                @"五邑大学",
                                                @"中山大学广州北校区",
                                                @"广东商学院",
                                                @"广州医学院",
                                                @"湛江师范学院",
                                                @"佛山科学技术学院",
                                                @"仲恺农业技术学院",
                                                @"肇庆学院",
                                                @"韶关学院",
                                                @"广东医学院",
                                                @"茂名学院",
                                                @"嘉应学院",
                                                @"广州体育学院",
                                                @"广东药学院",
                                                @"广东技术师范学院",
                                                @"韩山师范学院",
                                                @"广州美术学院",
                                                @"惠州学院",
                                                @"星海音乐学院",
                                                @"广东金融学院",
                                                @"广东培正学院",
                                                @"广东警官学院",
                                                @"广东白云学院",
                                                @"南方医科大学",
                                                @"南华工商学院",
                                                @"东莞理工学院",
                                                @"私立华联大学",
                                                @"广东广播电视大学",
                                                @"广东松山职业技术学院",
                                                @"广东海洋大学",
                                                @"广州航海高等专科学校",
                                                @"广东女子职业技术学院",
                                                @"佛山职业技术学院",
                                                @"广东教育学院",
                                                @"联合国际学院",
                                                @"顺德职业技术学院",
                                                @"广东机电职业技术学院",
                                                @"深圳职业技术学院",
                                                @"清远职业技术学院",
                                                @"广东水利电力职业技术学院",
                                                @"广东纺织职业技术学院",
                                                @"广东农工商职业技术学院",
                                                @"广东轻工职业技术学院",
                                                @"广东邮电职业技术学院",
                                                @"广州华立科技职业学院",
                                                @"广州番禺职业技术学院",
                                                @"广州城市职业学院",
                                                @"广州铁路职业技术学院",
                                                @"广州工程技术职业学院",
                                                @"广州华南商贸职业学院",
                                                @"广州民航职业技术学院",
                                                @"广东工程职业技术学院",
                                                @"广东新安职业技术学院",
                                                @"广东理工职业学院",
                                                @"潮汕职业技术学院",
                                                @"广东交通职业技术学院",
                                                @"广东建设职业技术学院",
                                                @"广州现代信息工程职业院",
                                                @"河源职业技术学院",
                                                @"广东纺织职业技术学院",
                                                @"深圳信息职业技术学院",
                                                @"阳江职业技术学院",
                                                @"广东亚视演艺职业学院",
                                                @"汕尾职业技术学院",
                                                @"南海东软信息技术学院",
                                                @"罗定职业技术学院",
                                                @"广东食品药品职业学院",
                                                @"汕头职业技术学院",
                                                @"肇庆工商职业技术学院",
                                                @"广东外语艺术职业学院",
                                                @"广东行政职业学院",
                                                @"珠海艺术职业学院",
                                                @"广东文艺职业学院",
                                                @"广东司法警官职业学院",
                                                @"珠海城市职业技术学院",
                                                @"肇庆科技职业技术学院",
                                                @"江门职业技术学院",
                                                @"广东体育职业技术学院",
                                                @"广州南洋理工职业学院",
                                                @"广州科技职业技术学院",
                                                @"广州工商职业技术学院",
                                                @"惠州经济职业技术学院",
                                                @"东莞南博职业技术学院",
                                                @"中山火炬职业技术学院",
                                                @"广东科贸职业学院",
                                                @"广州体育职业技术学院",
                                                @"广东岭南职业技术学院",
                                                // 广西
                                                @"广西大学",
                                                @"广西医科大学",
                                                @"广西师范大学",
                                                @"桂林电子科技大学",
                                                @"广西中医学院",
                                                @"广西师范学院",
                                                @"桂林理工大学",
                                                @"广西民族大学",
                                                @"广西工学院",
                                                @"桂林医学院",
                                                @"右江民族医学院",
                                                @"玉林师范学院",
                                                @"广西机电职业技术学院",
                                                @"广西财经学院",
                                                @"广西艺术学院",
                                                @"河池学院",
                                                @"邕江大学",
                                                @"桂林航天工业高等专科学校",
                                                @"桂林师范高等专科学校",
                                                @"桂林旅游高等专科学校",
                                                @"广西工艺美术学校",
                                                @"柳州职业技术学院",
                                                @"南宁职业技术学院",
                                                @"广西交通职业技术学院",
                                                @"梧州学院",
                                                @"贺州学院",
                                                @"钦州学院",
                                                @"广西民族师范学院",
                                                @"柳州师范高等专科学校",
                                                @"广西体育高等专科学校",
                                                @"百色学院",
                                                @"广西警官高等专科学校",
                                                @"广西职业技术学院",
                                                @"广西生态工程职业技术学院",
                                                @"广西农业职业技术学院",
                                                @"广西国际商务职业技术学院",
                                                @"广西东方外语职业学院",
                                                @"广西演艺职业学院",
                                                @"广西建设职业技术学院",
                                                @"广西电力职业技术学院",
                                                @"广西水利电力职业技术学院",
                                                @"北海艺术设计职业学院",
                                                @"广西工商职业技术学院",
                                                @"广西经贸职业技术学院",
                                                @"广西工业职业技术学院",
                                                @"贵港职业学院",
                                                @"河池职业学院",
                                                @"柳州运输职业技术学院",
                                                @"广西城市职业学院",
                                                @"广西英华国际职业学院",
                                                // 海南
                                                @"海南大学",
                                                @"中国热带农业科学院",
                                                @"海南医学院",
                                                @"海南师范大学",
                                                @"琼州学院",
                                                @"海口经济学院",
                                                @"海南政法职业学院",
                                                @"海南职业技术学院",
                                                @"海南外国语职业学院",
                                                @"海南大学三亚学院",
                                                // 四川
                                                @"四川大学",
                                                @"西南交通大学",
                                                @"电子科技大学",
                                                @"西南财经大学",
                                                @"成都理工大学",
                                                @"成都中医药大学",
                                                @"四川师范大学",
                                                @"四川农业大学",
                                                @"西南民族大学",
                                                @"四川大学华西医学中心",
                                                @"西南石油大学",
                                                @"西华师范大学",
                                                @"内江师范学院",
                                                @"西华大学",
                                                @"西南科技大学",
                                                @"成都体育学院",
                                                @"攀枝花学院",
                                                @"四川理工学院",
                                                @"成都信息工程学院",
                                                @"成都医学院",
                                                @"西昌学院",
                                                @"乐山师范学院",
                                                @"四川音乐学院",
                                                @"泸州医学院",
                                                @"绵阳师范学院",
                                                @"成都纺织高等专科学校",
                                                @"中国民航飞行学院",
                                                @"宜宾学院",
                                                @"四川广播电视大学",
                                                @"四川文理学院",
                                                @"成都电子机械高等专科学校",
                                                @"川北医学院",
                                                @"四川烹饪高等专科学校",
                                                @"四川民族学院",
                                                @"四川机电职业技术学院",
                                                @"成都大学",
                                                @"天一学院",
                                                @"四川工程职业技术学院",
                                                @"四川国际标榜职业学院",
                                                @"四川警察学院",
                                                @"成都航空职业技术学院",
                                                @"绵阳职业技术学院",
                                                @"四川建筑职业技术学院",
                                                @"成都艺术职业学院",
                                                @"四川工商职业技术学院",
                                                @"乐山职业技术学院",
                                                @"成都农业科技职业学院",
                                                @"阿坝师范高等专科学校",
                                                @"四川航天技术学院",
                                                @"四川司法警官职业学院",
                                                @"雅安职业技术学院",
                                                @"宜宾职业技术学院",
                                                @"四川交通职业技术学院",
                                                @"南充职业技术学院",
                                                @"四川警安职业学院",
                                                @"泸州职业技术学院",
                                                @"四川职业技术学院",
                                                @"内江职业技术学院",
                                                @"四川化工职业技术学院",
                                                @"四川信息职业技术学院",
                                                @"四川商务职业学院",
                                                @"成都东软信息技术职业学院",
                                                // 贵州
                                                @"贵州大学",
                                                @"贵州师范大学",
                                                @"贵阳医学院",
                                                @"贵州民族学院",
                                                @"遵义医学院",
                                                @"贵阳中医学院",
                                                @"毕节学院",
                                                @"贵阳学院",
                                                @"贵州财经学院",
                                                @"黔南民族师范学院",
                                                @"贵州航天职业技术学院",
                                                @"遵义师范学院",
                                                @"兴义民族师范学院",
                                                @"贵州警官职业学院",
                                                @"黔南民族医学高等专科学校",
                                                @"贵州交通职业技术学院",
                                                @"凯里学院",
                                                @"安顺学院",
                                                @"铜仁学院",
                                                @"贵州电子信息职业技术学院",
                                                @"贵州工业职业技术学院",
                                                @"黔南民族职业技术学院",
                                                @"贵州商业高等专科学校",
                                                @"安顺职业技术学院",
                                                // 云南
                                                @"云南大学",
                                                @"昆明理工大学",
                                                @"云南师范大学",
                                                @"云南农业大学",
                                                @"云南民族大学",
                                                @"昆明医学院",
                                                @"云南中医学院",
                                                @"云南财经大学",
                                                @"西南林学院",
                                                @"红河学院",
                                                @"楚雄师范学院",
                                                @"云南艺术学院",
                                                @"云南警官学院",
                                                @"昆明学院",
                                                @"大理学院",
                                                @"玉溪师范学院",
                                                @"昭通师范高等专科学校",
                                                @"云南交通职业技术学院",
                                                @"昆明冶金高等专科学校",
                                                @"曲靖师范学院",
                                                @"思茅师范高等专科学校",
                                                @"昆明艺术职业学院",
                                                @"云南省医学高等专科学校",
                                                @"保山学院",
                                                @"云南农业职业技术学院",
                                                @"云南文化艺术职业学院",
                                                @"云南司法警官职业学院",
                                                @"西双版纳职业技术学院",
                                                @"云南爱因森软件职业学院",
                                                @"云南林业职业技术学院",
                                                @"云南国土资源职业学院",
                                                @"云南文山师范高等专科学校",
                                                @"昆明扬帆职业技术学院",
                                                @"云南热带作物职业学院",
                                                @"云南体育运动职业技术学院",
                                                @"云南科技信息职业学院",
                                                @"云南国防工业职业技术学院",
                                                @"曲靖医学高等专科学校",
                                                @"云南机电职业技术学院",
                                                @"云南经济管理职业学院",
                                                @"云南北美职业学院",
                                                // 陕西
                                                @"西安交通大学",
                                                @"西北工业大学",
                                                @"西北大学",
                                                @"西安电子科技大学",
                                                @"西北农林科技大学",
                                                @"陕西师范大学",
                                                @"西安建筑科技大学",
                                                @"长安大学",
                                                @"西安理工大学",
                                                @"陕西中医学院",
                                                @"西北政法大学",
                                                @"西安科技大学",
                                                @"陕西科技大学",
                                                @"西安外国语大学",
                                                @"西安工业大学",
                                                @"西安石油大学",
                                                @"延安大学",
                                                @"西安财经学院",
                                                @"西安邮电学院",
                                                @"第四军医大学",
                                                @"西安文理学院",
                                                @"陕西理工学院",
                                                @"渭南师范学院",
                                                @"西安交通大学医学院",
                                                @"西安音乐学院",
                                                @"西安体育学院",
                                                @"西安美术学院",
                                                @"宝鸡文理学院",
                                                @"榆林学院",
                                                @"西京学院",
                                                @"西安欧亚学院",
                                                @"咸阳师范学院",
                                                @"西安外事学院",
                                                @"西安工程大学",
                                                @"西安电力高等专科学校",
                                                @"西安培华学院",
                                                @"安康学院",
                                                @"商洛学院",
                                                @"陕西服装艺术学院",
                                                @"西安翻译学院",
                                                @"西安汽车科技学院",
                                                @"西安思源学院",
                                                @"陕西交通职业技术学院",
                                                @"西安航空技术高等专科学校",
                                                @"陕西工业职业技术学院",
                                                @"陕西警官职业学院",
                                                @"西安航空职业技术学院",
                                                @"西安科技商贸学院",
                                                @"杨凌职业技术学院",
                                                @"陕西国际商贸学院",
                                                @"宝鸡职业技术学院",
                                                @"陕西国防工业职业技术学院",
                                                @"西安三资职业学院",
                                                @"陕西职业技术学院",
                                                @"陕西电子信息职业技术学院",
                                                @"陕西财经职业技术学院",
                                                @"陕西铁路工程职业技术学院",
                                                @"西安铁路职业技术学院",
                                                @"安康职业技术学院",
                                                @"延安职业技术学院",
                                                // 甘肃
                                                @"兰州大学",
                                                @"甘肃农业大学",
                                                @"西北师范大学",
                                                @"兰州理工大学",
                                                @"西北民族大学",
                                                @"兰州交通大学",
                                                @"甘肃中医学院",
                                                @"甘肃政法学院",
                                                @"兰州商学院",
                                                @"天水师范学院",
                                                @"河西学院",
                                                @"陇东学院",
                                                @"兰州工业高等专科学校",
                                                @"张掖医专",
                                                @"平凉医学高等专科学校",
                                                @"甘肃联合大学",
                                                @"兰州城市学院",
                                                @"兰州外语职业学院",
                                                @"甘肃林业职业技术学院",
                                                @"兰州职业技术学院",
                                                @"甘肃民族师范学院",
                                                @"兰州石化职业技术学院",
                                                @"酒泉职业技术学院",
                                                @"甘肃建筑职业技术学院",
                                                // 青海
                                                @"青海大学",
                                                @"青海师范大学",
                                                @"青海民族学院",
                                                @"青海大学医学院",
                                                @"青海交通职业技术学院",
                                                // 宁夏
                                                @"宁夏大学",
                                                @"宁夏医科大学",
                                                @"北方民族大学",
                                                @"宁夏理工学院",
                                                @"银川大学",
                                                @"宁夏师范学院",
                                                @"宁夏职业技术学院",
                                                @"宁夏广播电视大学",
                                                @"宁夏司法警官职业学院",
                                                @"宁夏工商职业技术学院",
                                                // 新疆
                                                @"新疆大学",
                                                @"新疆医科大学",
                                                @"石河子大学",
                                                @"新疆农业大学",
                                                @"新疆师范大学",
                                                @"新疆财经大学",
                                                @"喀什师范学院",
                                                @"伊犁师范学院",
                                                @"塔里木大学",
                                                @"新疆广播电视大学",
                                                @"新疆艺术学院",
                                                @"新疆石油学院",
                                                @"乌鲁木齐职业大学",
                                                @"昌吉学院",
                                                @"新疆警官高等专科学校",
                                                @"新疆农业职业技术学院",
                                                @"新疆天山职业技术学院",
                                                @"新疆轻工职业技术学院",
                                                @"克拉玛依职业技术学院",
                                                @"昌吉职业技术学院",
                                                @"巴音郭楞职业技术学院",
                                                @"新疆交通职业技术学院",
                                                // 西藏
                                                @"西藏大学",
                                                @"西藏民族学院",
                                                @"西藏藏医学院",
                                                // 台湾
                                                @"清华大学新竹",
                                                @"台湾大学",
                                                @"国立中央大学",
                                                @"国立交通大学",
                                                @"成功大学",
                                                @"国立暨南国际大学",
                                                @"国立中山大学",
                                                @"国立台湾海洋大学",
                                                @"国立台湾科技大学",
                                                @"国立台湾师范大学",
                                                @"中华大学",
                                                @"国立政治大学",
                                                @"中正大学",
                                                @"中国文化大学",
                                                @"国立台北艺术大学",
                                                @"国立中兴大学",
                                                @"国立嘉义大学",
                                                @"元智大学",
                                                @"中原大学",
                                                // 香港
                                                @"香港大学",
                                                @"香港理工大学",
                                                @"香港科技大学",
                                                @"香港城市大学",
                                                @"香港中文大学",
                                                @"香港浸会大学",
                                                @"香港公开大学",
                                                @"香港树仁大学",
                                                @"香港岭南大学",
                                                @"香港伯克莱大学",
                                                @"香港歌德学院",
                                                @"香港国际工商管理学院",
                                                @"香港教育学院",
                                                @"香港东南理工学院",
                                                @"香港电影学院",
                                                // 澳门
                                                @"澳门大学",
                                                @"澳门理工学院",
                                                @"澳门高等校际学院",
                                                @"IFT旅咣学院",
                                                @"澳门科技大学",
                                                @"澳门演艺学院",
                                                @"澳门保安部队高等学校",
                                                @"澳门缫湖护理学院",
                                                @"澳门中西创新学院",
                                                @"亚洲澳门国际公开大学",
                                                nil];
    }
    return _autoCompleter;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _GeRenXinXi_ShengRi_Field.userInteractionEnabled = NO;
    width = [UIScreen mainScreen].bounds.size.width;
    
    self.GeRenXinXi_Name_Field.delegate=self;
    //查找方法
    self.XUeHao.delegate = self;
    [self quzhifangjiemian];
    [self.GeRenXinXi_SuoZaiDaXue_Field addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.view_button.frame = CGRectMake(self.view_button.frame.origin.x, _view_button_y+self.tableView.contentOffset.y , self.view_button.frame.size.width, 35);
    //    self.areaText.delegate=self;
    //    [self.areaText addTarget:self action:@selector(areaTextAcion) forControlEvents:UIControlEventEditingDidBegin|UIControlEventValueChanged];
    
    
    
    
    
    
    
    
    _view_button_y=(CGRectGetMaxY(self.TableV_frame.frame)-60);
    
    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TableV_frame.frame.origin.x,_view_button_y, self.TableV_frame.frame.size.width, 50)];
    //    NSLog(@"%f",_view_button_y);
    
    self.view_button.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:0.5];
    
    
    
    if (self.view.frame.size.height<569) {
        
        // self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)/4, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+4)];
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(5,5,width-10,40)];
        
    }else if(self.view.frame.size.height<668){
        
        //self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-70, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(5,5,width-10,40)];
        
    }else if(self.view.frame.size.height<737){
        
        //self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-70, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(5,5,width-10,40)];
    }
    
    [self.btn setTitle:@"保存" forState:UIControlStateNormal];
    self.btn.userInteractionEnabled=YES;
    //    点击事件
    [self.btn addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    self.view_button.userInteractionEnabled=YES;
    UIImage *imag=[UIImage imageNamed:@"enniuzhengchang2x_03"];
    
    [self.btn setBackgroundImage:imag forState:UIControlStateNormal];
    //    [self.view_button addSubview:self.btn];
    //
    //    [self.TableV_frame addSubview:self.view_button];
    
    //    [self.TableV_frame bringSubviewToFront:_view_button];
    //    [self.view_button bringSubviewToFront:_btn];
    
    [self man:self.GeRenXinXi_Image_Man];
    
    
    [self DangQianDaiKuan];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField==_GeRenXinXi_Name_Field) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_GeRenXinXi_Name_Field.text forKey:@"gerenname"];
        
    }
}

-(void)quzhifangjiemian
{
    
    //        取值放界面
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    self.GeRenXinXi_ShenFenZhenHao_Field.text=[defaults3 objectForKey:@"GeRenXinXi_ShenFenZhenHao_Field"];
    //出生日期
    NSString *a = self.GeRenXinXi_ShenFenZhenHao_Field.text;
    int b = [[a substringWithRange:NSMakeRange(16, 1)] intValue];
    NSString *cc = [a substringWithRange:NSMakeRange(6, 8)];
    NSMutableString *string1 = [[NSMutableString alloc]initWithString:cc];
    [string1 insertString:@"-" atIndex:4];
    [string1 insertString:@"-" atIndex:7];
    self.GeRenXinXi_ShengRi_Field.text = string1;
    
    self.GeRenXinXi_Name_Field.text= [defaults3 objectForKey:@"GeRenXinXi_Name_Field"];
    
    
    if ((b%2)==0) {
        self.GeRenXinXI_Image_Woman.image=[UIImage imageNamed:@"denglu_15"];
        
        
        self.GeRenXinXi_Image_Man.hidden=YES;
        self.GeRenXinXI_Image_Woman.hidden=NO;
        
        
        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
        [defaults3 setObject:@"女" forKey:@"xingbie1"];
        
    }else{
        
        self.GeRenXinXi_Image_Man.image=[UIImage imageNamed:@"denglu_15"];
        
        
        self.GeRenXinXi_Image_Man.hidden=NO;
        self.GeRenXinXI_Image_Woman.hidden=YES;
        
        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
        [defaults3 setObject:@"男" forKey:@"xingbie1"];
        
    }
    self.GeRenXinXi_Name_Field.text= [defaults3 objectForKey:@"GeRenXinXi_Name_Field"];
    
    //    if ([[defaults3 objectForKey:@"xingbie"] isEqual:@"男"]) {
    //        self.GeRenXinXi_Image_Man.hidden=NO;
    //        self.GeRenXinXI_Image_Woman.hidden=YES;
    //
    //    }
    //    else{
    //        self.GeRenXinXi_Image_Man.hidden=YES;
    //        self.GeRenXinXI_Image_Woman.hidden=NO;
    //    }
    //    self.GeRenXinXi_ShengRi_Field.text=[defaults3 objectForKey:@"GeRenXinXi_ShengRi_Field"];
    if ([[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@"null"]||[[defaults3 objectForKey:@"GeRenXinXi_Name_Field"] isEqualToString:@""]) {
        
        
        
    }else{
        //    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        
        self.GeRenXinXi_SuoZaiDaXue_Field.text=[defaults3 objectForKey:@"GeRenXinXi_SuoZaiDaXue_Field"];
        self.GeRenXinXi_SuoZaiZhuanYe_Field.text=[defaults3 objectForKey:@"GeRenXinXi_SuoZaiZhuanYe_Field"];
        self.GeRenXinXi_BanJi_Field.text=[defaults3 objectForKey:@"GeRenXinXi_BanJi_Field"];
        self.XUeHao.text=[defaults3 objectForKey:@"XUeHao"];
        self.GeRenXinXi_XueXinWangZhangHao_Field.text=[defaults3 objectForKey:@"GeRenXinXi_XueXinWangZhangHao_Field"];
        self.GeRenXinXi_XueXinWangMiMai_Field.text=[defaults3 objectForKey:@"GeRenXinXi_XueXinWangMiMai_Field"];
        self.GongYuHao.text=[defaults3 objectForKey:@"SuSheDiZhi"];
        self.areaText.text=[defaults3 objectForKey:@"GeRenXinXi_ShengShiQu_Field"];
        self.GongyuLouHao.text=[defaults3 objectForKey:@"GongYuHao"];
        self.FangJianHao.text=[defaults3 objectForKey:@"FangJianHao"];
        self.JiaTingZhuZhi.text=[defaults3 objectForKey:@"JiaTingZhuZhi"];
    }
}



-(void)button{
    NSLog(@"jdhsajd");
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    NSLog(@"anan%d",(unsigned long)[[defaults3 objectForKey:@"xingbie1"] length]!=0
          );
    
    if ([self.GeRenXinXi_Name_Field.text isEqual:@""]||
        [self.GeRenXinXi_ShengRi_Field.text isEqual:@""]||
        [self.GeRenXinXi_ShenFenZhenHao_Field.text isEqual:@""]||
        [self.GeRenXinXi_SuoZaiDaXue_Field.text isEqual:@""]||
        [self.GeRenXinXi_SuoZaiZhuanYe_Field.text isEqual:@""]||
        [self.GeRenXinXi_BanJi_Field.text isEqual:@""]||
        [self.areaText.text isEqual:@""]||
        [self.GongYuHao.text isEqual:@""]||
        [self.GeRenXinXi_XueXinWangZhangHao_Field.text isEqual:@""]||
        [self.GeRenXinXi_XueXinWangMiMai_Field.text isEqual:@""]||
        [self.XUeHao.text isEqual:@""]||
        [self.GongyuLouHao.text isEqual:@""]||
        [self.FangJianHao.text isEqual:@""]||
        [[defaults3 objectForKey:@"xingbie1"] isEqual:@""]||[self.JiaTingZhuZhi.text isEqual:@""]
        
        ) {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"信息填写错误";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];
        
    }else
    {
        [self xinxishangchuan];
        
    }
    
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //self.view_button.frame = CGRectMake(self.view_button.frame.origin.x, _view_button_y+self.tableView.contentOffset.y , self.view_button.frame.size.width, self.view_button.frame.size.height);
    self.view_button.frame = CGRectMake(0, 0, width, 50);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)xinxishangchuan
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@androidLogAction!wshygrxx.action",networkAddress]]];
    [request setTimeoutInterval:20.0f];//
    [request setHTTPMethod:@"POST"];//POSt请求
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];//Form请求（重要）
    
    NSMutableData *postBody=[NSMutableData data];//包体，在请求最前面
    //    NSDictionary *dic6=[];
    
    //id:会员信息的id hyzhid：会员账号信息的id hyxm：会员真实姓名 sex：性别 csrq：出生日期 sfzh：身份证号
    //szdx：所在大学 szzy：所在专业 szbj：所在班级 hyxh：会员学号 xxwzh:学信网账号 xxwps：学信网登录密码
    //address：详细住址 ssdz：宿舍住址 sslh：公寓楼号 fjh:宿舍房间号
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    [postBody appendData:[[NSString stringWithFormat: @"id=%@&hyzhid=%@&hyxm=%@&sex=%@&csrq=%@&sfzh=%@&szdx=%@&szzy=%@&szbj=%@&xl=%@&xxwzh=%@&xxwps=%@&address=%@&ssdz=%@&sslh=%@号楼&fjh=%@&jtzz=%@&hyxh=%@",[defaults3 objectForKey:@"id"],[defaults3 objectForKey:@"zhid"],_GeRenXinXi_Name_Field.text,[defaults3 objectForKey:@"xingbie1"],_GeRenXinXi_ShengRi_Field.text,_GeRenXinXi_ShenFenZhenHao_Field.text,_GeRenXinXi_SuoZaiDaXue_Field.text,@"wu",@"wu",_XUeHao.text,_GeRenXinXi_XueXinWangZhangHao_Field.text,_GeRenXinXi_XueXinWangMiMai_Field.text,_areaText.text,_GongYuHao.text,@"wu",@"wu",@"wu",@"wu2"] dataUsingEncoding:NSUTF8StringEncoding]];//把要传送的键值对封装成UTF8，转换成包体（重要）
    
    
    [request setHTTPBody:postBody];//把包体给请求路径
    NSLog(@"%@",_JiaTingZhuZhi.text);
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];//AF把request封装成一种格式
    
    
    
    //把AF请求解析成Json格式
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"operation hasAcceptableStatusCode: %@", responseObject);
        
        //返回成功的值
        NSLog(@"Success: %@", operation.responseString);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",resultDic);
        
        NSDictionary *dic=[resultDic objectForKey:@"hyxx"];
        
        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
        
        //        hyxx
        
        [defaults3 setObject:[dic objectForKey:@"jtzz"] forKey:@"JiaTingZhuZhi"];//家庭住址
        [defaults3 setObject:[dic objectForKey:@"address"] forKey:@"GeRenXinXi_ShengShiQu_Field"];//地址
        [defaults3 setObject:[dic objectForKey:@"csrq"] forKey:@"GeRenXinXi_ShengRi_Field"];//生日
        [defaults3 setObject:[dic objectForKey:@"fjh"] forKey:@"FangJianHao"];//房间号
        [defaults3 setObject:[dic objectForKey:@"xl"] forKey:@"XUeHao"];//会员学号
        [defaults3 setObject:[dic objectForKey:@"hyxm"] forKey:@"GeRenXinXi_Name_Field"];//会员姓名
        [defaults3 setObject:[dic objectForKey:@"hyxm"] forKey:@"YinHangKaXinXi_KaiHuRenXingMing_Field"];
        [defaults3 setObject:[dic objectForKey:@"id"] forKey:@"id"];//会员id
        [defaults3 setObject:[dic objectForKey:@"sex"] forKey:@"xingbie"];//性别
        [defaults3 setObject:[dic objectForKey:@"sfzh"] forKey:@"GeRenXinXi_ShenFenZhenHao_Field"];//身份证号
        [defaults3 setObject:[dic objectForKey:@"ssdz"] forKey:@"SuSheDiZhi"];//宿舍地址
        [defaults3 setObject:[dic objectForKey:@"sslh"] forKey:@"GongYuHao"];//宿舍楼号
        [defaults3 setObject:[dic objectForKey:@"szbj"] forKey:@"GeRenXinXi_BanJi_Field"];//所在班级
        [defaults3 setObject:[dic objectForKey:@"szdx"] forKey:@"GeRenXinXi_SuoZaiDaXue_Field"];//所在大学
        [defaults3 setObject:[dic objectForKey:@"szzy"] forKey:@"GeRenXinXi_SuoZaiZhuanYe_Field"];//所在专业
        [defaults3 setObject:[dic objectForKey:@"xxwps"] forKey:@"GeRenXinXi_XueXinWangMiMai_Field"];//学信网密码
        
        NSLog(@"%@",[defaults3 objectForKey:@"GeRenXinXi_XueXinWangMiMai_Field"]);
        
        [defaults3 setObject:[dic objectForKey:@"xxwzh"] forKey:@"GeRenXinXi_XueXinWangZhangHao_Field"];//学信网账号
        [defaults3 setObject:[dic objectForKey:@"zhid"] forKey:@"zhid"];//会员账号id
        //        换到另一个页面
        [self.navigationController
         popViewControllerAnimated:YES];
        
        //[self.delegate hid];
        
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
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 0) {
        return 12;
    }
    else if (section == 1){
        return 0;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 7)
    {
        
        
        vv = [[UIView alloc]initWithFrame:CGRectMake(self.XUeHao.frame.origin.x, (self.XUeHao.frame.origin.y+self.XUeHao.frame.size.height)*9,  self.GeRenXinXi_SuoZaiDaXue_Field.frame.size.width, 90)];
        vv.backgroundColor = [UIColor whiteColor];
        
        
        UIButton *but1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 1,  self.GeRenXinXi_SuoZaiDaXue_Field.frame.size.width, 28)];
        [but1 setTitle:@"专         科" forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but1 addTarget:self action:@selector(zhuanke) forControlEvents:UIControlEventTouchUpInside];
        //but1.layer.cornerRadius = 5.0;
        
        UIButton *but2 = [[UIButton alloc]initWithFrame:CGRectMake(0,30,  self.GeRenXinXi_SuoZaiDaXue_Field.frame.size.width, 29)];
        [but2 setTitle:@"本         科" forState:UIControlStateNormal];
        [but2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but2 addTarget:self action:@selector(benke) forControlEvents:UIControlEventTouchUpInside];
        //but2.layer.cornerRadius = 5.0;
        
        UIButton *but3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 60,  self.GeRenXinXi_SuoZaiDaXue_Field.frame.size.width, 29)];
        [but3 setTitle:@"硕         士" forState:UIControlStateNormal];
        [but3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but3 addTarget:self action:@selector(shuoshi) forControlEvents:UIControlEventTouchUpInside];
        //but3.layer.cornerRadius = 5.0;
        
        
        [vv addSubview:but1];
        [vv addSubview:but2];
        [vv addSubview:but3];
        [self.view addSubview:vv];
        [self.view bringSubviewToFront:vv];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        return 50;
    }
    
    return 0;
    
}
//编辑header内容
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        
        UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 50)];
        baseView.backgroundColor = [UIColor clearColor];
        
        [baseView addSubview:self.view_button];
        
        [self.view_button addSubview:self.btn];
        
        return baseView;
        
        
    }
    
    return nil;
}

// 判断男女

- (IBAction)man:(id)sender {
    
    //    self.GeRenXinXi_Image_Man.image=[UIImage imageNamed:@"denglu_15"];
    //
    //
    //    self.GeRenXinXi_Image_Man.hidden=NO;
    //    self.GeRenXinXI_Image_Woman.hidden=YES;
    //
    //    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    //    [defaults3 setObject:@"男" forKey:@"xingbie1"];
    //
    //    //    NSLog(@"%@",[defaults objectForKey:@"xingbie1"]);
    
}

- (IBAction)nv:(id)sender {
    
    //    self.GeRenXinXI_Image_Woman.image=[UIImage imageNamed:@"denglu_15"];
    //
    //
    //    self.GeRenXinXi_Image_Man.hidden=YES;
    //    self.GeRenXinXI_Image_Woman.hidden=NO;
    //    
    //    
    //    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    //    [defaults3 setObject:@"女" forKey:@"xingbie1"];
    //    
    //    NSLog(@"%@",[defaults objectForKey:@"xingbie"]);
    
}


@end
