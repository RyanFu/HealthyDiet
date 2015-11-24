//
//  YHItemCell.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHItemCell.h"

@interface YHItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;


@end

@implementation YHItemCell

- (void)awakeFromNib {
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(YHItem *)item {
    
    self.titleLabel.text = item.title;
    self.iconImageView.image = [UIImage imageNamed:item.icon];
    if (item.type == 2) {
    
        // 计算hotImageView的位置
//        CGFloat hotImageX = 0;
//        CGFloat hotImageY = 0;
//        CGFloat hotImageW = item.title.length;
//        CGFloat hotImageH = 50;
//        self.hotImageView.frame = CGRectMake(hotImageX, hotImageY, hotImageW, hotImageH);
        self.hotImageView.hidden = NO;
    }else {
        self.hotImageView.hidden = YES;
    }

}

// 注册Cell
+ (id)cellWithTableView:(UITableView *)tableView {
    
    NSString *Identifier = NSStringFromClass([self class]);
    
    UINib *nib = [UINib nibWithNibName:Identifier bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:Identifier];
    
    return [tableView dequeueReusableCellWithIdentifier:Identifier];
}

@end
