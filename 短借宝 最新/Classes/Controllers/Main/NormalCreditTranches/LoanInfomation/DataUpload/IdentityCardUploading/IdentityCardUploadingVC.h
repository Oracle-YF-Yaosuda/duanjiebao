//
//  IdentityCardUploadingVC.h
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/14.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "BaseVC.h"
@protocol tupianDelegate1 <NSObject>

@optional

-(void)tu1;

@end

@interface IdentityCardUploadingVC : BaseVC

@property (nonatomic,strong)NSString *fileData;

@property (strong, nonatomic)UIImageView *photo;

@property (strong, nonatomic)UIButton *anniu;

@property (retain ,nonatomic)id<tupianDelegate1>delegate;

@end
