//
//  GPTabbar.m
//  02-自定义TabBar
//
//  Created by MS on 15-8-12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPTabbar.h"

@implementation GPTabbar


+ (id)tabbar {
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setItems:(NSArray *)items {
    // 1.保存全局变量
    _items = items;
    // 2.把数组内部的控件, 全部添加到自己内部去
    CGFloat btnW = self.frame.size.width / items.count;
    for (int i = 0; i < items.count; i++) {
        UIButton *btn = items[i];
        [self addSubview:btn];
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        CGFloat btnH = self.frame.size.height;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnTount:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        
    }
    
    // 默认点击第一个 item
    [self btnTount:self.items[0]];
}



- (void)btnTount:(UIButton *)btn {
    
    if (btn.selected == YES) {
        return;
    }
    
    for (UIButton *tmp in self.items) {
        tmp.selected = NO;
    }
    
    btn.selected = YES;
    [_delegate tabbarItemSelected:self andItem:btn andIndex:btn.tag];
}

// UIView的生命周期函数
// 当自己即将被添加到父视图上的时候会自动的被系统调用
// 在这个生命周期函数中去设置自己的frame比较合适, 因为往往自己的位置都要参考父视图来设置, newSuperview 就是父视图指针地址
- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    // 1.首先设置自己的frame
    CGFloat selfW = newSuperview.frame.size.width;
    CGFloat selfH = 49;
    CGFloat selfX = 0;
    CGFloat selfY = newSuperview.frame.size.height - selfH;
    
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor colorWithRed:0.45f green:0.44f blue:0.44f alpha:1.00f];
}
@end
