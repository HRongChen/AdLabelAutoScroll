//
//  ViewController.m
//  AutoAdLabelScroll
//
//  Created by 陈华荣 on 16/4/6.
//  Copyright © 2016年 陈华荣. All rights reserved.
//

#import "ViewController.h"
#import "HRAdView.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (nonatomic, strong) HRAdView *adView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"111111111111111111111111111111111111111111111111111",@"22222222",@"33333333"];
    
    HRAdView * view = [[HRAdView alloc] initWithTexts:array];
    view.frame = CGRectMake(5, 64, self.view.frame.size.width-10, 44);
    view.textAlignment = NSTextAlignmentLeft;//默认
    view.touchEnabled = YES;
    view.font = [UIFont boldSystemFontOfSize:17];
    view.textColor = [UIColor redColor];
    view.duration = 3.0f;
    view.textInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    view.numberOfTextLines = 2;
    view.iconInsets = UIEdgeInsetsMake(8, 8,8, 10);
    __weak typeof(self) weakself = self;
    view.clickAdBlock = ^(NSUInteger index){
        DetailViewController *vc = [[DetailViewController alloc]init];
        
        vc.text = [NSString stringWithFormat:@"%@",array[index]];
        [weakself.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@",array[index]);
    };
    view.icon = [UIImage imageNamed:@"laba.png"];
    [self.view addSubview:view];
    self.adView = view;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1.0f;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds  = YES;
    UIButton *beginScrollBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, 80, 40)];
    [beginScrollBtn addTarget:self action:@selector(startScroll:) forControlEvents:UIControlEventTouchDown];
    [beginScrollBtn setBackgroundColor:[UIColor darkGrayColor]];
    [beginScrollBtn setTitle:@"开始" forState:UIControlStateNormal];
    [beginScrollBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:beginScrollBtn];
    
    
    UIButton *endScrollBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-110, 200, 80, 40)];
    [endScrollBtn addTarget:self action:@selector(endScroll:) forControlEvents:UIControlEventTouchDown];
    [endScrollBtn setBackgroundColor:[UIColor darkGrayColor]];
    [endScrollBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endScrollBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:endScrollBtn];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        view.texts = @[@"tihuan1", @"tihuan2", @"tihuan3", @"tihuan4", @"tihuan5", @"tihuan6"];
        view.texts = nil;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.texts = @[@"tihuan1", @"tihuan2", @"tihuan3", @"tihuan4", @"tihuan5", @"tihuan6"];
    });

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    [self.adView startScroll];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.adView stopScroll];
    
}


- (void)startScroll:(UIButton *)sender{
    /**
     *  手动控制滚动
     */
    [self.adView startScroll];
    [self scaleTheView:sender];
}

- (void)endScroll:(UIButton *)sender{
    /**
     *  停止滚动
     */
    [self.adView startScroll];
    [self scaleTheView:sender];
    
}

- (void)scaleTheView:(UIButton *)button{
    
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat value = 0.8f;
        button.transform = CGAffineTransformMakeScale(value, value);
    }completion:^(BOOL finished) {
        CGFloat value = 1.0f;
        button.transform = CGAffineTransformMakeScale(value, value);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
