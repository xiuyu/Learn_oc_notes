//
//  ViewController.m
//  algorithm
//
//  Created by xiuyu on 2019/5/14.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ViewController.h"
#import "LinkedList.h"

#define SUM(a,b) ((a) + (b))

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSArray *vcs;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"算法";
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.dataArray = @[@"冒泡（快）排序", @"插入(希尔)排序", @"选择排序、堆排", @"二分法查找", @"链表", @"二叉树"];

    self.vcs = @[@"BubbleSortViewController", @"InsertSortViewController", @"SelectSortViewController", @"BinarySearchViewController", @"LinkViewController", @"BinaryTreeViewController"];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 13.0, *)) {
        self.tableView.backgroundColor =  [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
    }
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    


   
//    self.traitCollection.userInterfaceStyle = UIUserInterfaceStyleDark;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cls = NSClassFromString(self.vcs[indexPath.row]);
    
    UIViewController *vc = [[cls alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
