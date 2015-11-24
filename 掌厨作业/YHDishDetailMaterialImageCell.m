//
//  YHDishDetailMaterialImageCell.m
//  掌厨作业
//
//  Created by MS on 15-9-20.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDishDetailMaterialImageCell.h"

@interface YHDishDetailMaterialImageCell ()


@end

@implementation YHDishDetailMaterialImageCell

+ (instancetype)materialImageCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
