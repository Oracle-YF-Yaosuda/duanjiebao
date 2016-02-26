//
//  ContactViewDataSource.m
//  ContactDome
//
//  Created by dujiepeng on 13-2-27.
//  Copyright (c) 2013年 dujiepeng. All rights reserved.
//

#import "ContactViewDataSource.h"
#import "ContactReadTool.h"
#import "ContactModel.h"

static ContactViewDataSource * datasource = nil;


@implementation ContactViewDataSource
@synthesize PersonAry,SectionDict,SectionMutableAry;
@synthesize delegate;

+(ContactViewDataSource *)getDatasource{
    if (datasource == nil) {
        datasource = [[self alloc] init];
    }
    
    
    return datasource;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.PersonAry = [[NSMutableArray alloc] init];
        self.SectionMutableAry = [[NSMutableArray alloc] init];
        self.SectionDict = [NSMutableDictionary dictionary];
    }
    [self ThreadOnLoadTable];
    return self;
}

-(void) ThreadOnLoadTable{
    [NSThread detachNewThreadSelector:@selector(loadTable) toTarget:self withObject:nil];
}


-(void) loadTable{
    ContactReadTool * readTool = [ContactReadTool getContactReadTool];
    [readTool reReadContact];
    self.SectionDict = [[NSMutableDictionary alloc] init];
    self.SectionMutableAry = [[NSMutableArray alloc] init];
    self.PersonAry = readTool.PersonAry;
    self.PersonAry = (NSMutableArray *)[self.PersonAry sortedArrayUsingComparator:^NSComparisonResult(ContactModel *obj1, ContactModel *obj2) {
        return [obj1.PersonNameFirstLetter compare:obj2.PersonNameFirstLetter];
    }];
    
    for (ContactModel * contactModel in PersonAry) {
        
//        NSLog(@"sec--%@",SectionDict);
        
        NSMutableArray* section = [SectionDict objectForKey:contactModel.PersonNameFirstLetter];
        if (!section) {
            section = [[NSMutableArray alloc] init];
            [SectionDict setObject:section forKey:contactModel.PersonNameFirstLetter];
            [self.SectionMutableAry addObject:contactModel.PersonNameFirstLetter];
        }
        [section addObject:contactModel];
    }
    [self performSelectorOnMainThread:@selector(UpData) withObject:self waitUntilDone:YES];
    
}

-(void)UpData{
    [self.delegate reload];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:reuseID];
    }
    
    NSArray * sectionOfCellAry;
    
    if ([SectionMutableAry count]>0)
    sectionOfCellAry= [self.SectionDict objectForKey:[self.SectionMutableAry objectAtIndex:[indexPath section]]];
    
//         NSLog( @"--%@",self.SectionDict);
    
    ContactModel  * model;
    
    if ([sectionOfCellAry count]>0) 
    
    model= [sectionOfCellAry objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = model.PersonName;
    
 
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[model.PhoneLabelAry[0] phoneNum]];
    
    if ([model.PersonImageData bytes] != 0 ) {
        cell.imageView.image = [UIImage imageWithData:model.PersonImageData];
    }else{
        //设置无头像时显示的图标
        cell.imageView.image = [UIImage imageNamed:@"aaa.png"];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * sectionInfoAry;
    
    if ([sectionInfoAry count]>0){
    sectionInfoAry= [self.SectionDict objectForKey:[self.SectionMutableAry objectAtIndex:section]];
    
        return [sectionInfoAry count];}
    
    else
        
        return 0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [[SectionDict allKeys] count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.SectionMutableAry count]>0)
    return [self.SectionMutableAry objectAtIndex:section];
    
    else
        
        return 0;
}

#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.SectionMutableAry;
}

@end
