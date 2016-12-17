//
//  CountDownVC.m
//  app
//
//  Created by 谭杰 on 2016/12/17.
//  Copyright © 2016年 谭杰. All rights reserved.
//

#import "CountDownVC.h"

@interface CountDownVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableViwe;

@property (nonatomic, strong) NSMutableArray *data; //原始数据

@property (nonatomic, strong) NSMutableArray *timeData; //有倒计时的数据

@property (nonatomic, strong) NSTimer *timer; //计时器

@end

@implementation CountDownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViwe = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableViwe.delegate = self;
    self.tableViwe.dataSource = self;
    [self.view addSubview:self.tableViwe];
    [self.tableViwe mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //清空旧数据
    if (self.data.count > 0) {
        [self.data removeAllObjects];
    }
    //生成新数据
    if (self.data.count == 0) {
        for (int i = 0; i <= 20; i++) {
            [self.data addObject:[NSNumber numberWithInt:rand()%100/1]];
        }
    }
    //清空旧数据
    if (self.timeData.count > 0) {
        [self.timeData removeAllObjects];
    }
    //筛选需要倒计时的数据
    [self _operateData];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//筛选需要倒计时的数据
- (void)_operateData
{
    if (self.data.count > 0) {
        for (int i = 0; i<self.data.count; i++) {
            //可以添加判断条件,判断哪些需要倒计时
            NSNumber *allSecond = self.data[i];
            NSInteger remainIntSecond = [allSecond integerValue];
            
            /**
             *  indexPath:需要倒计时数据的位置
             *  lastTime:倒计时间
             */
            NSDictionary *dic = @{@"indexPath":[NSString stringWithFormat:@"%d",i],@"lastTime":[NSString stringWithFormat:@"%ld",(long)remainIntSecond]};
            
            //需要倒计时的数据统一记录
            [self.timeData addObject:dic];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //开启定时器
        [self startTimer];
        
        [self.tableViwe reloadData];
        
    });
    
}

//开启定时器
- (void)startTimer
{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
        //如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    }
}

//刷新对应cell的数据
- (void)refreshLessTime
{
    int time;
    
    for (int i = 0; i < _timeData.count; i++) {
        //获取倒计时
        time = [[[self.timeData objectAtIndex:i] objectForKey:@"lastTime"] intValue];
        //数据位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[[self.timeData objectAtIndex:i] objectForKey:@"indexPath"] integerValue] inSection:0];
        //cell位置
        UITableViewCell *cell = [self.tableViwe cellForRowAtIndexPath:indexPath];
        
        //当倒计时大于0的时候，刷新倒计时显示，反之显示已结束之类的提示
        if (time > 0) {

            cell.textLabel.text = [NSString stringWithFormat:@"%i",time];
            time = time - 1; //时间 -1
            
            //将新的时间放到数据源里面
            NSDictionary *dic = @{@"indexPath":[NSString stringWithFormat:@"%d",i],@"lastTime":[NSString stringWithFormat:@"%i",time]};
            
            [self.data replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:time]];
            [self.timeData replaceObjectAtIndex:i withObject:dic];
            
        } else {
            //同上
            [self.data replaceObjectAtIndex:indexPath.row withObject:@"已结束"];
            cell.textLabel.text = @"已结束";
            
        }
        
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.data[indexPath.row]];
    
    return cell;
}



- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (NSMutableArray *)timeData
{
    if (_timeData == nil) {
        _timeData = [NSMutableArray array];
    }
    return _timeData;
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
