//
//  HMContact.h
//  New Addbooks
//
//  Created by iMac21 on 15/7/22.
//  Copyright (c) 2015年 iMac21. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMContact : NSObject
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *num;

+ (instancetype)contactWithName:(NSString *)name num:(NSString *)num;

@end
