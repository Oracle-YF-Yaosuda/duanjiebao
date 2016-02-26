//
//  BaseVC.m
//  DengTa
//
//  Created by majinyu on 15/5/11.
//  Copyright (c) 2015年 com.majinyu. All rights reserved.
//

#import "BaseVC.h"

@implementation BaseVC


#pragma mark - Life Cycle


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [SVProgressHUD dismiss];
    
    [super viewWillDisappear:animated];
}










@end
