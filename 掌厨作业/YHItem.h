//
//  YH.h
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHItem : NSObject

// 图标
@property (nonatomic, strong)NSString *icon;
// 标题
@property (nonatomic, strong)NSString *title;
// 种类
@property (nonatomic, assign)NSInteger type;

- (id)initWithTitle:(NSString *)title icon:(NSString *)icon andType:(NSInteger)type;

+ (id)itemWithTitle:(NSString *)title icon:(NSString *)icon andType:(NSInteger)type;

@end
