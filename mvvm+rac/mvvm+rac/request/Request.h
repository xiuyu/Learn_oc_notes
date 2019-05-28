//
//  Request.h
//  mvvm+rac
//
//  Created by 丘秀玉 on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Request : NSObject

+ (void)loginSucess:(void (^)(NSDictionary *))sucess fail:(void (^)(NSDictionary *))fail;

@end

NS_ASSUME_NONNULL_END
