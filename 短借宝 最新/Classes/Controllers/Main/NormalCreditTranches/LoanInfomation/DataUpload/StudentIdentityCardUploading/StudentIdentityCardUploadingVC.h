//
//  StudentIdentityCardUploadingVC.h
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "BaseVC.h"
@protocol tupianDelegate2 <NSObject>

@optional

-(void)tu2;

@end

@interface StudentIdentityCardUploadingVC : BaseVC

@property (retain ,nonatomic)id<tupianDelegate2>delegate;

@end
