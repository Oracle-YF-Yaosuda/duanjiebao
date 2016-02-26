//
//  LeftTheMessageCenterVC.m
//  短借宝
//
//  Created by iMac21 on 15/7/20.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LeftTheMessageCenterVC.h"
#import "JSONKit.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "DuiHuanYeVC.h"

#import "LeftRegisterVC.h"
#import "Header.h"

@interface LeftTheMessageCenterVC ()<UITableViewDataSource,UITableViewDelegate>{
    
    MBProgressHUD *HUD;
    int JiShu;
    
    float width,heig;
    
    NSMutableArray *shuju;
    
    UIView *alertview;
    UIView *bai;
    UILabel *tishi;
    
    UIButton *que;
    
    UIButton *quxiao;
    
    UIView *heng1;
    UILabel *ll11;
    
    int index;
    
    int whowho;
    
}

@property (copy ,nonatomic) NSString *b;
@property (strong, nonatomic) UILabel *JiFen_label;
@property (strong, nonatomic) UITableView *tableViewk;
@end

@implementation LeftTheMessageCenterVC

- (void)viewWillAppear:(BOOL)animated{
    
    [self labelTextF];
}

- (void)viewDidLoad {
    JiShu=1;
    
    whowho=0;
    
    shuju=[[NSMutableArray alloc] init];

    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;

    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    // Do any additional setup after loading the view.
    UIView *view_Kuang=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width, self.view.frame.size.height/5)];
    view_Kuang.backgroundColor=[UIColor colorWithRed:0/255.0 green:204/255.0 blue:176/255.0 alpha:1];
    [self.view addSubview:view_Kuang];
    
    UIView *JiFen=[[UIView alloc]initWithFrame:CGRectMake(view_Kuang.frame.origin.x+10, view_Kuang.frame.origin.y+10, view_Kuang.frame.size.width-20, view_Kuang.frame.size.height-20)];
    JiFen.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    JiFen.layer.cornerRadius=8;
    JiFen.layer.masksToBounds = YES;
    [view_Kuang addSubview:JiFen];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(JiFen.frame.origin.x+5, JiFen.frame.origin.y+5, JiFen.frame.size.width, 15)];
    label.text=@"当前积分";
    label.font=[UIFont fontWithName:@"Heiti SC" size:13];
    
    [JiFen addSubview:label];
    
    _JiFen_label=[[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x , CGRectGetMaxY(JiFen.frame)-45, JiFen.frame.size.width, 30)];
    _JiFen_label.textColor=[UIColor colorWithRed:247/255.0 green:104/255.0 blue:0/255.0 alpha:1];
    [self labelTextF];
    [JiFen addSubview:_JiFen_label];

    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(JiFen.frame)-50, label.frame.origin.y-1, 15, 15)];
    image.image=[UIImage imageNamed:@"wenhao"];
    [JiFen addSubview:image];
    
    UILabel *JiFenShuoMing=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)-70, image.frame.origin.y, 52, image.frame.size.height)];
    JiFenShuoMing.text=@"积分说明";
    JiFenShuoMing.font=[UIFont fontWithName:@"Heiti SC" size:13];
    
    [JiFen addSubview:JiFenShuoMing];
    
//    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(JiFenShuoMing.frame.origin.x-5, JiFenShuoMing.frame.origin.y-5, JiFenShuoMing.frame.size.width+50, JiFen.frame.size.height)];
//    
//    [btn addTarget:self action:@selector(DianJi) forControlEvents:UIControlEventTouchUpInside];
//    [JiFen addSubview:btn];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DianJi)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    
    [JiFen addGestureRecognizer:tap];
    
    _tableViewk=[[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+5,CGRectGetMaxY(view_Kuang.frame),self.view.frame.size.width,self.view.frame.size.height - view_Kuang.frame.size.height-54) ];
    _tableViewk.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:1];
    NSLog(@"%f",self.view.frame.size.height - view_Kuang.frame.size.height-54);
    self.tableViewk.rowHeight=170;
    
    [self setupRefresh];

    [self.view addSubview:_tableViewk];
    
    [self Wangluo];
    
 
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableViewk addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableViewk addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableViewk.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableViewk.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableViewk.headerRefreshingText = @"正在刷新中";
    
    self.tableViewk.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableViewk.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableViewk.footerRefreshingText = @"正在加载中";
}
- (void)headerRereshing
{
    
    
    JiShu=1;
    [self Wangluo];

    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableViewk reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableViewk headerEndRefreshing];
    });
    
    
}

- (void)footerRereshing
{
    
    JiShu++;
    
    [self Wangluo];

    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableViewk reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableViewk footerEndRefreshing];
    });
}

