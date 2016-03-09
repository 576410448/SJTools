//
//  SJSDWebImageActivity.m
//  ROMEO
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//
//  小菊花懒加载模式

#import "SJSDWebImageActivity.h"
#import <UIKit/UIKit.h>
#import "PCAngularActivityIndicatorView.h"
#import "UIImageView+WebCache.h"

@implementation SJSDWebImageActivity

+(id)SJActivityManager{
    
    static SJSDWebImageActivity *_s = nil;
    if (!_s) {
        _s = [[SJSDWebImageActivity alloc] init];
    }
    return _s;
}

+ (void)SJImageView:(UIImageView *)imageView sd_setImageWithURL:(NSURL *)url{
    [[SJSDWebImageActivity SJActivityManager] SJImageView:imageView sd_setImageWithURL:url];
}

- (void)SJImageView:(UIImageView *)imageView sd_setImageWithURL:(NSURL *)url{
    
    __block PCAngularActivityIndicatorView * indicatorPlaceholder ;
    
    [imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //创建指示器:必须放在线程内才不会报错
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(!indicatorPlaceholder){
                
                [imageView addSubview:indicatorPlaceholder = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleSmall]];
                
                indicatorPlaceholder.center = imageView.center;
                
                [indicatorPlaceholder startAnimating];
                
            }
            
        });
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //如果图片未缓存  渐现效果
        
        if (cacheType == SDImageCacheTypeNone) {
            
            imageView.alpha = 0;
            
            [UIView animateWithDuration:0.48  animations:^{
                
                imageView.alpha = 1.0;
                
            }];
            
        }
        
        // 消除指示器
        
        if (indicatorPlaceholder) {
            
            for (UIView *view in imageView.subviews) {
                [view removeFromSuperview];
            }
            
        }
        
    }];
    
}

@end
