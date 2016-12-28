//
//  searchVC.m
//  app
//
//  Created by 谭杰 on 2016/12/24.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "SearchVC.h"
#import "Search2VC.h"

@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *search;

@property (nonatomic, strong) Search2VC *search2;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Search2VC *search2VC = [[Search2VC alloc] init];
    
    self.search = [[UISearchController alloc] initWithSearchResultsController:search2VC];
    self.search.searchBar.frame = CGRectMake(0, 0, 0, 44);
    self.search.searchBar.backgroundColor = [UIColor whiteColor];
    [self.search.searchBar sizeToFit];
    self.search.searchBar.delegate = self;
    //禁止移动导航栏
    self.search.hidesNavigationBarDuringPresentation = NO;
    self.search.dimsBackgroundDuringPresentation = NO;
    self.search.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.tableView.tableHeaderView = self.search.searchBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.search.becomeFirstResponder == YES) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        NSLog(@"1");
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        NSLog(@"2");
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Search2VC *search2VC = [[Search2VC alloc] init];
    [self.search setActive:NO];
    [self.navigationController pushViewController:search2VC animated:YES];
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
