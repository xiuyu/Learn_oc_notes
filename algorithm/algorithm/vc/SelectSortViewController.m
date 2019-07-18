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
    
    //    [self sort:array];
    
    [self heapSort:array];
}

/**
 *  堆排序
 * 1.把数组遍历成大顶堆
 * 2.交互第一个位置和最后一位置
 * 3.再遍历成大顶堆
 * 4.交互位置
 * 5.以此类推
 *  @param array 需要排序的数据
 */
- (void)heapSort:(NSMutableArray *)array
{
    //从最后一个非叶子节点开始遍历 把数组转成大顶堆
    NSInteger start = (array.count - 1) / 2;
    
    for (NSInteger i = start; i >= 0; i--)
    {
        [self maxHeap:array size:array.count index:i];
    }
    
    for (NSInteger i = array.count - 1; i >= 0; i--)
    {
        //交互第一个和最后一个
        NSNumber *temp = array[0];
        array[0] = array[i];
        array[i] = temp;
        
        [self maxHeap:array size:i index:0];
    }
}

/**
 *  大顶堆
 *  @param array 数组
 *  @param size 长度
 *  @param index 调整位置
 */
- (void)maxHeap:(NSMutableArray *)array size:(NSInteger)size index:(NSInteger)index
{
    NSInteger leftIndex = 2 * index + 1;
    NSInteger rightIndex = 2 * index + 2;
    NSInteger maxIndex = index;
    
    if (leftIndex < size && [array[leftIndex] integerValue] > [array[maxIndex] integerValue])
    {
        maxIndex = leftIndex;
    }
    
    if (rightIndex < size && [array[rightIndex] integerValue] > [array[maxIndex] integerValue])
    {
        maxIndex = rightIndex;
    }
    
    if (maxIndex != index)
    {
        //交换位置
        NSNumber *temp = array[index];
        array[index] = array[maxIndex];
        array[maxIndex] = temp;
        //判断改节点后面的元素大小
        [self maxHeap:array size:size index:maxIndex];
    }
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
