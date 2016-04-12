# AdLabelAutoScroll
文字广告轮播

本项目仅封装了文字轮播，类似于京东滚动提示那种，带有点击事件
####具体用法在demo里面有。

        /**
        *  广告内容数组
        */
        @property (nonatomic, copy) NSArray *adTitles;

        /**
        * 头部图片 默认为nil
        */

        @property (nonatomic, strong) UIImage *headImg;

        /**
        *  图片位置
        */
        @property (nonatomic, assign) UIEdgeInsets edgeInsets;
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
        *  立即开始轮播
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

#### 基本能满足需求。 因为没找到图片，就扔了个纯黑图片当轮播框前面的图标。



![image](https://github.com/HRongChen/AdLabelAutoScroll/blob/master/AutoAdLabelScroll/Page.gif)

