//
//  MainVC.h
//  借贷宝
//
//  Created by imac21 on 15/7/5.
//  Copyright (c) 2015年 imac21. All rights reserved.
//

#import "BaseVC.h"
#import "JCTopic.h"

@protocol MainVCDelegate <NSObject>

@optional
- (void)showLeftVC;
- (void)showMainVC;

@end


@interface MainVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,strong)JCTopic * Topic;
@property (nonatomic, copy)   NSString *zxnr1;

@property (nonatomic, retain) id<MainVCDelegate> delegate;

@end
