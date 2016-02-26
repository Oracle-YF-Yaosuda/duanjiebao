//
//  CommonMethod.h
//  WMYRiceNoodles
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * @brief           公用方法类
 *
 *                  封装了一些常用方法
 * @author          xiaog
 * @version         0.1
 * @date            2012-12-18
 * @since           2012-12 ~
 */
@interface CommonMethod : NSObject



+ (void)settingBackButtonImage:(NSString *)imagename
                 selectedImage:(NSString *)selImagename
                  andContrller:(UIViewController *)controller;

/**
 *	@brief	在应用内拨打电话
 *
 *	@param 	phoneNumber 	电话号码
 *	@param 	view 	调用controller的view
 */
+ (void)callPhone:(NSString *)phoneNumber
        superView:(UIView *)view;


/**
 *	@brief	设置按钮的image或者backgroundImage
 *
 *	@param 	button 	按钮
 *	@param 	imageUrl 	正常状态的图片名称
 *	@param 	highLightImageUrl 	高亮状态的图片名称
 */
+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl;

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl;

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (CGFloat)checkSystemVersion;


/**
 *	@brief	判断应用的版本号
 *
 *	@return	返回版本号
 */
+ (NSString *)checkAPPVersion;



/**
 *	@brief	隐藏tableivew中多余的cell
 *
 *	@param 	tableview 	承载的Tableview
 */
+ (void)hiddleExtendCellFromTableview:(UITableView *)tableview;


/**
 *	@brief	给应用提供统一的返回按钮样式
 *
 *  图片尺寸是 40*40 80*80
 *	@param 	imagename 	正常状态时的图片名称
 *	@param 	selImagename 	高亮时候的状态名称
 */
+ (void)settingBackButtonImage:(NSString *)imagename andSelectedImage:(NSString *)selImagename;

/**
 *	@brief	获取用户名登录信息
 *
 *	@param
 */
+(NSDictionary* )getUserInfoDict;

/**
 *	@brief	处理null字符串
 *
 *	@param
 */
+ (NSString*)fuckNULL:(NSObject*)obj;

/**
 *	@brief	字符串查找函数,返回查找函数的第一次出现的位置的索引值
 *
 *	@param
 */
+(int)findStrIndex:(NSString *)findStr fromString:(NSString *)sourceStr;


/**
 *	@brief	根据当前的系统时间返回yy-mm-dd格式的字符串
 *
 *	@param
 */
+(NSString *)getTimeNow;

/**
 *	@brief	根据当前的系统时间,和延后时间,返回yy-mm-dd格式的字符串
 *
 *	@param
 */
+ (NSString *)getTimeFromTimeInterval:(double)timeInterval;


//  在 view 的指定位置加指定颜色的线
+ (UIView *) initLineInView:(UIView *)aView
                  withColor:(UIColor *)color
                   AndFrame:(CGRect)frame;


/**
 *  检测用户名格式
 *
 *  @param str 字符串
 *
 *  @return bool
 */

+(BOOL)checkUserInput:(NSString *)str;

+(BOOL)checkUserNameIsRight:(NSString *)str;

+(BOOL)checkPassWordIsRight:(NSString *)str;

+(BOOL)checkOneCardWithRegex:(NSString *)OneCard;

+(BOOL)checkTel:(NSString *)str;

+(BOOL)checkEmailWithRegex:(NSString *)email;

+(BOOL)checkVerifyCode:(NSString *)verifyCode;





/**
 *  滑动到最后一行
 *
 *  @param tableView 目标tableView
 *  @param animated  是否显示动画
 */
+(void)scrollTableToFootWithTableView:(UITableView *) tableView isAnimated:(BOOL)animated;



/**
 *  设置圆角
 *
 *  @param radius 角度
 *  @param color  颜色
 *  @param aview  目标View
 */
+(void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)color ForView:(UIView *)aview;

/**
 *  包含汉字的个数
 *
 *  @param str
 *
 *  @return
 */
+ (NSInteger)ChineseNumberInString:(NSString *)str;


/**
 *  清理子视图
 *
 *  @param superView 父视图
 */
+(void)cleanSubViewsInSuperView:(UIView *)superView;


/**
 *  单个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 大小bit
 */
+ (long long) fileSizeAtPath:(NSString*) filePath;

/**
 *  整个文件夹的大小
 *
 *  @param folderPath 文件路径
 *
 *  @return 大小M
 */
+ (float ) folderSizeAtPath:(NSString*) folderPath;




//消息推送是否开启
+ (BOOL)isAllowedNotification;


/**
 *  给电话号加****
 *
 *  @param tel 电话号
 *
 *  @return 转换完的电话号
 */
+(NSString *)starForTel:(NSString *)tel;


/**
 *  自动计算label的高度(宽度可以传)
 */
+(CGFloat)heightForLabel:(UILabel *)label
                WithText:(NSString *)text
                fontName:(NSString *)fontName
                fontSize:(CGFloat)fontSize
                   width:(CGFloat)width;


@end

