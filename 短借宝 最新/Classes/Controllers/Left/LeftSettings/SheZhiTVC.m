//
//  SheZhiTVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/31.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "SheZhiTVC.h"
#import "FenXiangXiaZaiVC.h"
#import "PasswordModification.h"
#import "GuanYuWoMenVC.h"

#import "CJWTViewController.h"

@interface SheZhiTVC ()
{
    
    float width;
}

@end

@implementation SheZhiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width=[[UIScreen mainScreen] bounds].size.width;
    
    _myzhu.dataSource=self;
    _myzhu.delegate=self;
    
    _myzhu.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0f];
    
    _myzhu.scrollEnabled=NO;
    
    _myzhu.frame=CGRectMake(0, _myzhu.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==0) {
        
        return 1;
    }else
    {
        return 3;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString  *idd=@"wqe";
    
    
    
    UITableViewCell *cell;
    
    cell= [tableView dequeueReusableCellWithIdentifier:idd];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    NSArray *arr=[cell.contentView subviews];
    
    for (UIView *vv in arr) {
        [vv removeFromSuperview];
    }
    
    UILabel  *ll=[[UILabel alloc] initWithFrame:CGRectMake(25, 7, width-25, 30)];
    
    UIView *hen=[[UIView alloc] initWithFrame:CGRectMake(0, 43, width, 1)];
    
    hen.backgroundColor=[UIColor colorWithRed:215.0/255 green:215.0/255 blue:215.0/255 alpha:1.0f];
    
    //hen.frame=CGRectMake(0, 40,width , 4);
    
    if (indexPath.section!=0) {
        
        
        if (indexPath.row==0) {
            ll.text=@"分享下载";
        }
        else if (indexPath.row==1)
            ll.text=@"常见问题";
        else if (indexPath.row==2)
        
            ll.text=@"关于软件 (当前版本号:1.4)";
        
//        else if (indexPath.row==3)
//        
//            ll.text=@"关于软件";

        
        }
    
    else{
        
        
        ll.text=@"修改密码";
    }
    
    
    [cell.contentView addSubview:ll];
    
    [cell.contentView addSubview:hen];
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row==0 && indexPath.section==0) {
        
        PasswordModification *pp=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PasswordModificationVC"];
        
        [self.navigationController pushViewController:pp animated:YES];
        
    }
    else if (indexPath.section==1 && indexPath.row==0){
        FenXiangXiaZaiVC *pp=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FenXiangXiaZai"];
        
        [self.navigationController pushViewController:pp animated:YES];
        
    }
    else if (indexPath.section==1 && indexPath.row==1){
        CJWTViewController *pp=[[CJWTViewController alloc] init];
        
        [self.navigationController pushViewController:pp animated:YES];
        
    }

   
    else if (indexPath.section==1 && indexPath.row==2){
        GuanYuWoMenVC *pp=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GuanYuWoMen"];
        
        [self.navigationController pushViewController:pp animated:YES];
    }
 
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *vv=[[UIView alloc] init];
    
    vv.backgroundColor=[UIColor clearColor];
    
    return vv;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    
    UIView *vv=[[UIView alloc] init];


    return vv;
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