-(void)DianJi
{

    //网络
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSString *url2 = [NSString stringWithFormat:@"%@androidIndexAction!queryjftx.action",networkAddress];
    
    NSString *url1=[url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"url--%@",url2);
    
    [manager POST:url1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"mm--%@",responseObject);
        
        //        hyxx
        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];

        [defaults3 setObject:[responseObject objectForKey:@"jfsm"] forKey:@"JiFenShuoMing"];

//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"积分说明" message:[defaults3 objectForKey:@"JiFenShuoMing"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        alertView.backgroundColor=[UIColor redColor];
//        
//        [alertView show];
        
        [self popview];
        
        ll11.text=@"积分说明";

        tishi.frame=CGRectMake(25, 75, width-50, 20);
        tishi.text=[defaults3 objectForKey:@"JiFenShuoMing"];
        tishi.numberOfLines=0;
        [tishi sizeToFit];
        
        bai.frame=CGRectMake(bai.frame.origin.x, bai.frame.origin.y, bai.frame.size.width, 75+CGRectGetMaxY(tishi.frame));
        
        quxiao.hidden=YES;
        heng1.hidden=YES;
        
        que.frame=CGRectMake(0, CGRectGetMaxY(tishi.frame)+25, width, 50);
        
        whowho=1;
        
       // [que addTarget:self action:@selector(quedingla) forControlEvents:UIControlEventTouchUpInside];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"积分说明" message:@"请检查网络在查看积分兑换说明。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
        
    }];
    
    
}
-(void)labelTextF
{
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    if ([defaults3 objectForKey:@"HuiYuanJiFen"]==nil) {
        _b=@"0";
        
    }else{
        _b=[NSString stringWithFormat:@"%@",[defaults3 objectForKey:@"HuiYuanJiFen"]];
        
    }
    NSString *a=[NSString stringWithFormat:@"%@%@",_b,@"分"];
    //创建 NSMutableAttributedString
    NSMutableAttributedString *attribuedstr1=[[NSMutableAttributedString alloc]initWithString:a];
    
    
    if (IPHONE4) {
        [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"Heiti SC" size: 28] range: NSMakeRange(0, a.length-1)];

    }else if(IPHONE5){
        [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"Heiti SC" size: 35] range: NSMakeRange(0, a.length-1)];

    
    }else if(IPHONE6){
    
        [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"Heiti SC" size: 50] range: NSMakeRange(0, a.length-1)];

    }else{
        [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"Heiti SC" size: 60] range: NSMakeRange(0, a.length-1)];
    }
    //给所有字符设置字体为Zapfino，字体高度为15像素
//    [attribuedstr1 addAttribute: NSFontAttributeName value: [UIFont fontWithName:@"Heiti SC" size: 35] range: NSMakeRange(0, a.length-1)];
    
    //    //分段控制，第5个字符开始的3个字符，即第5、6、7字符设置为红色
    //    [attribuedstr1 addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(4, 3)];
    //赋值给显示控件label01的 attributedText
    _JiFen_label.attributedText = attribuedstr1;
    
}
-(void)zhixing{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //keyword是json格式数据，包括pagenumber：当前页码
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",JiShu],@"pagenumber", nil];
    
    
    NSString *strJson = [dataDictionary JSONString];
    //        NSLog(@"%@",strJson);
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!queryJflp.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.tableViewk.delegate=self;
        self.tableViewk.dataSource=self;
        
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSMutableArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        
        NSLog(@"---%@",resultDic);
        //        NSLog(@"aaaaaaaa%@",[defaults3 objectForKey:@"LiPin"]);
        
        if (JiShu==1) {
            [shuju removeAllObjects];
        }
        
        for (NSDictionary *dic in resultDic) {
            [shuju addObject:dic];
        }
        
        
//        for (int a=0 ;a<resultDic.count ;a++) {
//            
//            if ([[resultDic[a] objectForKey:@"kybs"] integerValue]==0) {
//                
//                [resultDic removeObjectAtIndex:[resultDic[a] integerValue]==0];
//                
//                [defaults3 setObject:resultDic forKey:@"LiPin"];
//            }else{
//                
//                [defaults3 setObject:resultDic forKey:@"LiPin"];
//                
//                
//            }
//        }
      
        
        [self.tableViewk reloadData];
        
        [HUD removeFromSuperview];
        HUD=nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
        [HUD hide:YES];
        
        [HUD removeFromSuperview];
        HUD=nil;
        
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"积分说明" message:@"请检查网络在查看兑换礼品。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        //        [alertView show];
        
    }];

    
}

