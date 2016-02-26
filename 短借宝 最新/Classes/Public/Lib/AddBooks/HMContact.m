//
//  HMContact.m
//  New Addbooks
//
//  Created by iMac21 on 15/7/22.
//  Copyright (c) 2015年 iMac21. All rights reserved.
//

#import "HMContact.h"

@implementation HMContact
// instancetype自动识别当前类的对象 == HMContact *
+ (instancetype)contactWithName:(NSString *)name num:(NSString *)num
{
    HMContact *contact = [[HMContact alloc] init];
    
    contact.name = name;
    contact.num = num;
//    NSLog(@"moxing%@ %@",name,num);
    
    return contact;
}

@end
