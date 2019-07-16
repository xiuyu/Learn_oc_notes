//
//  LinkViewController.m
//  algorithm
//
//  Created by xiuyu on 2019/6/3.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "LinkViewController.h"
#import "LinkList.h"
#import "LinkedList.h"
#import "ListNode.h"

@interface LinkViewController ()

@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**双向链表*/
//    LinkedList<NSString *> *list2 = [[LinkedList alloc] init];
//    [list2 add:@"11"];
//    [list2 add:1 element:@"22"];
//    [list2 add:@"33"];
//
//    [list2 add:1 element:@"100"];
//    [list2 remove:1];
//
//
//    NSLog(@"%@",list2);
    
 
    


    /**单向链表*/
    LinkList *list = [[LinkList alloc] init];
    [list add:@"11"];
    [list add:1 element:@"22"];
    [list add:@"33"];

//    [list remove:1];

    //    NSLog(@"index = %ld",[list indexOf:@"22"]);


    //    [list clear];
    NSLog(@"%@",list);

    [list reverse];

    NSLog(@"=====");

    NSLog(@"%@",list);
    
 
//    [self nodeList];
   
}

-(void)nodeList
{
    ListNode *n = [ListNode addNode:nil value:@1];
    ListNode *p = [ListNode addNode:n value:@2];
    ListNode *s = [ListNode addNode:p value:@3];
    ListNode *o = [ListNode addNode:s value:@4];
    
    [ListNode traverseLink:n block:^(id  _Nonnull value) {
        NSLog(@"遍历%@",value);
    }];
    
    ListNode *node =[ListNode reverse2:n];
    
    NSLog(@"-------");
    [ListNode traverseLink:node block:^(id  _Nonnull value) {
        NSLog(@"遍历%@",value);
    }];
}




@end
