//
//  YHVegetable.m
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHVegetable.h"

@implementation YHVegetable

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    NSLog(@"value:%@  key:%@", value, key);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@, imagePathThumbnails:%@, vegetable_id:%@",_name, _imagePathThumbnails, _vegetable_id];
}

@end
