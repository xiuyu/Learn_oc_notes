//
//  SFFactory.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  简单工厂模式的主要参与者：
 *  工厂（Factory）角色：接受客户端的请求，通过请求负责创建相应的产品对象。
 *  抽象产品（AbstractProduct）角色: 是工厂模式所创建对象的父类或是共同拥有的接口。可是抽象类或接口。
 *  具体产品（ConcreteProduct）对象：工厂模式所创建的对象都是这个角色的实例。
 */

//---------------- 抽象产品 ----------------------//
@interface SFPerson : NSObject

@end

//---------------- 具体产品 ----------------------//
@interface SFUniversity : SFPerson

@end

//---------------- 具体产品 ----------------------//
@interface SFPrimary : SFPerson

@end

typedef NS_ENUM (NSInteger, SFFactoryType)
{
    SFFactoryTypePrimary,
    SFFactoryTypeUniversity,
};


//---------------- 抽象工厂 ----------------------//
@interface SFFactory : NSObject

+ (SFPerson *)createPersonWithType:(SFFactoryType)type;

@end

NS_ASSUME_NONNULL_END
