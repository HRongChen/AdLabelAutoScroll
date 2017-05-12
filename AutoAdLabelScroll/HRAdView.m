//
//  HRAdView.m
//  AutoAdLabelScroll
//
//  Created by 陈华荣 on 16/4/6.
//  Copyright © 2016年 陈华荣. All rights reserved.
//

#import "HRAdView.h"
#define ViewWidth  self.bounds.size.width
#define ViewHeight  self.bounds.size.height

@interface HRAdView ()

@property (nonatomic, assign) NSUInteger currentIndex;
/**
 *  文字广告条前面的图标
 */
@property (nonatomic, strong) UIImageView *iconView;

/**
 轮流显示的第一个Label
 */
@property (nonatomic, strong) UILabel *oneLabel;

/**
 轮流显示的第二个Label
 */
@property (nonatomic, strong) UILabel *twoLabel;
@property (nonatomic, weak) UILabel *currentLabel;
/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation HRAdView
{
    CGFloat margin;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        margin = 0;
        self.clipsToBounds = YES;
        self.icon = nil;
        self.font = [UIFont systemFontOfSize:16];
        self.textColor = [UIColor blackColor];
        self.duration = 2.0f;
        self.animateDuration = 1.f;
        self.textAlignment = NSTextAlignmentLeft;
        self.touchEnabled = NO;
        self.iconInsets = UIEdgeInsetsZero;
        self.textInsets = UIEdgeInsetsZero;
        _currentIndex = NSNotFound;
        
        if (!_iconView) {
            _iconView = [UIImageView new];
        }
        
        if (!_oneLabel) {
            _oneLabel = [self createLabel];
            [self addSubview:_oneLabel];
        }
        
        if (!_twoLabel) {
            _twoLabel = [self createLabel];
            [self addSubview:_twoLabel];
        }
    }
    return self;
}

- (instancetype)initWithTexts:(NSArray<NSString *> *)titles {
    if ([self init]) {
        self.texts = titles;
        if (self.texts.count > 0) {
            _oneLabel.text = self.texts.firstObject;
            _currentIndex = 0;
            _currentLabel = _oneLabel;
        }
    }
    
    return self;
}

- (UILabel *)createLabel {
    UILabel *label = [UILabel new];
    label.font = self.font;
    label.textColor = self.textColor;
    label.textAlignment = self.textAlignment;
    label.numberOfLines = self.numberOfTextLines;
    return label;
}

- (void)animateForText:(NSString *)text {
    UILabel *willHideLabel = self.currentLabel;
    UILabel *willShowLabel = self.currentLabel == self.oneLabel ? self.twoLabel : self.oneLabel;
    
    willShowLabel.text = text;
    [UIView animateWithDuration:self.animateDuration animations:^{
        willShowLabel.frame = CGRectMake(margin, 0, ViewWidth - margin - self.textInsets.right, ViewHeight - self.textInsets.top - self.textInsets.bottom);
        willHideLabel.frame = CGRectMake(margin, -ViewHeight, ViewWidth - margin - self.textInsets.right, ViewHeight - self.textInsets.top - self.textInsets.bottom);
    } completion:^(BOOL finished) {
        willHideLabel.frame = CGRectMake(margin, ViewHeight, ViewWidth - margin - self.textInsets.right, ViewHeight - self.textInsets.top - self.textInsets.bottom);
        self.currentLabel = willShowLabel;
    }];
}

- (void)timeRepeat {
    if (self.texts.count == 0 && _currentIndex != NSNotFound) {
        _currentIndex = NSNotFound;
        [self animateForText:@""];
        return;
    }
    
    if (self.texts.count == 1 && _currentIndex != 0) {
        _currentIndex = 0;
        [self animateForText:self.texts.firstObject];
        return;
    }
    
    if (_currentIndex < self.texts.count - 1) {
        _currentIndex ++;
    } else {
        _currentIndex = 0;
    }
    [self animateForText:self.texts[_currentIndex]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.icon) {
        [self addSubview:self.iconView];
        self.iconView.frame = CGRectMake(self.iconInsets.left,
                                              self.iconInsets.top,
                                              ViewHeight - self.iconInsets.top - self.iconInsets.bottom,
                                              ViewHeight - self.iconInsets.top - self.iconInsets.bottom
                                              );
        margin = CGRectGetMaxX(self.iconView.frame) + self.textInsets.left;
    } else {
        if (self.iconView) {
            [self.iconView removeFromSuperview];
            self.iconView = nil;
        }
        margin = self.textInsets.left;
    }
    
    self.oneLabel.frame = CGRectMake(margin, 0, ViewWidth - margin - self.textInsets.right, ViewHeight - self.textInsets.top - self.textInsets.bottom);
    self.twoLabel.frame = CGRectMake(margin, ViewHeight, ViewWidth - margin - self.textInsets.right, ViewHeight - self.textInsets.top - self.textInsets.bottom);
}

- (void)startScroll {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer timerWithTimeInterval:self.duration target:self selector:@selector(timeRepeat) userInfo:self repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopScroll {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setIconInsets:(UIEdgeInsets)iconInsets {
    _iconInsets = iconInsets;
}

- (void)setTouchEnabled:(BOOL)isHaveTouchEvent {
    if (isHaveTouchEvent) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    } else {
        self.userInteractionEnabled = NO;
    }
}

- (void)setDuration:(NSTimeInterval)time {
    _duration = time;
    if (self.timer.isValid) {
        [self.timer isValid];
        self.timer = nil;
    }
}

- (void)setIcon:(UIImage *)headImg {
    _icon = headImg;
    
    _iconView.image = headImg;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.oneLabel.textAlignment = _textAlignment;
    self.twoLabel.textAlignment = _textAlignment;
}

- (void)setTextColor:(UIColor *)color {
    _textColor = color;
    self.oneLabel.textColor = color;
    self.twoLabel.textColor = color;
}

- (void)setFont:(UIFont *)labelFont {
    _font = labelFont;
    self.oneLabel.font = labelFont;
    self.twoLabel.font = labelFont;
}

- (void)setNumberOfTextLines:(NSInteger)numberOfTextLines {
    _numberOfTextLines = numberOfTextLines;
    self.oneLabel.numberOfLines = _numberOfTextLines;
    self.twoLabel.numberOfLines = _numberOfTextLines;
}

- (void)clickEvent:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.clickAdBlock) {
        self.clickAdBlock(_currentIndex);
    }
}


@end
