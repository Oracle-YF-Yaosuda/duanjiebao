//
//  CJWTViewController.m
//  短借宝
//
//  Created by ll on 15/9/30.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "CJWTViewController.h"

@interface CJWTViewController (){
    
    float width,heig;
    
    NSMutableArray *shuju1;
    NSMutableArray *shuju2;
    NSMutableArray *states;
    
    UITableView *myzhu;
}

@end

@implementation CJWTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    heig=[[UIScreen mainScreen] bounds].size.height;
    
    shuju1=[[NSMutableArray alloc] init];
    shuju2=[[NSMutableArray alloc] init];
    states=[[NSMutableArray alloc] init];
    
   
    [shuju1 addObject:@"1Q:什么是信用积分？"];
    [shuju1 addObject:@"2Q:借款是否需要支付费用？"];
    [shuju1 addObject:@"3Q:如何还款？"];
    [shuju1 addObject:@"4Q:可以提前还款吗？"];
    [shuju1 addObject:@"5Q:没有及时还款怎么样？"];
    [shuju1 addObject:@"6Q:为什么通过初审了，借款还没有到帐？"];
    [shuju1 addObject:@"7Q:为什么我的借款审核不通过？"];
    [shuju1 addObject:@"8Q:创业项目提交后，什么时候能够知道申请是否通过？"];
    [shuju1 addObject:@"9Q:我提交的信息会泄露给第三方吗？"];
    
    
    [shuju2 addObject:@"A:信用积分是根据短借金融开发的风险评估模型，每笔借款会有相应的信用积分。信用积分越高，违约风险越低，借款成功率越高。信用积分也可以兑换相应的奖品。"];
    [shuju2 addObject:@"A:在您借款成功前，短借宝不收取任何费用。借款成功后，收取相应手续费，具体手续费情况详见我要借款页面下借款说明处。"];
    [shuju2 addObject:@"A:您可以在还款确认界面选择还款方式，进行还款。在还款提醒界面选择还款提醒时间，以免出现逾期情况。"];
    [shuju2 addObject:@"A:可以的，可以提前偿还部分或全部借款。"];
    [shuju2 addObject:@"A:当您逾期还款时，您的逾期记录将被提交至个人征信机构，会影响您今后的信用记录，敬请您珍惜个人信用记录。另外在逾期过程中将收取滞纳金。"];
    [shuju2 addObject:@"A:我们会在您提交申请后尽快完成审核，如果遇到节假日或者申请人数较多，审核进度可能会稍有延缓，请您耐心等待。由于银行接口不同，可能存在到帐时间稍缓，请您与客服保持联系，耐心等待。"];
    [shuju2 addObject:@"A:首先，请确保您填写的个人信息完整并真实、有效，上传的图片清晰符合要求。另外，如果您的综合情况暂时达不到短借宝的系统评估要求，也会导致审核不通过。如有疑问，请与客服及时联系。"];
    [shuju2 addObject:@"A:我们会尽快处理您提交的申请，在两个工作日左右项目评审委员会给您答复，请您填写真实、有效的联系方式，方便客服与您联系。"];
    [shuju2 addObject:@"A:短借宝严格遵守国家相关法律法规，对用户的隐私信息进行严格的保护。"];
    
    for (NSString *str in shuju1) {
        
        [states addObject:@"0"];
    }
    
    self.title=@"常见问题";
    
    myzhu=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, heig-64)];
    myzhu.dataSource=self;
    myzhu.delegate=self;
    
    [self.view addSubview:myzhu];
    
    

    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [shuju1 count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([states[section] isEqualToString:@"0"]) {
        
        return 0;
    }
    else
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *asd=@"dsa";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:asd];
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:asd];
    }
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }
    
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(16, 10, width-32, 20)];
    
    ll.font=[UIFont systemFontOfSize:14.0f];
    
    ll.textColor=[UIColor blackColor];
    
    ll.text=shuju2[indexPath.section];
    
    ll.numberOfLines=0;
    
    [ll sizeToFit];
    
    [cell.contentView addSubview:ll];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(16, 10, width-32, 20)];
    
    ll.font=[UIFont systemFontOfSize:14.0f];
    
    ll.text=shuju2[indexPath.section];
    
    ll.numberOfLines=0;
    
    [ll sizeToFit];
    
    NSLog(@"he--%f",CGRectGetHeight(ll.frame));
    return CGRectGetHeight(ll.frame)+30;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *qwe=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(16, 12, width-32, 20)];
    
    ll.font=[UIFont systemFontOfSize:14.0f];
    
    ll.textColor=[UIColor blackColor];
    
    ll.text=shuju1[section];
    
    [qwe addSubview:ll];
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(width-16-8, 16, 8, 12)];
    img.image=[UIImage imageNamed:@"arrow_320.png"];
    
    [qwe addSubview:img];
    
    
    UIButton *bn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    
    [bn addTarget:self action:@selector(cuu:) forControlEvents:UIControlEventTouchUpInside];
    
    bn.tag=100+section;
    
    [qwe addSubview:bn];
    
    UIView *heng=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    heng.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    
    [qwe addSubview:heng];
    
    return qwe;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *vv=[[UIView alloc] init];
    
    return vv;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (section!=[shuju2 count]-1) {
        return 0;
    }
    
    return 1;
}

-(void)cuu:(UIButton *)as{
    
    int ha=(int)as.tag-100;
    
    for (int i=0; i<[states count]; i++) {
        
        if (i!=ha) {
            states[i]=@"0";
        }
        
    }
    
    
    NSString *df=states[ha];
    
    if ([df isEqualToString:@"0"]) {
        [states replaceObjectAtIndex:ha withObject:@"1"];
    }
    else{
        [states replaceObjectAtIndex:ha withObject:@"0"];
    }
    
    [myzhu reloadData];
    
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
