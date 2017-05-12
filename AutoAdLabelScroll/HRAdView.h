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
 当前索引，无内容时为NSNotFound
 */
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

@property (nonatomic, strong, readonly) UIImageView *iconView;
/**
 * 头部图片 默认为nil
 */
@property (nonatomic, strong) UIImage *icon;
/**
 *  图片位置
 */
@property (nonatomic, assign) UIEdgeInsets iconInsets;
/**
 *  广告内容数组
 */
@property (nonatomic, strong) NSArray<NSString *> *texts;
/**
 *  广告字体颜色  默认为黑色
 */
@property (nonatomic, strong) UIColor *textColor;
/**
 *  广告字体 默认为16号系统字体
 */
@property (nonatomic, strong) UIFont *font;
/**
 文字行数
 */
@property (nonatomic, assign) NSInteger numberOfTextLines;
/**
 *  文本对齐方式
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;
/**
 文字边距
 */
@property (nonatomic, assign) UIEdgeInsets textInsets;
/**
 *  轮播时间间隔 默认2s
 */
@property (nonatomic, assign) NSTimeInterval duration;
/**
 滚动动画时长 默认1s
 */
@property (nonatomic, assign) NSTimeInterval animateDuration;

/**
 *  是否开启点击事件 默认为NO
 */
@property (nonatomic, assign) BOOL touchEnabled;
/**
 *  点击事件响应
 */
@property (nonatomic, copy) void (^clickAdBlock)(NSUInteger index);
/**
 *  开始轮播
 */
- (void)startScroll;

/**
 *  关闭轮播
 */
- (void)stopScroll;

/**
 *  实例化方法
 */
- (instancetype)initWithTexts:(NSArray<NSString *> *)titles;

@end
