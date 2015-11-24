//
//  YHDish.h
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHVegetable.h"

@interface YHDish : NSObject
// 图片url
@property (nonatomic, strong)NSString *imageFilename;
// 名称
@property (nonatomic, strong)NSString *name;
// 类型
@property (nonatomic, strong)NSString *type;
// 菜List
@property (nonatomic, strong)NSArray *vegetableList;
// 播放时候的大图
@property (nonatomic, strong)NSString *imagePathThumbnails;
// 视频播放地址
@property (nonatomic, strong)NSString *materialVideoPath;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
