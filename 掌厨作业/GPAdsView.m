//
//  GPAdsView.m
//  美食圈圈
//
//  Created by MS on 15-8-14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GPAdsView.h"
#import "UIImageView+WebCache.h"

@interface GPAdsView ()<UIScrollViewDelegate>

@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UIPageControl *pageControl;
@property(nonatomic, weak)NSTimer *timer;
@end

@implementation GPAdsView

// 封装 UIView 的时候, 相关子控件的创建在哪里
// init 也会调用这里的方法, 所以写在这里比较合适
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.frame = self.bounds;
//        scrollView.backgroundColor = [UIColor redColor];
        self.scrollView =  scrollView;
        
        
        // 2.UIPageControler
        
        UIPageControl *pageControl = [[UIPageControl  alloc] init];
        [self addSubview:pageControl];
#warning 警告
        //pageControl.numberOfPages = self.images.count; //
        pageControl.currentPage = 0;
        pageControl.tintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        self.pageControl = pageControl;
        
    }
    return self;
}

+ (id)adsView {
    return [[self alloc] init];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    // 1.设置依赖于数据的一些属性
    self.pageControl.numberOfPages = images.count;
    
    // 2.ScrollView的 ContentSize
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * images.count, 0);
    
    // 3.给ScrollView添加子控件
    int i = 0;
    CGFloat imageW = self.scrollView.width;
    CGFloat imageH = self.scrollView.height;
    CGFloat imageY = 0;
    for (NSString *imageUrl in images) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSURL *url = [NSURL URLWithString:imageUrl];
        
        [imageView sd_setImageWithURL:url];
        
//        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"detail_comment"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//           
//           
//        }];
        [self.scrollView addSubview:imageView];
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);

//        NSLog(@"%f-%f", imageView.frame.size.width, imageView.frame.size.height);

        // 记得加手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(advertisementTouch:)];
        [imageView addGestureRecognizer:gesture];
        imageView.tag = i+100;
        i++;
    }
    
    
    [self startTimer];
}

/**
 *  广告点击事件
 *
 */
- (void)advertisementTouch:(UIGestureRecognizer *)gesture {
//    [_delegate adsViewDidSelected:self andImage:self.images[btn.tag] andIndex:btn.tag];
//    
//    if (self.adsViewDidSelected){
//        self.adsViewDidSelected(self,self.images[btn.tag], btn.tag);
//    }
//    NSLog(@"不要摸我");
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    // 1.设置自己的frame值
    CGFloat selfX = 0;
    CGFloat selfY = 0;
    CGFloat selfW = newSuperview.frame.size.width;
    CGFloat selfH = 220;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
//    self.backgroundColor = [UIColor yellowColor];
    
    // 2.子控件参考父控件设置 Frame 值
    self.scrollView.frame = self.bounds;
//    self.scrollView.backgroundColor = [UIColor redColor];
    
    // 3.设置pageControlerFrame 值
//    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width , 0);
    
    self.pageControl.width = self.width;
    self.pageControl.y = self.height - 40;
}

#pragma mark 业务逻辑辅助功能
// 自动滚动功能
- (void)autoScroll {
    // 字符串拼接消耗性能
    // 在一个实时调用的方法中不断去打印, 很有可能造成在真机上造成卡顿的原因
//    NSLog(@"翻滚");
#warning 真机卡顿的原因
    // 1.如何滚动
    // 2.如何控制 scrollView滚动到一个具体的位置
    
    int pageIndex = self.pageControl.currentPage >= self.images.count -1 ? 0 : (self.pageControl.currentPage + 1);
    
    self.scrollView.contentOffset = CGPointMake(pageIndex * self.scrollView.width, 0);
    
}

// 启动一个timer
- (void)startTimer {
    NSTimer *timer =  [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    self.timer = timer;
    
    // 将一个timer对象加入到最主要的事件循环中
    //    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark ScrollViewDelegatw
// 只要偏移量发生变化就会自动的调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffSet = scrollView.contentOffset;
    int page = (contentOffSet.x + 0.5 * scrollView.width)/ scrollView.width;
    self.pageControl.currentPage = page;
}

// 当即将手动拖动ScrollView 做滑动的时候
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // 取消timer事件
    // 取消Timer 当前正在执行的事件
    [self.timer invalidate];
}

// 完成了拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 重新启动timer事件
    // Timer 如果调用了invalidate之后, 就无法再重新启动这个事件, 必须再重新创建这个事件
    
    [self startTimer];
    
}

@end
