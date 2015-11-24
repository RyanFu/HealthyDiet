//
//  YHSquareDishCell.m
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import "YHSquareDishCell.h"

@interface YHSquareDishCell ()

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation YHSquareDishCell

- (void)awakeFromNib {
    self.iconImageView.layer.masksToBounds = YES;
    [self.iconImageView.layer setCornerRadius:15];
}

- (void)setSharedDish:(YHSharedDish *)sharedDish {
    
    // 头像图片
    NSURL *iconUrl = [NSURL URLWithString:sharedDish.userPortraitImageFileName];
    [self.iconImageView sd_setImageWithURL:iconUrl];
    
    // 菜的名字
    self.dishNameLabel.text = sharedDish.title;
    
    // 菜的图片
    NSURL *dishUrl = [NSURL URLWithString:sharedDish.imageFileName];
    [self.dishImageView sd_setImageWithURL:dishUrl];
    
    // 评论人+ 评论
#warning 现在值写一个人的评论 
    
    if (sharedDish.comments.count == 0) {
        self.commentLabel.text = @"快来些点什么吧";
    }else {
        YHComment *comment = sharedDish.comments[0];
        NSString *commentUserName = comment.userName;
        NSString *commentContent = comment.content;
        self.commentLabel.text = [NSString stringWithFormat:@"%@:%@",commentUserName, commentContent];
    }


}


// 注册CollectionViewCell
+ (id)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath {
    NSString *Identifier = NSStringFromClass([self class]);
    
   UINib *nib = [UINib nibWithNibName:Identifier bundle:nil]
    ;
    [collectionView registerNib:nib forCellWithReuseIdentifier:Identifier];
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath: indexPath];
    
}

@end
