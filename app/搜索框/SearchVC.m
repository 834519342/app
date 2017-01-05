//
//  searchVC.m
//  app
//
//  Created by 谭杰 on 2016/12/24.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "SearchVC.h"
#import "Search2VC.h"

@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *search;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *searchResultsArr;


@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
//    self.navigationController.navigationBar.translucent = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    self.search = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.search.searchBar.frame = CGRectMake(0, 0, 0, 44);
    self.search.searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    self.search.searchBar.backgroundColor = [UIColor whiteColor];
    //禁止移动导航栏
//    self.search.hidesNavigationBarDuringPresentation = NO;
    //显示搜索结果
    self.search.dimsBackgroundDuringPresentation = NO;
    //搜索框风格
    [self.search.searchBar sizeToFit];
    self.search.searchResultsUpdater = self;

    self.tableView.tableHeaderView = self.search.searchBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (self.searchResultsArr.count > 0) {
        [self.searchResultsArr removeAllObjects];
    }
    
    [self.searchResultsArr addObjectsFromArray:[self filterPredicateWithSearchString:searchController.searchBar.text]];
    
    [self.tableView reloadData];
}

#pragma mark NSPredicate匹配方法
- (NSMutableArray *)filterPredicateWithSearchString:(NSString *)searchStr
{
    /** 引用：http://www.cocoachina.com/ios/20160111/14926.html
     *  只要我们使用谓词（NSPredicate）都需要为谓词定义谓词表达式,而这个表达式必须是一个返回BOOL的值。
     *  谓词表达式由表达式、运算符和值构成。
     *  1.定义谓词
     *  NSPredicate *predicate = [NSPredicate predicateWithFormat:];
     *  SELF：代表正在被判断的对象自身
     *  CONTAINS：检查某个字符串是否包含指定的字符串
     *  [c]不区分大小写；[d]不区分发音符号即没有重复符号； [cd]既不区分大小写，也不区分发音符号。
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchStr];
    id objc = self.dataArr[0];
    if ([objc isKindOfClass:[NSString class]]) {
        /**
         *  2.使用谓词过滤集合
         *  其实谓词本身就代表了一个逻辑条件，计算谓词之后返回的结果永远为BOOL类型的值。而谓词最常用的功能就是对集合进行过滤。当程序使用谓词对集合元素进行过滤时，程序会自动遍历其元素，并根据集合元素来计算谓词的值，当这个集合中的元素计算谓词并返回YES时，这个元素才会被保留下来。请注意程序会自动遍历其元素，它会将自动遍历过之后返回为YES的值重新组合成一个集合返回。
         *  NSArray提供了如下方法使用谓词来过滤集合
         *  - (NSArray*)filteredArrayUsingPredicate:(NSPredicate *)predicate:使用指定的谓词过滤NSArray集合，返回符合条件的元素组成的新集合
         *  
         *  NSMutableArray提供了如下方法使用谓词来过滤集合
         *  - (void)filterUsingPredicate:(NSPredicate *)predicate：使用指定的谓词过滤NSMutableArray，剔除集合中不符合条件的元素
         */
        return [NSMutableArray arrayWithArray:[self.dataArr filteredArrayUsingPredicate:predicate]];
    }
    return nil;
}

#pragma mark NSPredicate判断手机号是否正确
- (BOOL)checkPhoneNumber:(NSString *)phoneNumber
{
    NSString *regex = @"^[1][3-8]\\d{9}$";
    //MATCHES：检查某个字符串是否匹配指定的正则表达式。虽然正则表达式的执行效率是最低的，但其功能是最强大的，也是我们最常用的。
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNumber];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.search.active == NO) {
        return self.dataArr.count;
    }else {
        return self.searchResultsArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (self.search.active == NO) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }else {
        cell.textLabel.text = self.searchResultsArr[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Search2VC *search2VC = [[Search2VC alloc] init];
    [self.search setActive:NO];
    [self.navigationController pushViewController:search2VC animated:YES];
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            @autoreleasepool {
                NSString *str = [NSString stringWithFormat:@"%d:%c%c%c",i,'A' + rand()%26,'a' + rand()%26, 'a' + rand()%26];
                [_dataArr addObject:str];
            }
        }
    }
    return _dataArr;
}

- (NSMutableArray *)searchResultsArr
{
    if (_searchResultsArr == nil) {
        _searchResultsArr = [NSMutableArray array];
    }
    return _searchResultsArr;
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
