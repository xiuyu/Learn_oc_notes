//
//  FFPeron.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFPeron : NSObject

- (void)eat;
- (void)sleep;

- (FFPeron *)eat2;
- (FFPeron *)sleep2;

- (FFPeron * (^)(void))eat3;
- (FFPeron * (^)(void))sleep3;

@end

NS_ASSUME_NONNULL_END
