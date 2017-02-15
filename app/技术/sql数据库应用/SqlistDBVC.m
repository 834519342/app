//
//  SqlistDBVC.m
//  app
//
//  Created by 谭杰 on 2017/1/16.
//  Copyright © 2017年 谭杰. All rights reserved.
//

#import "SqlistDBVC.h"

#import "TJDB.h"

@interface SqlistDBVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TJDB *db;

@property (nonatomic, strong) DataModel *dataModel;

@property (nonatomic, strong) UITextField *name;

@property (nonatomic, strong) UITextField *age;

@property (nonatomic, strong) UITextField *weight;

@property (nonatomic, strong) UITableView *dbTableView;

@end

@implementation SqlistDBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据库管理";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.db = [[TJDB alloc] initWithDBName:@"db" TableName:@"test"];
    
    self.dataModel = [[DataModel alloc] init];
    
    //名字
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width/3.f, 40)];
    self.name.keyboardType = UIKeyboardTypeDefault;
    self.name.borderStyle = UITextBorderStyleRoundedRect;
    self.name.placeholder = @"名字";
    [self.view addSubview:self.name];
    
    //年龄
    self.age = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/3.f, 20, self.view.bounds.size.width/3.f, 40)];
    self.age.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    self.age.borderStyle = UITextBorderStyleRoundedRect;
    self.age.placeholder = @"年龄";
    [self.view addSubview:self.age];
    
    //体重
    self.weight = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/3.f*2, 20, self.view.bounds.size.width/3.f, 40)];
    self.weight.keyboardType = UIKeyboardTypeNumberPad;
    self.weight.borderStyle = UITextBorderStyleRoundedRect;
    self.weight.placeholder = @"体重";
    [self.view addSubview:self.weight];
    
    //按钮
    UIButton *insertBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    insertBtn.frame = CGRectMake(15, 80, 50, 40);
    [insertBtn setTitle:@"插入" forState:UIControlStateNormal];
    [insertBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    insertBtn.tag = 1;
    [self.view addSubview:insertBtn];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    updateBtn.frame = CGRectMake(70, 80, 50, 40);
    [updateBtn setTitle:@"更新" forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    updateBtn.tag = 2;
    [self.view addSubview:updateBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    deleteBtn.frame = CGRectMake(125, 80, 50, 40);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.tag = 3;
    [self.view addSubview:deleteBtn];
    
    self.dbTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width, self.view.bounds.size.height - 140 - 64)];
    self.dbTableView.dataSource = self;
    self.dbTableView.delegate = self;
    [self.view addSubview:self.dbTableView];
    
}

- (void)click:(UIButton *)btn
{
    self.dataModel.name = self.name.text;
    self.dataModel.age = [self.age.text intValue];
    self.dataModel.weight = [self.weight.text floatValue];
    
    if (btn.tag == 1) {
        if (self.db) {
            [self.db insertData:self.dataModel TableName:self.db.tableName];
        }
    }else if (btn.tag == 2) {
        if (!self.dataModel.dataId) {
            return;
        }
        if (self.db) {
            [self.db updateData:self.dataModel TableName:self.db.tableName];
        }
    }else if (btn.tag == 3) {
        if (!self.dataModel.dataId) {
            return;
        }
        if (self.db) {
            [self.db deleteData:self.dataModel TableName:self.db.tableName];
        }
    }
    self.dataModel.dataId = 0;
    [self.dbTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = 0;
    if (self.db) {
        count = [self.db getAllDataTableName:self.db.tableName].count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    DataModel *data = [self.db getAllDataTableName:self.db.tableName][indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"id:%d,name:%@,age:%d,weight:%.2f",data.dataId,data.name,data.age,data.weight];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel *data = [self.db getAllDataTableName:self.db.tableName][indexPath.row];
    self.dataModel.dataId = data.dataId;
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
