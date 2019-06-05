//
//  LinkViewController.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/6/3.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "LinkViewController.h"
#import "LinkNode.h"

@interface LinkViewController ()

@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self nodeList];
}


-(void)nodeList
{
    LinkNode *n = [LinkNode addNode:nil value:@2];
    LinkNode *k = [LinkNode addNode:n value:@8];
    LinkNode *s = [LinkNode addNode:k value:@10];
    
    [LinkNode traverseLink:s block:^(id  _Nonnull value) {
        
        NSLog(@"value %@",value);
    }];
}

@end
