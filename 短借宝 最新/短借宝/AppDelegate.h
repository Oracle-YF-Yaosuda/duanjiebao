//
//  AppDelegate.h
//  借贷宝
//
//  Created by imac21 on 15/7/5.
//  Copyright (c) 2015年 imac21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MacroUtil.h"
#import "AFNetworking.h"
#import "CommonMethod.h"
#import "WXApi.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{
    BOOL bo;
}

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic) BOOL bo;/**
 * 自定义属性
 */

//
@property (retain, nonatomic) AFHTTPRequestOperationManager *HTTPManager;
/**
 *  网络请求都用这个
 */
@property (assign, nonatomic) BOOL isLogin;
/**
 * 用户是否登录
 */
@property (copy  , nonatomic) NSString *deviceType;
/**
 * 设备类型
 */

@end

