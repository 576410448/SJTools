//
//  SJSDWebImageActivity.h
//  ROMEO
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//
//  小菊花懒加载模式

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SJSDWebImageActivity : NSObject

+ (id)SJActivityManager;

+ (void)SJImageView:(UIImageView *)imageView sd_setImageWithURL:(NSURL *)url;

- (void)SJImageView:(UIImageView *)imageView sd_setImageWithURL:(NSURL *)url;

@end
