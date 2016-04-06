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
    NSArray *array = @[@"111111",@"22222222",@"33333333",@"4444444444"];
    
    HRAdView * view = [[HRAdView alloc]initWithTitles:array];
    view.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
    view.textAlignment = NSTextAlignmentLeft;//默认
    view.isHaveHeadImg = YES;
    view.isHaveTouchEvent = YES;
    view.labelFont = [UIFont boldSystemFontOfSize:17];
    view.color = [UIColor redColor];
    view.time = 2.0f;
    __weak typeof(self) weakself = self;
    view.clickAdBlock = ^(NSUInteger index){
        DetailViewController *vc = [[DetailViewController alloc]init];
        
        vc.text = [NSString stringWithFormat:@"%@",array[index]];
        [weakself.navigationController pushViewController:vc animated:YES];
        NSLog(@"%@",array[index]);
    };
    view.headImg = [UIImage imageNamed:@"Default-568h.png"];
    [self.view addSubview:view];
    self.adView = view;
    view.backgroundColor = [UIColor grayColor];
    
    UIButton *beginScrollBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 80, 40)];
    [beginScrollBtn addTarget:self action:@selector(startScroll) forControlEvents:UIControlEventTouchUpInside];
    [beginScrollBtn setTitle:@"开始" forState:UIControlStateNormal];
    [beginScrollBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:beginScrollBtn];
    
    
    UIButton *endScrollBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 80, 40)];
    [endScrollBtn addTarget:self action:@selector(endScroll) forControlEvents:UIControlEventTouchUpInside];
    [endScrollBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endScrollBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:endScrollBtn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    [self.adView beginScroll];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.adView closeScroll];
    
}


- (void)startScroll{
    /**
     *  手动控制滚动
     */
    [self.adView beginScroll];
}

- (void)endScroll{
    /**
     *  停止滚动
     */
    [self.adView closeScroll];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
