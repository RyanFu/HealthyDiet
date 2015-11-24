//
//  YHAboutMeCell.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHAboutMeCell.h"

@interface YHAboutMeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation YHAboutMeCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMyItem:(YHMyItem *)myItem {
    self.iconImageView.image = [UIImage imageNamed:myItem.icon];
    self.titleLabel.text = myItem.title;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

// 注册Cell
+ (id)cellWithTabelView:(UITableView *)tableView {
    
    NSString *Identifier = NSStringFromClass([self class]);
    
    UINib *nib = [UINib nibWithNibName:Identifier bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:Identifier];
    
    return [tableView dequeueReusableCellWithIdentifier:Identifier];
}

@end
