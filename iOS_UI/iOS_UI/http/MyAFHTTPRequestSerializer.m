//
//  MyAFHTTPRequestSerializer.m
//  iOS_UI
//
//  Created by xiuyu on 2019/6/24.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "MyAFHTTPRequestSerializer.h"

@implementation MyAFHTTPRequestSerializer

/**二进制*/
- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *r = (NSMutableURLRequest *)[super requestBySerializingRequest:request withParameters:parameters error:error];
    
    [r setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [r setHTTPBody:parameters];
    
    return r;
}

@end
