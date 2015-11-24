//
//  YHSharedDish.h
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHComment.h"


@interface YHSharedDish : NSObject

// 时间
@property (nonatomic, strong)NSString *auditDate;
// 收藏数
@property (nonatomic, strong)NSString *collectionCount;
// 评论数
@property (nonatomic, strong)NSString *commentCount;
// 评论
@property (nonatomic, strong)NSArray *comments;
@property (nonatomic, strong)NSString *hotlist;
// 编号 id -> ID
@property (nonatomic, strong)NSString *ID;
// icon地址
@property (nonatomic, strong)NSString *imageFileName;
@property (nonatomic, strong)NSString *label;
@property (nonatomic, strong)NSString *lastReplayDate;
@property (nonatomic, strong)NSString *liked;
@property (nonatomic, strong)NSString *shareCount;
@property (nonatomic, strong)NSString *status;
// 标题
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *userId;
@property (nonatomic, strong)NSString *userName;
// 用户头像
@property (nonatomic, strong)NSString *userPortraitImageFileName;
@property (nonatomic, strong)NSString *video;
@property (nonatomic, strong)NSString *viewCount;


- (instancetype)initWithDict:(NSDictionary *)dict;


@end
