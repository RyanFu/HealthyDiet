//
//  YHDishDetailHeaderView.m
//  掌厨作业
//
//  Created by MS on 15-9-21.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHDishDetailHeaderView.h"

@interface YHDishDetailHeaderView ()


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end


@implementation YHDishDetailHeaderView

+ (instancetype)headerView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameLabel.text = name;
    
}

- (void)setIconImageName:(NSString *)iconImageName {
    _iconImageName = iconImageName;
    UIImage *image = [UIImage imageNamed:iconImageName];
    self.iconImageView.image = image;
}


@end
