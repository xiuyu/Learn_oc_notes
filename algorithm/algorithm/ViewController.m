//
//  ViewController.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/5/14.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSArray *dataArray;

@property (strong,nonatomic) NSArray *vcs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"算法";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"冒泡（快）排序",@"插入排序",@"选择排序",@"semaphore加锁",@"lock加锁",@"死锁"];
    
    self.vcs = @[@"BubbleSortViewController",@"InsertSortViewController",@"SelectSortViewController",@"SemaphoreLockViewController",@"LockViewController",@"DeadLockViewController"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class cls = NSClassFromString(self.vcs[indexPath.row]);
    
    UIViewController *vc = [[cls alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
