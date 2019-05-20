//
//  MarqueeViewCell.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "MarqueeViewCell.h"
#import "masonry.h"

@interface MarqueeViewCell ()

@property (strong,nonatomic) UILabel *typeLab;

@end

@implementation MarqueeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.typeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 4, 30, 14)];
        self.typeLab.text = @"最新";
        self.typeLab.textColor = [UIColor orangeColor];
        self.typeLab.layer.borderColor = [UIColor orangeColor].CGColor;
        self.typeLab.layer.borderWidth  = 1;
        self.typeLab.layer.cornerRadius = 2;
        self.typeLab.textAlignment = NSTextAlignmentCenter;
        self.typeLab.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.typeLab];
        
        self.newsLab = [[UILabel alloc] initWithFrame:CGRectMake(55, 1, 300, 22)];
        self.newsLab.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.newsLab];
    }
    
    return self;
}

@end
