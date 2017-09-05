//
//  ZYBanner.m
//  ZYBanner
//
//  Created by zy on 2017/9/5.
//  Copyright © 2017年 zy. All rights reserved.
//

#import "ZYBanner.h"
#import "ZYPageControl.h"

static int const ImageViewCount = 3;
@interface ZYBanner ()<UIScrollViewDelegate>

@property (nonatomic,  weak) UIScrollView * scrollV;

@property (nonatomic,  weak) ZYPageControl * pageC;

@property (nonatomic,  weak) NSTimer * timer;

@end

@implementation ZYBanner

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.scrollV.frame = self.bounds;
    self.scrollV.contentSize = CGSizeMake(ImageViewCount * self.scrollV.frame.size.width, 0);
    
    [self.scrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.frame = CGRectMake(idx * self.scrollV.frame.size.width, 0, self.scrollV.frame.size.width, self.scrollV.frame.size.height);
    }];
    
    CGFloat pageW = 80;
    CGFloat pageH = 40;
    CGFloat pageX = self.scrollV.frame.size.width - pageW;
    CGFloat pageY = self.scrollV.frame.size.height - pageH;
    self.pageC.frame = CGRectMake(pageX, pageY, pageW, pageH);
}

#pragma mark -set data
-(void)setImages:(NSArray *)images{
    
    _images = images;
    
    self.pageC.numberOfPages = images.count;
    self.pageC.currentPage   = 0;
    
    [self updateContent];
    
    [self startTimer];
}

#pragma mark -helper
- (void)updateContent{
    
    [self.scrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger page = self.pageC.currentPage;
        
        if (idx == 0) {
            page--;
        }else if (idx == 2){
            page++;
        }
        
        if (page < 0) {
            page = self.pageC.numberOfPages-1;
        }else if(page >= self.pageC.numberOfPages){
            page = 0;
        }
        
        obj.tag = page;
        obj.image = [UIImage imageNamed:self.images[page]];
    }];
    
    self.scrollV.contentOffset = CGPointMake(self.scrollV.frame.size.width, 0);
}

#pragma mark -<UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    __block NSInteger page = 0;
    __block CGFloat minDistance = MAXFLOAT;
    
    [self.scrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat distance = ABS(obj.frame.origin.x - self.scrollV.contentOffset.x);
        
        if (distance < minDistance) {
            minDistance = distance;
            page = obj.tag;
        }
    }];
    self.pageC.currentPage = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self startTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self updateContent];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self updateContent];
}

#pragma mark -timer
- (void)startTimer{
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)next{
    
    [self.scrollV setContentOffset:CGPointMake(2 * self.scrollV.bounds.size.width, 0) animated:YES];
}

#pragma mark -make ui
-(UIScrollView *)scrollV{
    
    if (!_scrollV) {
        
        UIScrollView * scroll = [[UIScrollView alloc]init];
        scroll.showsVerticalScrollIndicator   = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.pagingEnabled = YES;
        scroll.bounces = NO;
        scroll.delegate = self;
        for (int i = 0; i < ImageViewCount; i++) {
            UIImageView * imageV = [[UIImageView alloc]init];
            [scroll addSubview:imageV];
        }
        [self addSubview:scroll];
        _scrollV = scroll;
    }
    return _scrollV;
}

-(ZYPageControl *)pageC{
    
    if (!_pageC) {
        ZYPageControl * page = [[ZYPageControl alloc]init];
        page.hidesForSinglePage = YES;
        page.currentPageIndicatorTintColor = [UIColor redColor];
        page.pageIndicatorTintColor = [UIColor greenColor];
        [self insertSubview:page aboveSubview:self.scrollV];
        _pageC = page;
    }
    return _pageC;
}

@end
