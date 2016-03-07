//
//  LeftHistory.m
//  短借宝
//
//  Created by appleyf on 15/8/29.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LeftHistory.h"
#import "Networking.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

#import "Header.h"

@interface LeftHistory (){
    
    float width,heig;
    
    MBProgressHUD *HUD;
}

@property (nonatomic,strong)NSMutableArray *array;


@end

@implementation LeftHistory
{
    int i;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    i=1;
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    heig=[[UIScreen mainScreen] bounds].size.height;

    self.array=[NSMutableArray array];
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    
    HUD.mode =MBProgressHUDModeIndeterminate;
    
    HUD.labelText =@"正在加载...";
    
    HUD.margin = 10.f;
    
    HUD.removeFromSuperViewOnHide=YES;
    
    [HUD show:YES];
    

    
    [self DangQianDaiKuan];
    
    [self setupRefresh];
    
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在帮你刷新中,不客气";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在帮你加载中,不客气";
}
- (void)headerRereshing
{
    

        i=1;
    _array=[[NSMutableArray alloc] init];
    [self DangQianDaiKuan];
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
        [self.tableView headerEndRefreshing];
    });
    [self.tableView reloadData];

}

- (void)footerRereshing
{
 
    i++;
    
    [self DangQianDaiKuan];

    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
    [self.tableView reloadData];
}
-(void)DangQianDaiKuan
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    
    
    
    NSDictionary *dataDictionary= [NSDictionary dictionaryWithObjectsAndKeys:[defaults3 objectForKey:@"zhid"],@"zhid",[NSString stringWithFormat:@"%d",i],@"pagenumber",nil];
    
    NSString *strJson = [dataDictionary JSONString];
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!querylsjd.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try
        {
            NSLog(@"－－－－%@",responseObject);
            
            [HUD hide:YES];
            
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSMutableArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            
            
            if (resultDic.count==0) {
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText=@"已经是最后一页";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
            }else{
                
                [self.array addObjectsFromArray:resultDic];
                
                NSLog(@"rrrr%lu",(unsigned long)self.array.count);
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText=@"加载成功";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];

                [self.tableView reloadData];
                
                
            }
      
        }
        @catch (NSException * e) {
            HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            
            HUD.mode = MBProgressHUDModeText;
            
            HUD.labelText=@"请检查你的网络连接!";
            
            HUD.margin = 10.f;
            
            HUD.removeFromSuperViewOnHide=YES;
            
            [HUD hide:YES afterDelay:1];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
 
    if ([self.array count]>0) {
    
    return self.array.count;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
   
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentify];
        
    }
    
    cell.backgroundColor=[UIColor whiteColor];
    
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }
    

    UILabel *ill1=[[UILabel alloc] initWithFrame:CGRectMake(8, 100, 52, 50)];
    
    ill1.font=[UIFont systemFontOfSize:14];
    
    [cell.contentView addSubview:ill1];
    
    
    UIView *shu=[[UIView alloc] initWithFrame:CGRectMake(68, 1, 1, 250)];
    shu.backgroundColor=[UIColor colorWithRed:197.0/255 green:197.0/255 blue:197.0/255 alpha:1.0f];
    [cell.contentView addSubview:shu];
    
    
    UIImageView *imgg=[[UIImageView alloc] initWithFrame:CGRectMake(60, 114, 17, 17)];
    
    imgg.image=[UIImage imageNamed:@"lishi_01_11"];
    
    [cell.contentView addSubview:imgg];
    
    
    UIImageView *imgg1=[[UIImageView alloc] initWithFrame:CGRectMake(91, 8, width-101, 245)];
    
    imgg1.image=[UIImage imageNamed:@"lishi_01_07"];
    
    [cell.contentView addSubview:imgg1];

    
    UILabel *mm1=[[UILabel alloc] initWithFrame:CGRectMake(109, 9, width-119, 21)];
    mm1.font=[UIFont systemFontOfSize:16];
    
    [cell.contentView addSubview:mm1];
    
    UILabel *mm2=[[UILabel alloc] initWithFrame:CGRectMake(109, 39, width-119, 21)];
    mm2.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm2];
    
    UILabel *mm3=[[UILabel alloc] initWithFrame:CGRectMake(109, 69, width-119, 21)];
    mm3.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm3];
    
    UILabel *mm4=[[UILabel alloc] initWithFrame:CGRectMake(109, 99, width-119, 21)];
    mm4.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm4];
    
    UILabel *mm5=[[UILabel alloc] initWithFrame:CGRectMake(109, 129, width-119, 21)];
    mm5.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm5];
    
    UILabel *mm6=[[UILabel alloc] initWithFrame:CGRectMake(109, 159, width-119, 21)];
    mm6.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm6];
    
    UILabel *mm7=[[UILabel alloc] initWithFrame:CGRectMake(109, 189, width-119, 21)];
    mm7.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm7];
    
    UILabel *mm8=[[UILabel alloc] initWithFrame:CGRectMake(109, 219, width-119, 21)];
    mm8.font=[UIFont systemFontOfSize:13];
    
    [cell.contentView addSubview:mm8];
    
    
    
    

    NSDictionary *dic=self.array[indexPath.row];
    
    NSString *str=[dic objectForKey:@"yhksj"];//时间戳
    NSTimeInterval time=[str longLongValue]/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
