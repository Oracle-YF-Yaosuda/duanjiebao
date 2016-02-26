//
//  aaViewController.m
//  dianhuaben
//
//  Created by iMac21 on 15/8/14.
//  Copyright (c) 2015年 iMac21. All rights reserved.
//

#import "aaViewController.h"

@interface aaViewController (){
    
    
}

@end

@implementation aaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //弹出系统通讯录界面
    ABPeoplePickerNavigationController * con = [[ABPeoplePickerNavigationController   alloc]init];
    con.peoplePickerDelegate=self;
    [self presentViewController:con animated:YES completion:nil];
    
}
//点击方法
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    
    NSLog(@"11111");
    //获取当前联系人的电话 数组
    NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
    ABMultiValueRef phones= ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
        [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
    }
    
    
    NSLog(@"%@",phoneArr[0]);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
