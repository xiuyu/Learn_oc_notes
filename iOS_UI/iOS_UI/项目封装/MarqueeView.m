//
//  MarqueeView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "MarqueeView.h"
#import "MarqueeViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

static const NSInteger cellHeight = 22;

@interface MarqueeView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, cellHeight * 2) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerHander) userInfo:nil repeats:self];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idetify = @"MarqueeViewCell";
    MarqueeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetify];
    
    if (cell == nil)
    {
        cell = [[MarqueeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetify];
    }
    cell.newsLab.text = self.titleArray[indexPath.row % self.titleArray.count];
    
    return cell;
}

- (void)timerHander
{
    if (self.superview)
    {
        //当前滚动到第一行
        CGFloat i = floor(self.tableView.contentOffset.y / cellHeight * 2);
        
        //计算要滚动位置
        CGFloat y = (i + 1) * cellHeight * 2;
        
        CGPoint p = CGPointMake(0, y);
        [self.tableView setContentOffset:p animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= self.titleArray.count * cellHeight)
    {
        [scrollView setContentOffset:CGPointZero animated:NO];
    }
}

@end