//    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStrK = [dateFormatter stringFromDate: detaildate];

    [defaults3 setObject:currentDateStrK forKey:@"ShiJian"];
//    NSLog(@"ddddd%@",[defaults3 objectForKey:@"ShiJian"]);
    
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd HH:mm"];

    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    

    mm6.text=[NSString stringWithFormat:@"应还时间:%@",currentDateStr];
    mm6.textAlignment=NSTextAlignmentCenter;
    mm6.numberOfLines=0;
    
    [mm6 sizeToFit];
    
    //贷款类型
    NSString *st=[[NSString alloc]init];

    if ([[dic objectForKey:@"jklx"] integerValue]==1) {
        st=@"极速借款";
    }else{
    
        st=@"普通借款";
    }
    
    mm1.text=st;
    
    
    //贷款金额
  
    NSString *jie=[NSString stringWithFormat:@"借款金额:%@元",[dic objectForKey:@"jkje"]];
    mm2.text=jie;
    //贷款期限
  
    NSString *jiekuanqixian=[NSString stringWithFormat:@"借款期限:%@天",[dic objectForKey:@"jkqx"]];
    mm3.text=jiekuanqixian;

    //还款金额
    
    NSString *huankuanjie=[NSString stringWithFormat:@"还款金额:%@元",[dic objectForKey:@"hkje"]];
    mm4.text=huankuanjie;

    //借款时间
    NSString *s=[dic objectForKey:@"sqsj"];//时间戳
    NSTimeInterval timeA=[s longLongValue]/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildateA=[NSDate dateWithTimeIntervalSince1970:timeA];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatterA = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatterA setDateFormat:@"yyyy年MM月dd HH:mm"];
    NSString *currentDateStrA = [dateFormatterA stringFromDate: detaildateA];
    NSString *jiekuanshijian=[NSString stringWithFormat:@"借款时间:%@",currentDateStrA];
    mm5.text=jiekuanshijian;
    mm5.numberOfLines=0;
    [mm5 sizeToFit];
    
    //还款时间
    NSString *ss=[dic objectForKey:@"cwshsj"];//时间戳
    NSTimeInterval timeA1=[ss longLongValue]/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildateA1=[NSDate dateWithTimeIntervalSince1970:timeA1];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatterA1 = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatterA1 setDateFormat:@"yyyy年MM月dd HH:mm"];
    NSString *currentDateStrA1 = [dateFormatterA stringFromDate: detaildateA1];
    NSString *jiekuanshijian1=[NSString stringWithFormat:@"%@",currentDateStrA1];

    ill1.text=jiekuanshijian1;
    ill1.numberOfLines=0;
    [ill1 sizeToFit];

    //收款银行
    
    NSString *shoukuanyinhang=[NSString stringWithFormat:@"收款银行:%@",[dic objectForKey:@"skyh"]];
    mm7.text=shoukuanyinhang;

    //银行卡号
    
    NSString *yinhangka=[NSString stringWithFormat:@"银行卡号:%@",[dic objectForKey:@"skyhkh"]];
    mm8.text=yinhangka;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 255;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
