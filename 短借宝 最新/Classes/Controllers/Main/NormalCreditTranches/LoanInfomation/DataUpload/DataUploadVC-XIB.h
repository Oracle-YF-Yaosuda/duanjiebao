//
//  DataUploadVC-XIB.h
//  短借宝
//
//  Created by Mr.于小秋 on 15/7/13.
//  Copyright (c) 2015年 com.appleyf. All rights reserved.
//

#import "BaseVC.h"

//#define   BASE_URL   @"http://app.djjrfw.com/"
#define   BASE_URL   @"http://192.168.1.125:8686/djbglxt/"

@protocol hideDelegate2 <NSObject>

@optional

-(void)hid2;

@end

@interface DataUploadVC_XIB : BaseVC
@property (retain ,nonatomic)id<hideDelegate2>delegate;

@end
