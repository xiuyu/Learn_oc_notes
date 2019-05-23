//
//  TextFadeView.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/5/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFadeView : UIView

@property (strong,nonatomic) UILabel *label;

@property (strong,nonatomic) UIView *layerView;


-(void)fade;

@end

NS_ASSUME_NONNULL_END
