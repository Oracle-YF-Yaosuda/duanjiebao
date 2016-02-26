//
//  QuickLoanExamineCharacherTVC.m
//  短借宝
//
//  Created by iMac21 on 15/8/5.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "QuickLoanExamineCharacherTVC.h"


#import "FastLoanRequirementsVC.h"


@interface QuickLoanExamineCharacherTVC ()
@property (strong, nonatomic) IBOutlet UITableView *TVB;
@property (weak, nonatomic) IBOutlet UIView *view_btn;
@property (strong, nonatomic) UIButton *btn;
@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;

@end

@implementation QuickLoanExamineCharacherTVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    _view_button_y=(CGRectGetMaxY(self.TVB.frame)-60);
//    
//    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TVB.frame.origin.x,_view_button_y, self.TVB.frame.size.width, 60)];
////    NSLog(@"%f",_view_button_y);
//    
//    self.view_button.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:0.8];
//    
//    
//    
//    if (self.view.frame.size.height<569) {
//        
//        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)/4, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+4)];
//        
//        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 60)];
//        ;
//        self.view_btn.frame=v.frame;
//        
//    }else if(self.view.frame.size.height<668){
//        
//        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-70, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
//        
//        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 100)];
//        ;
//        self.view_btn.frame=v.frame;
//        
//        
//    }else if(self.view.frame.size.height<737){
//        
//        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-105, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+15)];
//        
//        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 684, 320, 130)];
//        ;
//        self.view_btn.frame=v.frame;
//        
//    }
//    
//    [self.btn setTitle:@"保存" forState:UIControlStateNormal];
//    
//    UIImage *imag=[UIImage imageNamed:@"enniuzhengchang2x_03"];
//    
//    [self.btn setBackgroundImage:imag forState:UIControlStateNormal];
//    [self.view_button addSubview:self.btn];
//    
//    [self.TVB addSubview:self.view_button];
//    
//       [self.btn addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
//    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.view_button.frame = CGRectMake(self.view_button.frame.origin.x, _view_button_y+self.tableView.contentOffset.y , self.view_button.frame.size.width, self.view_button.frame.size.height);
}
-(void)button:(UIButton *)kkk
{
    FastLoanRequirementsVC *lcVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FastLoanRequirements"];
    
    [self.navigationController pushViewController:lcVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==0) {
        
        return 17;
    }else
    {
        return 3;
    }
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
