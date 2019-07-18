//
//  TreeNode.h
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

@property (nullable,strong, nonatomic) TreeNode *leftNode;

@property (nullable,strong, nonatomic) TreeNode *rightNode;

@property (assign, nonatomic) NSInteger val;



- (instancetype)initWithNode:(NSInteger)val;

@end

NS_ASSUME_NONNULL_END
