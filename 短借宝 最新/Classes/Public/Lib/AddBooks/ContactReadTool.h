//
//  ContactReadTool.h
//  ContactDome
//
//  Created by dujiepeng on 13-2-27.
//  Copyright (c) 2013年 dujiepeng. All rights reserved.
//

#import <AddressBook/AddressBook.h>
 #import <Foundation/Foundation.h>
#import "ContactModel.h"
@interface ContactReadTool : NSObject
@property (nonatomic,retain) NSMutableArray * PersonAry ;
@property (nonatomic,retain) NSMutableArray * shoujihao ;
@property (nonatomic,strong) ContactModel *phon;
+(ContactReadTool *) getContactReadTool;
- (void)reReadContact;

@end
