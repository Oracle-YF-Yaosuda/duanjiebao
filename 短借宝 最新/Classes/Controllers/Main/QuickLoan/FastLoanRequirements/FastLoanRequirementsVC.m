//
//  FastLoanRequirementsVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/15.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "FastLoanRequirementsVC.h"
#import "LeftAtPresentBorrowMoneyVC.h"
@interface FastLoanRequirementsVC ()

@end

@implementation FastLoanRequirementsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)QLoanYes:(UIButton *)sender {

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"确认提交" message:@"是否确认提交" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    
    [alert show];

}
- (IBAction)QLoanNo:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        //跳转当前贷款
        LeftAtPresentBorrowMoneyVC *qlcVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftAtPresentBorrowMoney"];
        
        [self.navigationController pushViewController:qlcVC animated:YES];
    }
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
