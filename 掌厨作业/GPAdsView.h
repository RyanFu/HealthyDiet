//
//  GPAdsView.h
//  美食圈圈
//
//  Created by MS on 15-8-14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+UIViewFrame.h"
@class GPAdsView;

@protocol GPAdsViewDelegate <NSObject>
/**
 *  当点击了某一张图片的时候就会调用该方法
 *
 *  @param adsView   adsView description
 *  @param imageName imageName description
 *  @param index     index description
 */
- (void)adsViewDidSelected:(GPAdsView *)adsView andImage:(NSString *)imageName andIndex:(NSInteger) index;

@end

typedef void(^adsViewDidSelected)(GPAdsView *adsView, NSString *image, NSInteger index);

@interface GPAdsView : UIView

/**
 *  数组中存储的是图片的名称
 */
@property(nonatomic, strong)NSArray *images;

@property(nonatomic, assign)id<GPAdsViewDelegate>delegate;

@property(nonatomic, copy)void(^adsViewDidSelected)(GPAdsView *adsView, NSString *image , NSInteger index);

+ (id)adsView;


@end
