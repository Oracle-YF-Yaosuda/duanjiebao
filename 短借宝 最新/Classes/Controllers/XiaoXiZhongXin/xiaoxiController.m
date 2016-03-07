//
//  xiaoxiController.m
//  短借宝
//
//  Created by appleyf on 15/9/1.
//  Copyright © 2015年 com.appleyf. All rights reserved.
//

#import "xiaoxiController.h"
#import "Networking.h"
#import "AFNetworking.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "Header.h"

@interface xiaoxiController (){
    
    float width,heig;
}

@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation xiaoxiController{
    
    MBProgressHUD *HUD;
    int i;

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    i=1;
    
    self.title=@"消息中心";
    
    self.array=[NSMutableArray array];
    
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
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载中";
}
- (void)headerRereshing
{
    
    
    i=1;
    self.array =[NSMutableArray array];
    [self DangQianDaiKuan];
    
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    
    NSLog(@"%@",[defaults3 objectForKey:@"zhid"]);
    
    NSString *url = [NSString stringWithFormat:@"%@androidIndexAction!querytsxx.action",networkAddress];
    
    NSString *url1=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url--%@",url1);
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    HUD.labelText = @"正在加载...";
    
    [HUD setRemoveFromSuperViewOnHide:YES];
    
    [manager POST:url1 parameters:@{@"keyword":strJson} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try
        {
            NSLog(@"\n\n\n%@\n\n\n",responseObject);
            
            NSString *requestTmp = [NSString stringWithString:operation.responseString];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSMutableArray *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            
            [HUD hide:YES];
            
            
            if (resultDic.count==0) {
                
                
                HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                
                HUD.mode = MBProgressHUDModeText;
                
                HUD.labelText = @"已经是最后一页";
                
                HUD.margin = 10.f;
                
                HUD.removeFromSuperViewOnHide=YES;
                
                [HUD hide:YES afterDelay:1];
                
                NSLog(@"已经是最后一页");
                
            }else{
                
                [self.array addObjectsFromArray:resultDic];
                
                NSLog(@"rrrr%lu",(unsigned long)self.array.count);
                
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
        
        [HUD hide:YES];
        
        
        NSLog(@"%@",error);
        
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        HUD.mode = MBProgressHUDModeText;
        
        HUD.labelText = @"无法连接网络，请检查网络连接状态！";
        
        HUD.margin = 10.f;
        
        HUD.removeFromSuperViewOnHide=YES;
        
        [HUD hide:YES afterDelay:2];

        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if ([self.array count]>0) {
        
        return self.array.count;
        
    }
    else{
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic=self.array[indexPath.row];
    
    UILabel *DaiKuanLeiXing = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, width-30, 41)];
    
    DaiKuanLeiXing.font=[UIFont systemFontOfSize:14];
    DaiKuanLeiXing.text=[dic objectForKey:@"xxnr"];
    DaiKuanLeiXing.numberOfLines=0;
    
    [DaiKuanLeiXing sizeToFit];
    
    NSLog(@"-------dgao--%f",CGRectGetMaxY(DaiKuanLeiXing.frame)+30);
    
    return CGRectGetMaxY(DaiKuanLeiXing.frame)+50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleIdentify = @"SimpleIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentify];
       // cell = [[[NSBundle mainBundle] loadNibNamed:@"xiaoxi" owner:self options:nil] firstObject];
        
    }
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }
   
    
    NSDictionary *dic=self.array[indexPath.row];
    
    NSString *str=[dic objectForKey:@"tssj"];//时间戳
    NSTimeInterval time=[str longLongValue]/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd HH:mm"];
    
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    
    //贷款类型
    NSString *st=[[NSString alloc]init];
    
    if ([[dic objectForKey:@"jklx"] integerValue]==1) {
        st=@"极速借款";
    }else{
        
        st=@"普通借款";
    }
    
    //    //借款时间

    UILabel *DaiKuanLeiXing = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, width-30, 41)];
    
    DaiKuanLeiXing.font=[UIFont systemFontOfSize:14];
    DaiKuanLeiXing.text=[dic objectForKey:@"xxnr"];
    DaiKuanLeiXing.numberOfLines=0;
    
    [DaiKuanLeiXing sizeToFit];
    
    [cell.contentView addSubview:DaiKuanLeiXing];
    
    float mnb=CGRectGetMaxY(DaiKuanLeiXing.frame);
    
    UIView *hen=[[UIView alloc] initWithFrame:CGRectMake(15,mnb+10, width-30, 8)];
    hen.backgroundColor=[UIColor colorWithRed:1 green:232.0/255 blue:220.0/255 alpha:1.0f];
    
    //[cell.contentView addSubview:hen];
    
    UILabel *time1 = [[UILabel alloc] initWithFrame:CGRectMake(width-170, mnb+10, 165, 27)];
    time1.font=[UIFont systemFontOfSize:14];
    time1.text=currentDateStr;
    
    [cell.contentView addSubview:time1];
    UIView *vv=[[UIView alloc] initWithFrame:CGRectMake(15, mnb+35	, width-30, 1)];
    vv.backgroundColor= [UIColor colorWithRed:232.0/255 green:220.0/255 blue:220.0/255 alpha:1.0f];
    [cell.contentView addSubview:vv];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
