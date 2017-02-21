//
//  KvoVC.m
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

/**
    KVO是KeyValueObserve的缩写，中文是键值观察。
    这是一个典型的观察者模式，观察者在键值改变时会得到通知。
    
    KVO的使用只有简单的3步：
    以下三个方法都需要重写
 
    1.注册需要观察的对象的属性:
 - (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
 
    2.实现下面方法，这个方法当观察的属性变化时会自动调用
 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 
    3.取消注册观察发放
 - (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context

    强调：
    KVO的回调要被调用，属性必须是通过KVC的方法来修改的，如果是调用类的其他方法来修改属性，这个观察者是不会得到通知的。
 */

#import "KvoVC.h"
#import "people.h"

@interface KvoVC ()

@property (nonatomic, strong) people *people1;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UILabel *label1;

@end

@implementation KvoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.people1 = [[people alloc] init];
    
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:beginBtn];
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    [beginBtn setTitle:@"开始监控" forState:UIControlStateNormal];
    [beginBtn setTitle:@"停止监控" forState:UIControlStateSelected];
    [beginBtn addTarget:self action:@selector(beginMonitor:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //随机赋值
    UIButton *inputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:inputBtn];
    [inputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(beginBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(beginBtn.mas_left);
        make.right.mas_equalTo(beginBtn.mas_right);
        make.height.mas_equalTo(50);
    }];
    [inputBtn setTitle:@"随机赋值" forState:UIControlStateNormal];
    [inputBtn addTarget:self action:@selector(input) forControlEvents:UIControlEventTouchUpInside];
    
    
    //
    self.label = [[UILabel alloc] init];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inputBtn.mas_bottom).offset(50);
        make.left.mas_equalTo(inputBtn.mas_left);
        make.right.mas_equalTo(inputBtn.mas_right);
        make.height.mas_equalTo(40);
    }];
    self.label.text = @"KVO";
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label1 = [UILabel new];
    [self.view addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(20);
        make.left.mas_equalTo(self.label.mas_left);
        make.right.mas_equalTo(self.label.mas_right);
        make.height.mas_equalTo(40);
    }];
    self.label1.text = @"原始值";
    self.label1.textAlignment = NSTextAlignmentCenter;
    
}

- (void)beginMonitor:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.people1 addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:nil];
    }else {
        [self.people1 removeObserver:self forKeyPath:@"height" context:nil];
    }
}

- (void)input
{
    [self.people1 setValue:[NSNumber numberWithInt:rand()%100/1] forKey:@"height"];
    self.label1.text = [NSString stringWithFormat:@"height = %@",[self.people1 valueForKey:@"height"]];
}


//重写注册方法
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [super addObserver:observer forKeyPath:keyPath options:options context:context];
}

//重写监控方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"height"]) {
        self.label.text = [NSString stringWithFormat:@"Height is changed! new = %@",[change valueForKey:NSKeyValueChangeNewKey]];
        NSLog(@"Height is changed! new = %@",[change valueForKey:NSKeyValueChangeNewKey]);
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//重写取消监控方法
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context
{
    [super removeObserver:observer forKeyPath:keyPath context:context];
}

- (void)dealloc
{
    [self.people1 removeObserver:self forKeyPath:@"height" context:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
