//
//  IncisionAnimate.h
//  Draw
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^IncisionAnimateBlock)();

@interface IncisionAnimate : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) BOOL repeat;

@property (nonatomic, assign) BOOL enableLeft;
@property (nonatomic, assign) BOOL enableRight;

- (instancetype)initWithBaseview:(UIView *)view space:(CGFloat)space;

- (void)start;
- (void)startWithComplete:(IncisionAnimateBlock)block;
- (void)stopAfterEnd;
- (void)stopImmediately;

@end
