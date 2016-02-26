//
//  LoanChoiceVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/7.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "LoanChoiceVC.h"
#import "MainVC.h"


@implementation LoanChoiceVC

- (IBAction)canCelButtonClick:(UIButton *)sender {
    
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/Documents/image.png",NSHomeDirectory()] error:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

@end
