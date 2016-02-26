//
//  ShenFenZhengFanMianVC.h
//  短借宝
//
//  Created by iMac21 on 15/8/25.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@protocol tupianDelegate4 <NSObject>

@optional

-(void)tu4;

@end
@interface ShenFenZhengFanMianVC : BaseVC
@property (nonatomic,strong)NSString *fileData;

@property (strong, nonatomic)UIImageView *photo;

@property (strong, nonatomic)UIButton *anniu;

@property (retain ,nonatomic)id<tupianDelegate4>delegate;

@end
