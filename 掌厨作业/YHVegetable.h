//
//  YHVegetable.h
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHVegetable : NSObject

// 图片url
@property (nonatomic, strong)NSString *imagePathThumbnails;

// 名称
@property (nonatomic, strong)NSString *name;

@property (nonatomic, strong)NSString *vegetable_id;

// 原料:描述
@property (nonatomic, strong)NSString *fittingRestriction;
// 调料:描述
@property (nonatomic, strong)NSString *method;

// 视频播放地址
@property (nonatomic, strong)NSString *materialVideoPath;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
