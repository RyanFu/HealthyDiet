//
//  YHComment.h
//  掌厨作业
//
//  Created by MS on 15-9-4.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHComment : NSObject

@property (nonatomic, strong)NSString *commentDate;

@property (nonatomic, strong)NSString *commentUserId;

@property (nonatomic, strong)NSString *content;

@property (nonatomic, strong)NSString *ID;

@property (nonatomic, strong)NSString *userName;

@property (nonatomic, strong)NSString *userPortraitImageFileName;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
