//
//  CommonMethod.m
//  WMYRiceNoodles
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod : NSObject

+ (void)callPhone:(NSString *)phoneNumber superView:(UIView *)view
{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webview];
}

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
    
    [button setImage:[UIImage imageNamed:disableImageUrl]
            forState:UIControlStateDisabled];
}


+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
}


+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
        selectedImage:(NSString *)selectedImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:selectedImageUrl]
            forState:UIControlStateSelected];
}


+ (void)hiddleExtendCellFromTableview:(UITableView *)tableview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableview setTableFooterView:view];
}


+ (void)settingBackButtonImage:(NSString *)imagename andSelectedImage:(NSString *)selImagename
{
    UIImage* backImage = [[UIImage imageNamed:imagename]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(30, 0, -30, 0)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefaultPrompt];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, -1000)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
}



+ (void)settingBackButtonImage:(NSString *)imagename
                 selectedImage:(NSString *)selectedImagename
                  andContrller:(UIViewController *)controller
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imagename]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImagename]
            forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToFather:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *mybuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    controller.navigationItem.leftBarButtonItem = mybuttonItem;
}
+ (void)backToFather:(UIButton *)sender
{
    UINavigationBar *navigationBar = (UINavigationBar *)sender.superview;
    UINavigationController *nc = (UINavigationController *)[self GetViewController:navigationBar];
    [nc popViewControllerAnimated:YES];
}
+ (UIViewController*)GetViewController:(UIView*)uView
{
    for (UIView* next = [uView superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


+ (CGFloat)checkSystemVersion
{
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}

+ (NSString *)checkAPPVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    return appVersion;
}

+(NSDictionary* )getUserInfoDict
{
    
    NSUserDefaults *loginDefault = [NSUserDefaults standardUserDefaults];
    
    //获取历史登录账号
    NSDictionary *UserInfoDic=@{
                                @"code":[self fuckNULL:[loginDefault objectForKey:@"code"]],
                                @"message":[self fuckNULL:[loginDefault objectForKey:@"message"]],
                                @"sessionKey":[self fuckNULL:[loginDefault objectForKey:@"sessionKey"]],
                                @"u_id":[self fuckNULL:[loginDefault objectForKey:@"u_id"]]
                                };
    
    return UserInfoDic;
}

+ (NSString*)fuckNULL:(NSObject*)obj
{
    if (obj == nil || [obj isKindOfClass:[NSNull class]])
    {
        return @"";
        
    }else if ([obj isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if(![obj isKindOfClass:[NSString class]])
    {
        return @"";
    }else if ([obj isKindOfClass:[NSString class]])
    {
        if ([(NSString *)obj isEqualToString:@"<null>"])
        {
            return @"";
            
        }else if ([(NSString *)obj isEqualToString:@"null"])
        {
            return @"";
        }else
        {
            return [NSString stringWithFormat:@"%@",obj];
        }
        
    }else
    {
        return @"";
    }
    
}


+(int)findStrIndex:(NSString *)findStr fromString:(NSString *)sourceStr
{
    NSRange range = [sourceStr rangeOfString:findStr];
    
    return (int)range.location;
}


+ (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    
    return timeNow;
}


+ (NSString *)getTimeFromTimeInterval:(double)timeInterval
{
    
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    date = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval] ];
    
    NSString *timeAfter = [[NSString alloc] initWithFormat:@"%@", date];
    
    return timeAfter;
    
}

//  在 view 的指定位置加指定颜色的线
+ (UIView *) initLineInView:(UIView *)aView
                  withColor:(UIColor *)color
                   AndFrame:(CGRect)frame
{
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = color;
    line.frame = frame;
    [aView addSubview:line];
    return line;
}


#pragma mark 匹配账户合法性(3_16位_字母数字和下划线的组合)

//验证用户输入不能为空
+(BOOL)checkUserInput:(NSString *)str
{
    if ([str length] == 0)
    {
        return NO;
    }
    
    int length = (int)[str stringByReplacingOccurrencesOfString:@" " withString:@""].length;
    
    if (length==0)
    {
        return NO;
    }
    
    return YES;
}

//验证用户名
+(BOOL)checkUserNameIsRight:(NSString *)str
{
    if ([str length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{3,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}


//验证密码
+(BOOL)checkPassWordIsRight:(NSString *)str
{
    if ([str length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^[a-zA-Z0-9_]{6,17}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证一卡通
+(BOOL)checkOneCardWithRegex:(NSString *)OneCard
{
    if ([OneCard length] == 0)
    {
        return NO;
    }
    
    //    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    
    NSString *regex = @"[0-9]{19}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:OneCard];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
    
}

//验证验证码格式
+(BOOL)checkVerifyCode:(NSString *)verifyCode
{
    if ([verifyCode length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:verifyCode];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
    
}



//验证手机格式
+ (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}

//验证邮箱
+(BOOL)checkEmailWithRegex:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}








//滑动到最后一行
+(void)scrollTableToFootWithTableView:(UITableView *) tableView isAnimated:(BOOL)animated
{
    NSInteger s = [tableView numberOfSections];
    if (s<1) return;
    NSInteger r = [tableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}


+(void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)color ForView:(UIView *)aview
{
    
    aview.layer.cornerRadius = radius;
    aview.layer.borderColor = [color CGColor];
    
    if (radius > 0)
    {
        aview.layer.masksToBounds = YES;
        aview.layer.borderWidth = 1;
    }
    else
    {
        aview.layer.masksToBounds = NO;
        aview.layer.borderWidth = 0;
    }
}


+ (NSInteger)ChineseNumberInString:(NSString *)str
{
    int j = 0 ;
    
    for(int i = 0; i < [str length]; i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            j++;
    }
    return j;
}

+(void)cleanSubViewsInSuperView:(UIView *)superView
{
    
    //依次遍历self.view中的所有子视图
    for(id tmpView in superView.subviews)
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIView class]])
        {
            [tmpView removeFromSuperview];
        }
    }
    
    
}



//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}




//消息推送是否开启
+ (BOOL)isAllowedNotification
{
    //iOS8 check if user allow notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
    {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types)
        {
            return YES;
        }
    } else
    {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}

+(NSString *)starForTel:(NSString *)tel
{
    //新建一个字符串
    NSString *star = @"****";
    NSString *prefix = [tel substringToIndex:3];
    NSString *suffix = [tel substringFromIndex:7];
    NSString *starTel = [NSString stringWithFormat:@"%@%@%@",prefix,star,suffix];
    
    return starTel;
    
}

+(CGFloat)heightForLabel:(UILabel *)label
                WithText:(NSString *)text
                fontName:(NSString *)fontName
                fontSize:(CGFloat)fontSize
                   width:(CGFloat)width
{
    if (!text)
    {
        return 0;
    }else
    {
        if (!fontName)
        {
            //系统默认的字体
            fontName = @"Helvetica";
        }
        
        //创建字体信息
        UIFont *textFont = [UIFont fontWithName:fontName size:fontSize];
        //字体字典信息
        NSDictionary *fontDict =[NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
        
        //设置label的属性
        label.frame = CGRectMake(width/2, 0, width, 0);
        label.numberOfLines = 0 ;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.backgroundColor = [UIColor clearColor];
        label.font = textFont;
        
        
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:fontDict
                                         context:nil];
        
        return rect.size.height+10;
        
    }
    
}











@end
