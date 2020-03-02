//
//  ViewController.m
//  runtime
//
//  Created by xiuyu on 2019/4/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSArray *dataArray;

@property (strong,nonatomic) NSArray *vcs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"runtime使用";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"方法交换",@"获取方法列表(修改系统私有属性)",@"反射",@"分类添加属性",@"消息转发"];
    
    self.vcs = @[@"ExchangeIMPViewController",@"GetAllIvarViewController",@"RefectViewController",@"CategoryIvarViewController",@"MsgTransViewController"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    
//    People *p = [[People alloc] init];
//
//    @autoreleasepool {
//        [p autorelease];
//        @autoreleasepool {
//             [p autorelease];
//        }
//    }
//
    
//    self methodForSelector:(SEL)
    
    

    NSSet *set = [[NSSet alloc] initWithObjects:@1,@5,@8, nil];
    
    [set allObjects];
    
    NSOrderedSet *sets = [[NSOrderedSet alloc] initWithObjects:@3,@5, nil];
    
//    sets objectAtIndex:<#(NSUInteger)#>
    
    NSCountedSet *countSet = [[NSCountedSet alloc] initWithObjects:@"ios",@"ios", nil];
    [countSet addObject:@"java"];
    
    NSLog(@"%@",countSet);
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
