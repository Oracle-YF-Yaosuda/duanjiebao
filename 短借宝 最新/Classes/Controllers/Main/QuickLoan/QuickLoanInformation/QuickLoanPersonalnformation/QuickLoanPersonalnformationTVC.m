//
//  QuickLoanPersonalnformationTVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/15.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "QuickLoanPersonalnformationTVC.h"

@interface QuickLoanPersonalnformationTVC ()
@property (strong, nonatomic) IBOutlet UITableView *TableV_frame;
@property (strong, nonatomic) UIButton *btn;
@property (strong , nonatomic) UIView *view_button;
@property CGFloat view_button_y;

@end

@implementation QuickLoanPersonalnformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _view_button_y=(CGRectGetMaxY(self.TableV_frame.frame)-60);
    
    self.view_button=[[UIView alloc]initWithFrame:CGRectMake(self.TableV_frame.frame.origin.x,_view_button_y, self.TableV_frame.frame.size.width, 60)];
    NSLog(@"%f",_view_button_y);
    
    self.view_button.backgroundColor=[UIColor colorWithRed:231/255.0 green:229/255.0 blue:234/255.0 alpha:0.5];
    
    
    
    if (self.view.frame.size.height<569) {
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)/4, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+4)];
        
    }else if(self.view.frame.size.height<668){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-70, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)-12)];
        
    }else if(self.view.frame.size.height<737){
        
        self.btn=[[UIButton alloc]initWithFrame:CGRectMake(10,(self.view_button.frame.size.height-self.btn.frame.size.width)-105, self.view_button.frame.size.width-20, (self.view_button.frame.size.height-self.btn.frame.origin.y)/2+15)];
        
    }
    
    [self.btn setTitle:@"保存" forState:UIControlStateNormal];
    
    UIImage *imag=[UIImage imageNamed:@"enniuzhengchang2x_03"];
    
    [self.btn setBackgroundImage:imag forState:UIControlStateNormal];
    [self.view_button addSubview:self.btn];
    
    [self.TableV_frame addSubview:self.view_button];
    
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
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
