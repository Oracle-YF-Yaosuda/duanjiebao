//
//  JCTopic.h
//  PSCollectionViewDemo
//
//  Created by jc on 14-1-7.
//
//

#import <UIKit/UIKit.h>
@protocol JCTopicDelegate<NSObject>
-(void)didClick:(int)data;
-(void)currentPage:(int)page total:(NSUInteger)total;
@end
@interface JCTopic : UIScrollView<UIScrollViewDelegate>{
    UIButton * pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;
    int currentPage;
    CGSize imageSize;
    UIImage *image;
}
@property(nonatomic,strong)NSMutableArray * pics;
@property(nonatomic,retain)id<JCTopicDelegate> JCdelegate;
-(void)releaseTimer;
-(void)upDate;
@end
