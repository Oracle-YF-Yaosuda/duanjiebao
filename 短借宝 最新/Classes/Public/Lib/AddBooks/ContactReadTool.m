//
//  ContactReadTool.m
//  ContactDome
//
//  Created by dujiepeng on 13-2-27.
//  Copyright (c) 2013年 dujiepeng. All rights reserved.
//

#import "ContactReadTool.h"
#import "ContactModel.h"
#import "ChineseToPinyin.h"
#import "pinyin.h"
#import "JSONKit.h"

static ContactReadTool * readTool = nil;
@implementation ContactReadTool
@synthesize PersonAry;
@synthesize shoujihao;
+ (ContactReadTool *) getContactReadTool{
    if (readTool == nil) {
        readTool = [[self alloc ]init];
    }
    return readTool;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.PersonAry = [NSMutableArray array];
        
        self.shoujihao = [NSMutableArray array];
    
    }
    return self;
}
- (id)initk
{
    id tt = [super init];
    if (tt) {
       //shoujihao = [NSMutableArray array];
    }
    return tt;
}




//读取联系人，并装入联系人模型中
- (void)reReadContact{
    ABAddressBookRef abRef = nil;
    //IOS 6.0通讯录读取改变，判断版本后读取
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        abRef = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(abRef, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        abRef = ABAddressBookCreate();
    }
    NSMutableArray * contactMutableAry = (__bridge NSMutableArray *)  ABAddressBookCopyArrayOfAllPeople(abRef);
    [PersonAry removeAllObjects];
    for (int i = 0; i < [contactMutableAry count]; i++) {
        ABRecordRef person = (__bridge ABRecordRef)[contactMutableAry objectAtIndex:i];
        ContactModel * contactModel = [[ContactModel alloc] init];
        //ID
        contactModel.PersonID = (int)ABRecordGetRecordID(person);
        
        //name
        NSString *firstName, *lastName, *middleName,*fullName;
        NSString * sysFirstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if(nil != sysFirstName){
            firstName = sysFirstName;
        }else{
            firstName = @"" ;
        }
        NSString * sysMiddleName = (__bridge   NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
        if (nil != sysMiddleName) {
            middleName = sysMiddleName;
        }else {
            middleName = @"" ;
        }
        NSString * sysLastName = (__bridge   NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(nil != sysLastName){
            lastName = sysLastName;
        }else{
            lastName = @"";
        }
        fullName = [NSString stringWithFormat:@"%@%@%@",lastName,middleName,firstName];
        
        
        //首字母 和 姓名拼音
        NSString * FirstLetter = nil;
        NSString * NameLetter = nil;
        if (fullName.length == 0 || fullName == nil) {
            fullName = @"无姓名";
            NameLetter = @"";
            FirstLetter = @"#";
        }else {
            FirstLetter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([fullName characterAtIndex:0])] uppercaseString];
            NameLetter = [ChineseToPinyin pinyinFromChiniseString:fullName];
        }
        if (![self isValidateName:FirstLetter]) {
            FirstLetter = @"#";
        }
        contactModel.PersonName = fullName;
        contactModel.PersonNameFirstLetter = FirstLetter;
        contactModel.PersonNameLetter = NameLetter;
        //头像
        NSData *imageData = (__bridge NSData * )ABPersonCopyImageData(person);
        contactModel.PersonImageData = imageData;

        ABMultiValueRef phone =  (ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
        if ((phone != nil)&&ABMultiValueGetCount(phone)>0) {
            for (int m = 0; m < ABMultiValueGetCount(phone); m++) {
                //aPhone stringByReplacingOccurrencesOfString 返回一个autorelease对象，所以此处只能为它加Autorelease且添加释放池。
                NSString * aPhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, m);
                aPhone = [aPhone stringByReplacingOccurrencesOfString :@" " withString:@""];
                aPhone = [aPhone stringByReplacingOccurrencesOfString :@"(" withString:@""];
                aPhone = [aPhone stringByReplacingOccurrencesOfString :@")" withString:@""];
                aPhone = [aPhone stringByReplacingOccurrencesOfString :@"-" withString:@""];
                
                NSString * phoneLab = nil;
                NSString * aLabel = (__bridge NSString *)ABMultiValueCopyLabelAtIndex(phone, m);
                if ([aLabel isEqualToString:@"_$!<Mobile>!$_"]) {
                    phoneLab = @"移动电话";
                }
                else if([aLabel isEqualToString:@"_$!<Home>!$_"]){
                    phoneLab = @"住宅电话";
                }
                else if([aLabel isEqualToString:@"_$!<Work>!$_"]){
                    phoneLab = @"工作电话";
                }
                else if([aLabel isEqualToString:@"_$!<Main>!$_"]){
                    phoneLab = @"主要电话";
                }
                else if([aLabel isEqualToString:@"_$!<HomeFAX>!$_"]){
                    phoneLab = @"住宅传真";
                }
                else if([aLabel isEqualToString:@"_$!<WorkFAX>!$_"]){
                    phoneLab = @"工作传真";
                }
                else {
                    phoneLab = @"其他号码";
                }
                //aLabel 没有autorelease对象，所以可直接释放
                PhoneAndLabel * phoneRow = [[PhoneAndLabel alloc] init];
                phoneRow.phoneNum = aPhone;
//                NSLog(@"%@",phoneRow.phoneNum);
                
             
                
                NSDictionary *s=[NSDictionary dictionaryWithObjectsAndKeys:aPhone,@"lxrdh",contactModel.PersonName,@"lxrxm", nil];

                [self.shoujihao addObject:s];
                
                
                phoneRow.phoneLabel = phoneLab;
                [contactModel.PhoneLabelAry addObject:phoneRow];
            }
        }
        CFRelease(phone);
        [PersonAry addObject:contactModel];
       

    }
    CFRelease(abRef);
    NSLog(@"doContactRead is run !");
//    NSLog(@"%@",self.shoujihao);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
        [defaults setValue:self.shoujihao forKey:@"shooujihaoJSON"];

    
}

-(BOOL)isValidateName:(NSString *)name {
    NSString *nameRegex = @"[A-Z]";
    NSPredicate *namelTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [namelTest evaluateWithObject:name];
}

@end
