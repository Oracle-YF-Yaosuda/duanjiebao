//
//  IndividualAccountTVC.m
//  短借宝
//
//  Created by iMac21 on 15/7/23.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "IndividualAccountTVC.h"

@interface IndividualAccountTVC ()
@property (strong, nonatomic) IBOutlet UITableView *TVB;
@property (weak, nonatomic) IBOutlet UIView *view_btn;
@property (strong, nonatomic) UIButton *btn;
@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;
@end

@implementation IndividualAccountTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view_button_y=(CGRectGetMaxY(self.TVB.frame)-60);
    
    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TVB.frame.origin.x,_view_button_y, self.TVB.frame.size.width, 60)];
    NSLog(@"%f",_view_button_y);
    
    self.view_button.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:0.8];
    
    
    
    if (self.view.frame.size.height<569) {
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)/4, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+4)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 60)];
        ;
        self.view_btn.frame=v.frame;
        
    }else if(self.view.frame.size.height<668){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-70, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 100)];
        ;
        self.view_btn.frame=v.frame;
        
        
    }else if(self.view.frame.size.height<737){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-105, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+15)];
        
        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 130)];
        ;
        self.view_btn.frame=v.frame;
        
    }
    
    [self.btn setTitle:@"保存" forState:UIControlStateNormal];
    
    UIImage *imag=[UIImage imageNamed:@"enniuzhengchang2x_03"];
    
    [self.btn setBackgroundImage:imag forState:UIControlStateNormal];
    [self.view_button addSubview:self.btn];
    
    [self.TVB addSubview:self.view_button];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.view_button.frame = CGRectMake(self.view_button.frame.origin.x, _view_button_y+self.tableView.contentOffset.y , self.view_button.frame.size.width, self.view_button.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}


@end
