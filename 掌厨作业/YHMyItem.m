//
//  YHMyItem.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHMyItem.h"

@implementation YHMyItem

- (id)initWithTitle:(NSString *)title icon:(NSString *)icon andType:(NSInteger)type {
    if (self = [super init]) {
        _title = title;
        _icon = icon;
        _type = type;
    }
    return self;
}

+ (id)myItemWithTitle:(NSString *)title icon:(NSString *)icon andType:(NSInteger)type {
    return [[self alloc] initWithTitle:title icon:icon andType:type];
}



@end
