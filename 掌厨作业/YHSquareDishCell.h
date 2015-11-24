//
//  YHSquareDishCell.h
//  掌厨作业
//
//  Created by MS on 15-9-3.
//  Copyright (c) 2015年 ZYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSharedDish.h"
#import "UIImageView+WebCache.h"
#import "YHComment.h"

@interface YHSquareDishCell : UICollectionViewCell

@property (nonatomic, strong)YHSharedDish *sharedDish;

+ (id)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
