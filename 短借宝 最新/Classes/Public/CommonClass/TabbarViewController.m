//
//  UZTabbarViewController.m
//  wellness
//
//  Created by feezoner-mac on 13-10-17.
//  Copyright (c) 2013年 com.youdro. All rights reserved.
//

#import "TabbarViewController.h"
#import "MacroUtil.h"

#define TAG_HINT_IMAGE     (10000)

@interface TabbarViewController ()<
UITabBarControllerDelegate
>



@end

@implementation TabbarViewController


#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - Delegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    
}


@end
