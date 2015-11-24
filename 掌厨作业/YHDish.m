//
//  YHDish.m
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDish.h"

@implementation YHDish

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *vegetableList = [NSMutableArray array];
        
        for (NSDictionary *dic in [dict objectForKey:@"vegetableList"]) {
            YHVegetable *vegetable = [[YHVegetable alloc] initWithDict:dic];
            [vegetableList addObject:vegetable];
            
        }
        _vegetableList = vegetableList;
        
    }
    return self;
}



@end
