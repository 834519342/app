//
//  KvcVC.m
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

/**
 kvc,即是指NSKeyValueCoding，一个非正式的Protocol，提供一种机制来间接访问对象的属性。
 而不是通过调用Setter/Getter方法访问。
 kvo就是基于kvc实现的关键技术之一。
 
 kvc的常用方法:
 - (id)valueForKey:(NSString *)key;
 valueForKey的方法根据key的值读取对象的属性
 
 - (void)setValue:(id)value forKey:(NSString *)key;
 setValue:forKey:是根据key的值来写对象的属性
 
 注意：
 1.key的值必须正确，如果拼写错误，会出现异常
 2.当key的值是没有定义的，valueForUndefinedKey:这个方法会被调用，如果你自己写了这个方法，key的值出错就会调用到这里来
 3.因为类key反复嵌套，所以有个keyPath的概念，keyPath就是用.号来把一个一个key链接起来，这样就可以根据这个路径访问下去
 4.NSArray/NSSet等都支持kvc
 */

#import "KvcVC.h"
#import "people.h"

@interface KvcVC ()

@property (nonatomic , strong) people *people1;

@property (nonatomic, strong) UILabel *label;

@end

@implementation KvcVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"KVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.people1 = [[people alloc] init];
    
    UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:getBtn];
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    [getBtn setTitle:@"输出参数" forState:UIControlStateNormal];
    [getBtn addTarget:self action:@selector(output) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(getBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(getBtn.mas_left);
        make.right.mas_equalTo(getBtn.mas_right);
        make.height.mas_equalTo(50);
    }];
    [setBtn setTitle:@"随机赋值" forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(input) forControlEvents:UIControlEventTouchUpInside];
    
    self.label = [[UILabel alloc] init];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(setBtn.mas_bottom).offset(50);
        make.left.mas_equalTo(setBtn.mas_left);
        make.right.mas_equalTo(setBtn.mas_right);
        make.height.mas_equalTo(40);
    }];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"KVC";
    
    
}
	
- (void)output
{
    self.label.text = [NSString stringWithFormat:@"height = %@",[self.people1 valueForKey:@"height"]];
    
    NSLog(@"height = %@",[self.people1 valueForKey:@"height"]);
}

- (void)input
{
    [self.people1 setValue:[NSNumber numberWithInt:rand()%100/1] forKey:@"height"];
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
