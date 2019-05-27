//
//  SearchHistoryView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "SearchHistoryView.h"

@implementation SearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {}
    
    return self;
}

- (void)setTitleArray:(NSArray *)historyArray
{
    _titleArray = historyArray;
    
    // 先将所有子控件移除
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
    
    // 行
    NSInteger currentRow = 0;
    //开始间距
    CGFloat lastX = 20;
    
    CGFloat startX = 20;
    //间距
    CGFloat distance = 10;
    //高度
    CGFloat labelHeight = 30;
    //文本内间距
    CGFloat labelIterval = 30;
    //文本高度间距
    CGFloat heightInterval = 10;
    
    UIFont *font = [UIFont systemFontOfSize:13];
    
    
    for (int i = 0; i < _titleArray.count; i++)
    {
        NSString *title = _titleArray[i];
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        button.layer.cornerRadius = 2;
        button.tag = i;
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:font];
        [self addSubview:button];
        
        NSDictionary *dic = @{NSFontAttributeName : font};
        
        CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
        
        /**是否需要换行*/
        if (lastX + labelIterval + size.width > ScreenWidth)
        {
            if (size.width + 2 * startX +  labelIterval > ScreenWidth)
            {
                CGSize s = size;
                s.width = ScreenWidth - 2 * startX - labelIterval;
                size = s;
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 10 , 0, 10);
            }
            
            lastX = startX;
            currentRow += 1;
        }
        
        /**计算位置*/
        CGFloat x = lastX;
        CGFloat y = currentRow * (labelHeight + heightInterval);
        CGFloat width = size.width + labelIterval;
        CGFloat height = labelHeight;
        
        button.frame = CGRectMake(x, y, width, height);
        
        lastX = x + distance + width;
    }
}

- (void)buttonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchHistoryWiew:clickedButtonAtIndex:)])
    {
        [self.delegate searchHistoryWiew:self clickedButtonAtIndex:sender.tag];
    }
}

-(void)dealloc
{
    NSLog(@"search history delloc");
}

@end
