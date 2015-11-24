//
//  YHSharedDish.m
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHSharedDish.h"

@implementation YHSharedDish

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *comments = [NSMutableArray array];
        
        NSArray *array = [dict objectForKey:@"comments"];
        
        for (NSDictionary *dic in array) {
            YHComment *comment = [[YHComment alloc] initWithDict:dic];
            [comments addObject:comment];
        }
        
        _comments = comments;

    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}



@end
