//
//  QuickLoanBankCardInformationTVC.m
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/15.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "QuickLoanBankCardInformationTVC.h"
#import "IGLDropDownMenu.h"

@interface QuickLoanBankCardInformationTVC ()<IGLDropDownMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *cell_yinhNGK;

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;

@property (weak, nonatomic) IBOutlet UITextField *bank;


@end

@implementation QuickLoanBankCardInformationTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *dataArray = @[@{@"image":@"",@"title":@"中国工商银行"},
                           @{@"image":@"",@"title":@"中国农业银行"},
                           @{@"image":@"",@"title":@"中国建设银行"},
                           @{@"image":@"",@"title":@"中国银行"},
                           @{@"image":@"",@"title":@"中国交通银行"},@{@"image":@"",@"title":@"邮政储蓄银行"},];
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArray.count; i++) {
        NSDictionary *dict = dataArray[i];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
        [item setText:dict[@"title"]];
        [dropdownItems addObject:item];
    }
    
    //    demo
    self.dropDownMenu = [[IGLDropDownMenu alloc] init];
    self.dropDownMenu.menuText = @"中国工商银行";
    self.dropDownMenu.dropDownItems = dropdownItems;
    self.dropDownMenu.paddingLeft =15;
//    位置
//    self.dropDownMenu.frame=self.bank.frame;
   
    
    [self.dropDownMenu setFrame:CGRectMake(self.bank.frame.origin.x, self.cell_yinhNGK.frame.origin.y, self.bank.frame.size.width, self.cell_yinhNGK.frame.size.height)];
    
//    代理
    self.dropDownMenu.delegate = self;
    
    [self setUpParamsForDemo4];
    
    
    [self.dropDownMenu reloadView];
    
    [self.view addSubview:self.dropDownMenu];
    
    
    
}

- (void)setUpParamsForDemo4
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
    
    
    self.dropDownMenu.flipWhenToggleView = YES;
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
    return 3;
}
//    代理
- (void)selectedItemAtIndex:(NSInteger)index
{
//    IGLDropDownItem *item = self.dropDownMenu.dropDownItems[index];
//    取值
    
//    self.bank.text = [NSString stringWithFormat:@"Selected: %@", item.text];
    
    

    
    
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
