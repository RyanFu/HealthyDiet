//
//  GPTabbar.h
//  02-自定义TabBar
//
//  Created by MS on 15-8-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPTabbar;
@protocol GPTabbarDelegate <NSObject>

/**
 *  一旦点击了tabbarItem中的具体某一个按钮就会立即调用
 */
- (void)tabbarItemSelected:(GPTabbar *)tabbar andItem:(UIButton *)item andIndex:(int)index;

@end

@interface GPTabbar : UIView

/**
 *  传递进来的数组内的, 存储的一定是UIButton 对象
 */
@property(nonatomic, strong)NSArray *items;

@property(nonatomic, assign)id<GPTabbarDelegate>delegate;

/**
 *  返回一个GPTabbar对象
    通过用过alloc的方式创建
 *
 *  @return 
 */
+ (id)tabbar;

@end
