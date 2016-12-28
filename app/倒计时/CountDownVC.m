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
    
    [self refreshData];
    
}

//刷新数据
- (void)refreshData
{
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

- (void)showRightMenu:(UIBarButtonItem *)sender
{
    [super showRightMenu:sender];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }else if (self.timer == nil){
        [self startTimer];
    }
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
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshLessTime) userInfo:nil repeats:YES];
        /**
         *  这个时候如果我们在界面上滚动一个UITableView，那么我们会发现在停止滚动前，控制台不会有任何输出，就好像UITableView在滚动
         *  的时候将timer暂停了一样，在查看相应文档后发现，这其实就是runloop的mode在做怪。runloop可以理解为cocoa下的一种消息循环
         *  机制，用来处理各种消息事件，我们在开发的时候并不需要手动去创建一个runloop，因为框架为我们创建了一个默认的runloop,通过
         *  [NSRunloop currentRunloop]我们可以得到一个当前线程下面对应的runloop对象，不过我们需要注意的是不同的runloop之间消息
         *  的通知方式。
         *
         *  接着上面的话题，在开启一个NSTimer实质上是在当前的runloop中注册了一个新的事件源，而当UITableView滚动的时候，当前的
         *  MainRunLoop是处于UITrackingRunLoopMode的模式下，在这个模式下，是不会处理NSDefaultRunLoopMode的消息(因为
         *  RunLoop Mode不一样)，要想在scrollView滚动的同时也接受其它runloop的消息，我们需要改变两者之间的runloopmode.
         *
         *  NSRunLoopCommonModes
         *  UITrackingRunLoopMode
         *  添加下面代码，在UITableView拖动的时候，消息也会刷新
         */
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
        /**
         *  简单的说就是NSTimer不会开启新的进程，只是在Runloop里注册了一下，Runloop每次loop时都会检测这个timer，看是否可以触发。
         *  当Runloop在A mode，而timer注册在B mode时就无法去检测这个timer，所以需要把NSTimer也注册到A mode，这样就可以被检测
         *  到。
         */
    }
}

//刷新对应cell的数据
- (void)refreshLessTime
{
    float time;
    
    for (int i = 0; i < _timeData.count; i++) {
        //获取倒计时
        time = [[[self.timeData objectAtIndex:i] objectForKey:@"lastTime"] floatValue];
        //数据位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[[self.timeData objectAtIndex:i] objectForKey:@"indexPath"] integerValue] inSection:0];
        //cell位置
        UITableViewCell *cell = [self.tableViwe cellForRowAtIndexPath:indexPath];
        
        //当倒计时大于0的时候，刷新倒计时显示，反之显示已结束之类的提示
        if (time > 0) {

            cell.textLabel.text = [NSString stringWithFormat:@"%.2f",time];
            time = time - 0.1; //时间 -1
            
            //将新的时间放到数据源里面
            NSDictionary *dic = @{@"indexPath":[NSString stringWithFormat:@"%d",i],@"lastTime":[NSString stringWithFormat:@"%.2f",time]};
            
            [self.data replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:time]];
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
