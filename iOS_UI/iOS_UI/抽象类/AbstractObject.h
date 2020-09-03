//
//  AbstractObjec.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/12.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AbstractObject : NSObject

//你不能实例化一个抽象类。然而，我们可以尝试复制该方案在Objective-C中采用一些技巧，要确保不能实例化你的父类。
- (id)abstractObject:(id)obj;

@end

 
NS_ASSUME_NONNULL_END
