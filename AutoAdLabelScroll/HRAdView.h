//
//  HRAdView.h
//  AutoAdLabelScroll
//
//  Created by 陈华荣 on 16/4/6.
//  Copyright © 2016年 陈华荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRAdView : UIView
/**
 *  广告内容数组
 */
@property (nonatomic, copy) NSArray *adTitles;

/**
 * 头部图片 默认为nil
 */

@property (nonatomic, strong) UIImage *headImg;

/**
 *  广告字体 默认为16号系统字体
 */
@property (nonatomic, strong) UIFont *labelFont;
/**
 *  广告字体颜色  默认为黑色
 */
@property (nonatomic, strong) UIColor *color;

/**
 *  轮播时间间隔 默认2s
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 *  是否含有Img头 默认为NO
 */
@property (nonatomic, assign) BOOL isHaveHeadImg;

/**
 *  是否开启点击事件 默认为NO
 */
@property (nonatomic, assign) BOOL isHaveTouchEvent;

/**
 *  点击事件响应
 */
@property (nonatomic, copy) void (^clickAdBlock)(NSUInteger index);
/**
 *  文本对齐方式
 */

@property (nonatomic, assign) NSTextAlignment textAlignment;


/**
 *  开始轮播
 */
- (void)beginScroll;

/**
 *  关闭轮播
 */

- (void)closeScroll;


/**
 *  实例化方法
 */

- (instancetype)initWithTitles:(NSArray *)titles;
@end
