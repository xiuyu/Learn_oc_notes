//
//  SelectSortViewController.m
//  algorithm
//
//  Created by xiuyu on 2019/5/14.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "SelectSortViewController.h"

@interface SelectSortViewController ()

@end

@implementation SelectSortViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //稳定性：当待排序列中有相等的元素时，排序过程中很可能打乱相等元素的位置，经常会来回交换，因此选择排序是不稳定的排序。
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@10, @4, @5, @8, @2, nil];
    
    [self sort:array];
}

/**
 *      1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束。
 *  　　 2. i=1
 *  　　 3. 从数组的第i个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设arr[i]为最小，逐一比较，若遇到比之小的则交换）
 *  　　 4. 将上一步找到的最小元素和第i位元素交换。
 *  　　 5. 如果i=n－1算法结束，否则回到第3步
 *
 *  @param ascendingArr ascendingArr description
 */
- (void)sort:(NSMutableArray *)ascendingArr
{
    for (int i = 0; i < ascendingArr.count - 1; i++)
    {
        for (int j = i + 1; j < ascendingArr.count; j++)
        {
            if ([ascendingArr[i] integerValue] > [ascendingArr[j] integerValue])
            {
                NSNumber *temp = ascendingArr[i];
                ascendingArr[i] = ascendingArr[j];
                ascendingArr[j] = temp;
            }
        }
    }
    
    NSLog(@"选择排序结果：%@", ascendingArr);
}

@end
