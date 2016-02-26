//
//  LeftEnrollVC.h
//  短借宝
//
//  Created by iMac21 on 15/7/20.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "BaseVC.h"
@class LeftEnrollVC;

@protocol phoneDelegate <NSObject>


@optional

-(void)name:(NSString *)name password:(NSString *)password;

@end

@interface LeftEnrollVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *NumTF;
@property (weak, nonatomic) IBOutlet UITextField *ShenFenZhengHao;

@property (nonatomic,retain)id<phoneDelegate>delegate;

@end
