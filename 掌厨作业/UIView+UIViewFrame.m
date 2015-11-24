//
//  UIView+UIViewFrame.m
//  美食圈圈
//
//  Created by MS on 15-8-14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIView+UIViewFrame.h"

@implementation UIView (UIViewFrame)


- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x  = x;
    self.frame = rect;
}

-(CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}



@end
