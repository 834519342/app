//
//  BaseBackVC.m
//  app
//
//  Created by admin on 2017/2/21.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "BaseBackVC.h"

@interface BaseBackVC ()
{
    UIButton *btn;
}
@end

@implementation BaseBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义按钮
    btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    //调整image位置
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    [btn setTitle:self.backTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //调整label位置
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    [btn addTarget:self action:@selector(backVC:) forControlEvents:UIControlEventTouchUpInside];
    
    //左按钮
    UIBarButtonItem *leftBarButItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //设置按钮内容颜色
//    [leftBarButItem setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = leftBarButItem;
}

//返回按钮
- (void)backVC:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
