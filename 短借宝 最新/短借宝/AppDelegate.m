//
//  AppDelegate.m
//  借贷宝
//
//  Created by imac21 on 15/7/5.
//  Copyright (c) 2015年 imac21. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "EAIntroView.h"
#import "UMSocial.h"

#import "UMSocialWechatHandler.h"

#import "UMSocialQQHandler.h"
#import "APService.h"
#import "WXApi.h"



@interface AppDelegate ()<EAIntroDelegate>
@end

@implementation AppDelegate
@synthesize bo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    bo=NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"true"];
    
    self.window.backgroundColor = Color(0, 204, 176, 1);
    
    [self initPropertys];
    [self initTopLayout];
    
    application.applicationIconBadgeNumber = 0;
   
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
     [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
 
//    分享
    //    入口
    [UMSocialData setAppKey:@"56025bf7e0f55ab30c003242"];

    //   QQ
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.djjrfw.com"];
    //    微信
    [UMSocialWechatHandler setWXAppId:@"wx281bfa0afd7dad35" appSecret:@"1561f25515d63aea63bb14fc403fb7b2" url:@"http://www.djjrfw.com"];
    
    
    [WXApi registerApp:@"wx281bfa0afd7dad35"];
    
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];

//    极光推送
    
    // 设置应用程序能够接收APNS推送的消息
    // Required
    // 设置应用程序能够接收APNS推送的消息
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
//    application.applicationIconBadgeNumber = 1;
    //jpush en
    
    
    
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    

        [application registerUserNotificationSettings:notificationSettings];
        
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [APService handleRemoteNotification:userInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"newyouhui"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:nil];
 
    
    NSLog(@"--%@",userInfo);
    
    //    [self saveToDB:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [APService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken:%@",deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"erroe---%@",error);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [APService handleRemoteNotification:userInfo];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"newyouhui"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:nil];
}


//分享

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (application.applicationIconBadgeNumber>0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"newyouhui"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:nil];
        
    }
    
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
  
    
    [APService setTags:nil alias:nil callbackSelector:nil object:nil];
}


#pragma mark - 初始化自身属性
-(void)initPropertys
{
    //默认(从UD中读取上一次的信息),如果没有的话默认为NO
    self.isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    
    self.deviceType = @"iOS";
    //网络实例
    self.HTTPManager = [AFHTTPRequestOperationManager manager];
    self.HTTPManager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.HTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
}


- (void)initNavigationBar{
    
    UINavigationBar *bar = [[UINavigationBar alloc] init];
    [bar setBarTintColor:[UIColor whiteColor]];

}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
    // 图标上的数字减1
    
}
#pragma mark 设置顶部状态栏的属性 和  返回按钮
- (void) initTopLayout
{
    if (IOS7)
    {
        //[[UINavigationBar appearance]setBarTintColor:UIColorFromRGB(k_Color_Nav_Sel)];
        [[UINavigationBar appearance] setBarTintColor:Color(0, 204, 176, 1)];
        
        //  设置navigation bar上的主题颜色  21、52、107
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    
    //  设置navigation bar上的主题颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //设置导航栏字体属性
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"Helvetica-Bold" size:20], NSFontAttributeName,
                                                           nil]];
    //设置底部tabbar的颜色
    //    [[UITabBar appearance] setTintColor:UIColorFromRGB(k_Color_Tab_Sel)];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    //  设置状态栏上的主题颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [CommonMethod settingBackButtonImage:nil andSelectedImage:nil];
    
 
    
}
@end
