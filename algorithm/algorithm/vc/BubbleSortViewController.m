//
//  BubbleSortViewController.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/5/14.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "BubbleSortViewController.h"

@interface BubbleSortViewController ()

@end

@implementation BubbleSortViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@10, @4, @5, @8, @2, nil];
    
    [self sort:array];
    
    //    NSLog(@"%@",[self quickSort:array]);
    
   
    /**快速排序之所比较快，因为相比冒泡排序，每次交换是跳跃式的。每次排序的时候设置一个基准点，
     将小于等于基准点的数全部放到基准点的左边，将大于等于基准点的数全部放到基准点的右边。
     
     这样在每次交换的时候就不会像冒泡排序一样每次只能在相邻的数之间进行交换，交换的距离就大的多了。
     因此总的比较和交换次数就少了，速度自然就提高了。
     
     当然在最坏的情况下，仍可能是相邻的两个数进行了交换。因此快速排序的最差时间复杂度和冒泡排序是一样的都是O(N2)，它的平均时间复杂度为O(NlogN)。
     */
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6), @(1),@(2),@(5),@(9),@(4),@(3),@(7),nil];
    
    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
    
    NSLog(@"%@",arr);
}

/**
 1 .设置两个变量i，j  ，排序开始时i = 0，就j = mutableArray.count - 1；
 2 .设置数组的第一个值为比较基准数key，key = mutableArray.count[0]；
 3 .因为设置key为数组的第一个值，所以先从数组最右边开始往前查找比key小的值。如果没有找到，j--继续往前搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往前搜索，进入第4步；
 4 .从i位置开始往后搜索比可以大的值，如果没有找到，i++继续往后搜索；如果找到则将mutableArray[i]和mutableArray[j]互换，并且停止往后搜索；
 5 .重复第3、4步，直到i == j（此时刚好执行完第三步或第四部），停止排序；
 6 . 时间复杂度为O(nlogn),最坏的情况下为O(n²)。平实的情况为O(nlogn)。
 @param array array description
 @param leftIndex leftIndex description
 @param rightIndex rightIndex description
 */
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }

    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);

    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}


/**
 *  比较相邻的元素。如果第一个比第二个大，就交换他们两个。
 *  冒泡排序的优化：
 *  1. 每跑完一趟就判断一次原数组现在是否有序，如果有序；直接return 掉；于是这里就有了一个标志位flag去帮助我们判断！
 *  2.保存最后一次交换的下标。
 *
 *  @param ascendingArr ascendingArr
 */
- (void)sort:(NSMutableArray *)ascendingArr
{
    NSInteger k = ascendingArr.count - 1;
    
    for (NSInteger i = 0; i < ascendingArr.count - 1; i++)
    {
        NSInteger flag = 1;
        
        NSInteger n = 0; //保存最后一次交换的下标
        
        for (NSInteger j = 0; j < k; j++)
        {
            if ([ascendingArr[j] integerValue] > [ascendingArr[j + 1] integerValue])
            {
                flag = 0;
                NSNumber *temp = ascendingArr[j + 1];
                ascendingArr[j + 1] = ascendingArr[j];
                ascendingArr[j] = temp;
                // [ascendingArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                n = j;
            }
        }
        
        if (flag == 1)
        {
            break;
        }
        
        k = n;
    }
    
    NSLog(@"冒泡升序排序结果：%@", ascendingArr);
}

@end