-(void)Wangluo
{
 
    //HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
  
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    //HUD.dimBackground=YES;
    
    [HUD show:YES];

    [self zhixing];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    index=(int)indexPath.row;
    
//    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
//    NSDictionary *ary= [defaults3 arrayForKey:@"LiPin"][indexPath.row];
//
//    [defaults3 setObject:ary forKey:@"NaYiHang"];
//    DuiHuanYeVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"DuiHuanYe"];
//    
//    
//    [self.navigationController
//     pushViewController:left3 animated:YES];
    
    int jifen=[_JiFen_label.text intValue];
    
    int dqsjf=[[shuju[indexPath.row] objectForKey:@"dhjfe"] intValue];
    
    if (jifen<dqsjf) {
        
        if (HUD) {
            [HUD removeFromSuperview];
        }
        
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        
        HUD.mode =MBProgressHUDModeText;
        
        HUD.labelText =@"积分不足，请选择其他礼品！";
        
        HUD.margin = 10.f;
        
        [HUD show:YES];
        
        //HUD.dimBackground=YES;
        
        [HUD hide:YES afterDelay:2];

       // [HUD removeFromSuperview];
        
        
    }
    else{
        
     //获取是否唯一
        
        [self getweiyi];
        


    }
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
            
        {
            
                [self popview];
            
                tishi.text=[NSString stringWithFormat:@"确定要消耗%@积分换取%@商品吗?",[shuju[index] objectForKey:@"dhjfe"],[shuju[index] objectForKey:@"spmc"]];
                tishi.frame=CGRectMake(25, 75, width-50, 20);
                tishi.numberOfLines=0;
                [tishi sizeToFit];
            
        }
        
        else{
            
            [self popview3];
            
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
-(void)popview3{
    
    
    alertview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    alertview.backgroundColor=[UIColor darkGrayColor];
    
    bai=[[UIView alloc] initWithFrame:CGRectMake(0, 120, width, 172)];
    
    bai.backgroundColor=[UIColor whiteColor];
    
    ll11=[[UILabel alloc] initWithFrame:CGRectMake(25, 16, width-16, 20)];
    ll11.text=@"提示";
    ll11.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:ll11];
    
    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(16, 52, width-32, 1)];
    heng.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [bai addSubview:heng];
    
    tishi=[[UILabel alloc] initWithFrame:CGRectMake(25, 75, width-50, 20)];
    tishi.text=@"该账号已在其他设备登陆，请重新登陆！";
    
    tishi.numberOfLines=0;
    
    [tishi sizeToFit];
    tishi.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:tishi];
    
    heng1=[[UIView alloc] initWithFrame:CGRectMake(0, 122, width-32, 1)];
    heng1.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    [bai addSubview:heng1];
    
    que=[[UIButton alloc] initWithFrame:CGRectMake(width/2, 123, width/2, 50)];
    
    [que setTitle:@"确认" forState:UIControlStateNormal];
    [que setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    que.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [que addTarget:self action:@selector(queding3) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:que];
    
    quxiao=[[UIButton alloc] initWithFrame:CGRectMake(0, 123, width/2, 50)];
    
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f] forState:UIControlStateNormal];
    quxiao.backgroundColor=[UIColor whiteColor];
    [quxiao addTarget:self action:@selector(quxiaoba3) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:quxiao];
    alertview.alpha=0.7;
    [self.view addSubview:alertview];
    [self.view addSubview:bai];
    
    
    
}

-(void)queding3{
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
    
    LeftRegisterVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"LeftRegister"];
    
    [self.navigationController pushViewController:left3 animated:YES];
    
    
    
}

