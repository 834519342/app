//
//  LeftSlidingMenuVC.m
//  app
//
//  Created by 谭杰 on 2016/12/15.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "LeftSlidingMenuVC.h"
#import "UIViewController+MMDrawerController.h"

@interface LeftSlidingMenuVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuTableView;

@property (nonatomic, strong) UINavigationController *nav;

@property (nonatomic, strong) KvcVC *kvcVC;
@property (nonatomic, strong) KvoVC *kvoVC;
@property (nonatomic, strong) CountDownVC *countDownVC;
@property (nonatomic, strong) SearchVC *searchVC;
@property (nonatomic, strong) AlertVC *alertVC;
@property (nonatomic, strong) PushNotificationVC *puchVC;

@end

@implementation LeftSlidingMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LeftMenu";
    //导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:55.0/255.f green:70.0/255.f blue:77.0/255.0 alpha:1.0]}];
    
    //导航栏颜色
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:161.0/255.f green:164.0/255.f blue:166.0/255.f alpha:1.0]];
    }
    else
    {
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:161.0/255.f green:164.0/255.f blue:166.0/255.f alpha:1.0]];
    }

    self.view.backgroundColor = [UIColor colorWithRed:66.0/255.f green:69.0/255.f blue:71.0/255.f alpha:1.0];
    
    
    
    self.menuTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.menuTableView setDelegate:self];
    [self.menuTableView setDataSource:self];
    [self.view addSubview:self.menuTableView];
    //自动显示布局
    [self.menuTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UIColor *tableViewBackgroundColor;
    tableViewBackgroundColor = [UIColor colorWithRed:110.0/255.f green:113.0/255.f blue:115.0/255.f alpha:1.0];
    [self.menuTableView setBackgroundColor:tableViewBackgroundColor];
    
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return item.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = item[section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //cell风格
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor colorWithRed:122.0/255.f green:126.0/255.f blue:128.0/255.f alpha:1.0];
    cell.textLabel.textColor = [UIColor colorWithRed:230.0/255.f green:236.0/255.f blue:242.0/255.f alpha:1.0];
    /**
     *  + systemFontOfSize 系统默认方法
     *  + boldSystemFontOfSize 使用后会加粗字体
     *  + italicSystemFontOfSize 斜体字
     */
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    
    
    NSArray *arr = item[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
//段头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.f;
}
//段尾高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

//自定义段头
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
//自定义段尾
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        self.nav = [[UINavigationController alloc] initWithRootViewController:appDelegate.homeVC];
        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withFullCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"HOME");
        }];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        self.nav = [[UINavigationController alloc] initWithRootViewController:self.kvcVC];
        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"KVC");
        }];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        self.nav = [[UINavigationController alloc] initWithRootViewController:self.kvoVC];
        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"KVO");
        }];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        self.nav = [[UINavigationController alloc] initWithRootViewController:self.countDownVC];
        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withFullCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"倒计时");
        }];
    }
    
    if ([cell.textLabel.text isEqualToString:@"搜索"]) {
        self.nav = [[UINavigationController alloc] initWithRootViewController:self.searchVC];
//        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withFullCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"搜索");
        }];
    }
    
    if ([cell.textLabel.text isEqualToString:@"提醒框"]) {
        self.nav = [[UINavigationController alloc] initWithRootViewController:self.alertVC];
        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"搜索框");
        }];
    }
    
    if ([cell.textLabel.text isEqualToString:@"本地推送"]) {
        self.nav = [[UINavigationController alloc] initWithRootViewController:self.puchVC];
        self.nav.navigationBar.translucent = NO;
        [self.mm_drawerController setCenterViewController:self.nav withFullCloseAnimation:YES completion:^(BOOL finished) {
            NSLog(@"本地推送");
        }];
    }
}

//懒加载
- (KvcVC *)kvcVC
{
    if (_kvcVC == nil) {
        _kvcVC = [[KvcVC alloc] init];
    }
    return _kvcVC;
}
- (KvoVC *)kvoVC
{
    if (_kvoVC == nil) {
        _kvoVC = [[KvoVC alloc] init];
    }
    return _kvoVC;
}
- (CountDownVC *)countDownVC
{
    if (_countDownVC == nil) {
        _countDownVC = [[CountDownVC alloc] init];
    }
    return _countDownVC;
}

- (SearchVC *)searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[SearchVC alloc] init];
    }
    return _searchVC;
}

- (AlertVC *)alertVC
{
    if (_alertVC == nil) {
        _alertVC = [[AlertVC alloc] init];
    }
    return _alertVC;
}

- (PushNotificationVC *)puchVC
{
    if (_puchVC == nil) {
        _puchVC = [[PushNotificationVC alloc] init];
    }
    return _puchVC;
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
