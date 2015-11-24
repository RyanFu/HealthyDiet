//
//  Advertisement.h
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Advertisement : NSObject

@property(nonatomic, strong)NSString *ID;

@property(nonatomic, strong)NSString *imageFilename;

@property(nonatomic, strong)NSString *type;

@property(nonatomic, strong)NSString *enjoyVideoUrl;

@property(nonatomic, strong)NSString *videoImageFilename1;

@property(nonatomic, strong)NSString *videoImageFilename2;

- (id)initWithDict:(NSDictionary *)dict;

@end
