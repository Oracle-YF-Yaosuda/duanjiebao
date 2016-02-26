//
//  ContactViewDataSource.h
//  ContactDome
//
//  Created by dujiepeng on 13-2-27.
//  Copyright (c) 2013年 dujiepeng. All rights reserved.
//
#import "TableReloadDelegate.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ContactViewDataSource : NSObject<UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray * PersonAry ;
@property (nonatomic,retain) NSMutableDictionary * SectionDict ;
@property (nonatomic,retain) NSMutableArray * SectionMutableAry;
@property (nonatomic,assign) NSObject<TableReloadDelegate> * delegate;
-(void) loadTable;
+(ContactViewDataSource *)getDatasource;
@end
