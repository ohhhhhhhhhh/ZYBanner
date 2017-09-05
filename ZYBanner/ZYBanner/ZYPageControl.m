//
//  ZYPageControl.m
//  ZYBanner
//
//  Created by zy on 2017/9/5.
//  Copyright © 2017年 zy. All rights reserved.
//

#import "ZYPageControl.h"

@implementation ZYPageControl

//-(instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        [self setValue:[UIImage imageNamed:@"blue"] forKey:@"_currentPageImage"];
//        [self setValue:[UIImage imageNamed:@"green"] forKey:@"_pageImage"];
//    }
//    return self;
//}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < self.subviews.count; subviewIndex++) {
        
        if (subviewIndex == currentPage) {
            
            UIImageView * imageV = [self.subviews objectAtIndex:subviewIndex];
            CGRect rect = imageV.frame;

            rect.size.height = 10;
            rect.size.width  = 10;
            
            imageV.frame = rect;
        }
    }
}

@end