-(void)quxiaoba3{
    
    
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [shuju count];
}
#pragma mark - 加载Cell的方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentify];
        
      //  cell = [[[NSBundle mainBundle] loadNibNamed:@"jifen" owner:self options:nil] firstObject] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tableViewk.separatorStyle=UITableViewCellSeparatorStyleNone;

    }
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vvv in arr) {
        [vvv removeFromSuperview];
    }
    
    
    UIImageView *tupian=[[UIImageView alloc] initWithFrame:CGRectMake(16, 9, 140, 140)];
    
    [tupian.layer setCornerRadius:5.0f];
    
    
    UILabel *ll1=[[UILabel alloc] initWithFrame:CGRectMake(140+32, 15, 60, 20)];
    ll1.text=@"商品名称";
    ll1.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll1.font= [UIFont systemFontOfSize:14.0f];
    [cell.contentView addSubview:ll1];
    
    UILabel *ll2=[[UILabel alloc] initWithFrame:CGRectMake(140+32, 50, 60, 20)];
    ll2.text=@"商品价格";
    ll2.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll2.font= [UIFont systemFontOfSize:14.0f];
    [cell.contentView addSubview:ll2];

    
    UILabel *ll3=[[UILabel alloc] initWithFrame:CGRectMake(140+32, 85, 60, 20)];
    ll3.text=@"兑换积分";
    ll3.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll3.font= [UIFont systemFontOfSize:14.0f];
    [cell.contentView addSubview:ll3];

    
    UILabel *ll4=[[UILabel alloc] initWithFrame:CGRectMake(140+32, 120, 60, 20)];
    ll4.text=@"生产厂商";
    ll4.textColor=[UIColor colorWithRed:97.0/255 green:97.0/255 blue:97.0/255 alpha:1.0f];
    ll4.font= [UIFont systemFontOfSize:14.0f];
    [cell.contentView addSubview:ll4];

    
    UILabel *ll5=[[UILabel alloc] initWithFrame:CGRectMake(242, 15, 60, 20)];
    ll5.font=[UIFont systemFontOfSize:14.0f];
    UILabel *ll6=[[UILabel alloc] initWithFrame:CGRectMake(242, 50, 60, 20)];
    ll6.textColor=[UIColor redColor];
    ll6.font=[UIFont systemFontOfSize:14.0f];
    UILabel *ll7=[[UILabel alloc] initWithFrame:CGRectMake(242, 85, 60, 20)];
    ll7.textColor=[UIColor redColor];
    ll7.font=[UIFont systemFontOfSize:14.0f];
    UILabel *ll8=[[UILabel alloc] initWithFrame:CGRectMake(242, 120, 60, 20)];
    ll8.textColor=[UIColor lightGrayColor];
    ll8.font=[UIFont systemFontOfSize:14.0f];

  
    
        NSUInteger row = [indexPath row];
    
        NSDictionary *dic  = [shuju objectAtIndex:row];
    
        ll5.text = [dic objectForKey:@"spmc"];
    
        ll6.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"scjg"]];
    
        ll8.text = [dic objectForKey:@"sccj"];

         ll7.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"dhjfe"]];
    
       // NSString *url=@"http://192.168.1.53:8080";
        NSString *urlImage1=[NSString stringWithFormat:@"%@/%@",networkAddress,[dic objectForKey:@"sptp"]];
        NSURL *uel=[NSURL URLWithString:urlImage1];
    [tupian sd_setImageWithURL:uel placeholderImage:[UIImage imageNamed:@"jifenback"]];
    
    
//        NSString *idk=[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
//        [defaults3 setObject:idk forKey:@"ShangPinDianHao"];
    
    [cell.contentView addSubview:tupian];
    
    [cell.contentView addSubview:ll5];
    [cell.contentView addSubview:ll6];
    [cell.contentView addSubview:ll7];
    [cell.contentView addSubview:ll8];
    
    return cell;
}

-(void)popview{
    
    
    alertview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, heig)];
    alertview.backgroundColor=[UIColor darkGrayColor];
    
    bai=[[UIView alloc] initWithFrame:CGRectMake(0, 120, width, 172)];
    
    bai.backgroundColor=[UIColor whiteColor];
    
    ll11=[[UILabel alloc] initWithFrame:CGRectMake(25, 16, width-16, 20)];
    ll11.text=@"提示";
    ll11.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:ll11];
    
    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(16, 52, width-32, 1)];
    heng.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [bai addSubview:heng];
    
    tishi=[[UILabel alloc] initWithFrame:CGRectMake(25, 75, width-50, 20)];
    tishi.text=@"提示";
    
    tishi.numberOfLines=0;
    
    [tishi sizeToFit];
    tishi.font=[UIFont systemFontOfSize:17.0];
    
    [bai addSubview:tishi];

    heng1=[[UIView alloc] initWithFrame:CGRectMake(0, 122, width-32, 1)];
    heng1.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    [bai addSubview:heng1];
    
    que=[[UIButton alloc] initWithFrame:CGRectMake(width/2, 123, width/2, 50)];
    
    [que setTitle:@"确认" forState:UIControlStateNormal];
    [que setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    que.backgroundColor=[UIColor colorWithRed:0 green:204.0/255 blue:178.0/255 alpha:1.0f];
    [que addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    
    [bai addSubview:que];

    quxiao=[[UIButton alloc] initWithFrame:CGRectMake(0, 123, width/2, 50)];
    
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
    
    if (whowho==0) {
  
    DuiHuanYeVC* left3=[self.storyboard instantiateViewControllerWithIdentifier:@"DuiHuanYe"];
    
    left3.jieshu=shuju[index];
    
    [self.navigationController
        pushViewController:left3 animated:YES];
    }
    
    whowho=0;
}

- (void)quedingla{

    [bai removeFromSuperview];
    [alertview removeFromSuperview];
    
}

-(void)quxiaoba{
    
    
    
    [bai removeFromSuperview];
    [alertview removeFromSuperview];
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
