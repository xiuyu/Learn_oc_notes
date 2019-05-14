//
//  InsertSortViewController.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/5/14.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "InsertSortViewController.h"

@interface InsertSortViewController ()

@end

@implementation InsertSortViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*插入排序就是每一步都将一个待排数据按其大小插入到已经排序的数据中的适当位置，直到全部插入完毕。 插入排序方法分直接插入排序和折半插入排序两种。*/
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@10, @4, @5, @8, @2, nil];
    
    [self sort:array];
    
//    [self sort2:array];
}

/**
 *  　  1. 从第一个元素开始，认为该元素已经是排好序的。
 *  　　2. 取下一个元素，在已经排好序的元素序列中从后向前扫描。
 *  　　3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。
 *  　　4. 重复步骤3，直到已排好序的元素小于或等于新元素。
 *  　　5. 在当前位置插入新元素。
 *  　　6. 重复步骤2。
 *
 *  @param ascendingArr ascendingArr
 */
- (void)sort:(NSMutableArray *)ascendingArr
{
    for (int i = 1; i < ascendingArr.count; i++)
    {
        NSInteger temp = [ascendingArr[i] integerValue];

        for (int j = i - 1; j >= 0; j--)
        {
            if (temp < [ascendingArr[j] integerValue])
            {
                ascendingArr[j + 1] = ascendingArr[j];
                ascendingArr[j] = [NSNumber numberWithInteger:temp];

            }
        }
    }
    
    NSLog(@"插入升序排序结果：%@", ascendingArr);
}





- (void)sort2:(NSMutableArray *)ascendingArr
{
    for (int i = 0; i < ascendingArr.count; i++)
    {
        NSNumber *temp = ascendingArr[i];
        
        for (int j = i - 1; j >= 0; j--)
        {
            if ([ascendingArr[j] compare:temp] == NSOrderedDescending)
            {
                [ascendingArr replaceObjectAtIndex:j + 1 withObject:ascendingArr[i]];
                [ascendingArr replaceObjectAtIndex:j withObject:temp];
            }
        }
    }
    
    NSLog(@"%@", ascendingArr);
}

@end
