//
//  InsertSortViewController.m
//  algorithm
//
//  Created by xiuyu on 2019/5/14.
//  Copyright © 2019 xiuyu. All rights reserved.
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
    
    /*希尔排序是把记录按下标的一定增量分组，对每组使用直接插入排序算法排序；随着增量逐渐减少，每组包含的关键词越来越多，当增量减至1时，整个文件恰被分成一组，算法便终止。*/
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6), @(1), @(2), @(5), @(9), @(4), @(3), @(7), nil];
    
    [self shellSort:arr];
    
    NSLog(@"%@", arr);
}

/**
 * 起始间隔值gap设置为总数的一半，直到gap==1结束
 *在最坏的情况下时间复杂度仍为O(n²),而使用最优的增量在最坏的情况下却为O(n²⁄³)。
 *增量序列的最后一个增量值必须等于1才行。
 * 由于记录是跳跃式的移动，希尔排序并不是一种稳定的排序算法。
 *  @param array array description
 */
- (void)shellSort:(NSMutableArray *)array
{
    //@(6), @(1), @(2), @(5), @(9), @(4), @(3), @(7)
    
    NSInteger gap = (NSInteger)array.count;
    
    while (gap >= 1) {
        
        for (NSInteger i = gap; i < array.count; i++)
        {
            NSInteger temp = [array[i] integerValue];
            
            NSInteger j = i;
            
            //如果前面的元素比temp大就替换
            while (j >= gap && temp < [array[j - gap] integerValue]) {
                
                [array replaceObjectAtIndex:j withObject:array[j - gap]];
                j -= gap;
            }
            
            [array replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        }
        
        gap = gap / 2;
    }
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
