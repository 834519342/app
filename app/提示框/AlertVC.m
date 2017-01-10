//
//  AlertVC.m
//  app
//
//  Created by 谭杰 on 2017/1/9.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "AlertVC.h"

@interface AlertVC ()<TJAlertDelegate>

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *btn1;

@end

@implementation AlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索框";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc] init];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).offset(20);
        make.left.mas_equalTo(self.textField.mas_left);
        make.right.mas_equalTo(self.textField.mas_right);
        make.height.mas_equalTo(40);
    }];
    [self.btn setTitle:@"居中提示框" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btn.mas_bottom).offset(20);
        make.left.mas_equalTo(self.btn.mas_left);
        make.right.mas_equalTo(self.btn.mas_right);
        make.height.mas_equalTo(self.btn.mas_height);
    }];
    [self.btn1 setTitle:@"顶端提示框" forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)click:(UIButton *)btn
{
    if (self.textField.text.length == 0) {
        [TJAlert showCenterWithMessage:@"默认输出内容"];
    }else {
        [TJAlert showCenterWithMessage:self.textField.text duration:3.f];
    }
}

- (void)click1:(UIButton *)btn
{
    if (self.textField.text.length == 0) {
        [TJAlert showTopWithMessage:@"默认输出内容" withDelegate:self];
//        [TJAlert showTopWithMessage:@"默认输出内容" clickAlertBlock:^(NSString *message) {
//            NSLog(@"%@",message);
//        }];
    }else {
//        [TJAlert showTopWithMessage:self.textField.text duration:3.f withDelegate:self];
        [TJAlert showTopWithMessage:self.textField.text duration:3.f clickAlertBlock:^(NSString *message) {
            NSLog(@"%@",message);
        }];
    }
}

- (void)ClickTopAlertText:(NSString *)text
{
    NSLog(@"%@",text);
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
