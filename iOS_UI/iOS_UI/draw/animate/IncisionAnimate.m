//
//  IncisionAnimate.m
//  Draw
//
//

#import "IncisionAnimate.h"

@interface IncisionAnimate ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) BOOL animating;

@property (nonatomic, strong) CAShapeLayer *leftLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;
@end

@implementation IncisionAnimate

- (instancetype)init
{
	self = [super init];

	if (self)
	{
		self.duration = 1.0f;
		self.repeat = NO;
		self.animating = NO;
		self.enableLeft = YES;
		self.enableRight = YES;
	}
	return self;
}

- (instancetype)initWithBaseview:(UIView *)view space:(CGFloat)space;
{
	self = [self init];

	if (self)
	{
		CGFloat width = view.frame.size.width;
		CGFloat height = view.frame.size.height;

		UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];

		UIBezierPath *bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];

//		if (self.enableRight)
//		{
		CAShapeLayer *sublayer1 = [[CAShapeLayer alloc] init];
		sublayer1.path = bezier.CGPath;
		sublayer1.position = CGPointZero;
		[maskView.layer addSublayer:sublayer1];
		self.rightLayer = sublayer1;
//		}

//		if (self.enableLeft)
//		{
		CAShapeLayer *sublayer2 = [[CAShapeLayer alloc] init];
		sublayer2.path = bezier.CGPath;
		sublayer2.fillColor = [UIColor greenColor].CGColor;
		sublayer2.position = CGPointMake(0 - width - space, 0);
		[maskView.layer addSublayer:sublayer2];
//		}
		self.leftLayer = sublayer2;

		view.maskView = maskView;

		self.maskView = maskView;
		self.space = space;
	}
	return self;
}

- (void)setEnableLeft:(BOOL)enableLeft
{
	_enableLeft = enableLeft;

	if (self.leftLayer != nil)
	{
		self.leftLayer.hidden = !enableLeft;
	}
}

- (void)setEnableRight:(BOOL)enableRight
{
	_enableRight = enableRight;

	if (self.rightLayer != nil)
	{
		self.rightLayer.hidden = !enableRight;
	}
}

- (void)start
{
	if (self.animating)
	{
		return;
	}

	self.animating = YES;

	CGFloat width = self.maskView.frame.size.width;
	CGFloat height = self.maskView.frame.size.height;

	self.maskView.frame = CGRectMake(0, 0, width, height);

	[UIView animateWithDuration:self.duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
		self.maskView.frame = CGRectMake(width + self.space, 0, width, height);
	} completion:^(BOOL finished) {
		self.animating = NO;

		if (self.repeat)
		{
			[self start];
		}
	}];
}

- (void)startWithComplete:(IncisionAnimateBlock)block
{
	if (self.animating)
	{
		return;
	}

	self.animating = YES;
	CGFloat width = self.maskView.frame.size.width;
	CGFloat height = self.maskView.frame.size.height;

	self.maskView.frame = CGRectMake(0, 0, width, height);

	[UIView animateWithDuration:self.duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
		self.maskView.frame = CGRectMake(width + self.space, 0, width, height);
	} completion:^(BOOL finished) {
		self.animating = NO;

		if (block)
		{
			block();
		}
	}];
}

- (void)stopImmediately
{
	self.repeat = NO;
	[self.maskView.layer removeAllAnimations];
}

- (void)stopAfterEnd
{
	self.repeat = NO;
}

@end
