//
//  RewriteViewController.m
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "BaseHomeVC.h"
#import "UIViewController+MMDrawerController.h"

@interface BaseHomeVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UINavigationController *nav;

@end

@implementation BaseHomeVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.hidesBottomBarWhenPushed = YES;//跳转时隐藏tabbar
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]]; //去除分割线
    
    for (id subView in self.navigationController.navigationBar.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]] || [subView isKindOfClass:[UITextField class]] || [subView isKindOfClass:[UILabel class]] || [subView isKindOfClass:[UISegmentedControl class]]) {
            
            [subView removeFromSuperview];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //左按钮
    UIBarButtonItem *leftBarButItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(showLeftMenu:)];
    //设置按钮内容颜色
    [leftBarButItem setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = leftBarButItem;
    
    //右按钮
    UIBarButtonItem *rightBarButItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(showRightMenu:)];
    //设置按钮内容颜色
    [rightBarButItem setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = rightBarButItem;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES; //跟随手势右划，使用自定义返回失效
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

//左菜单
- (void)showLeftMenu:(UIBarButtonItem *)sender
{
    [self.view endEditing:YES];
    
    //打开关闭
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
    }];
}

//右菜单
- (void)showRightMenu:(UIBarButtonItem *)sender
{
    
}


- (void)rightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if (self.navigationController.viewControllers.firstObject == self) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
