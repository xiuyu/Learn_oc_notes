//
//  JSProtocol.h
//  WKWebViewJs
//
//  Created by xiuyu on 2019/6/19.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JSProtocol <JSExport>

-(void)print:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
