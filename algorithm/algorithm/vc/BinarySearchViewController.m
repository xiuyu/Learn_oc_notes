//
//  BinarySearchViewController.m
//  algorithm
//
//  Created by xiuyu on 2019/5/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BinarySearchViewController.h"

@interface BinarySearchViewController ()

@end

@implementation BinarySearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //在没使用算法之前时间复杂度是O(N)，而在使用算法之后，时间复杂度就变成了O(logN)
    NSArray *array = @[@1, @3, @6, @7, @9, @13];
    
    NSInteger index = [self binarySearch:array searchNum:9];
    
    NSLog(@"%ld", index);
}

/**
 *  二分法查找
 *  使用算法之前时间复杂度是O(N)，而在使用算法之后，时间复杂度就变成了O(logN)
 *  @param array 查找数组array
 *  @param num 需要查找的数据
 *  @return 结果index
 */
- (NSInteger)binarySearch:(NSArray *)array searchNum:(NSInteger)num
{
    NSInteger minIndex = 0;
    NSInteger maxIndex = array.count;
    
    while (maxIndex >= minIndex) {
        
        NSInteger midIndex = (maxIndex - minIndex) / 2 + minIndex;
        
        NSInteger midNum = [array[midIndex] integerValue];
        
        if (midNum == num)
        {
            return midIndex;
        }
        else if (num > midNum)
        {
            minIndex = midIndex + 1;
        }
        else
        {
            maxIndex = midIndex - 1;
        }
    }
    
    return -1;
}

@end
