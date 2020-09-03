//
//  AFFactory.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
*  抽象工厂（AbstractFactory）角色：担任这个角色的是工厂方法模式的核心，它是与应用系统商业逻辑无关的。
*  具体工厂（ConcreteFactory）角色：这个角色直接在客户端的调用下创建产品的实例。这个角色含有选择合适的产品对象的逻辑，而这个逻辑是与应用系统的商业逻辑紧密相关的。
*  抽象产品（AbstractProduct）角色：担任这个角色的类是工厂方法模式所创建的对象的父类，或它们共同拥有的接口。
*  具体产品（ConcreteProduct）角色：抽象工厂模式所创建的任何产品对象都是某一个具体产品类的实例。这是客户端最终需要的东西，其内部一定充满了应用系统的商业逻辑。
*/

typedef NS_ENUM(NSInteger,AFFactoryType) {
    AFFactoryTypePriMary,
    AFFactoryTypeUniversity
};

//---------------- 抽象产品 ----------------------//
@interface AFPerson : NSObject

@end

//---------------- 具体产品 ----------------------//
@interface AFPrimary : AFPerson

@end
//---------------- 具体产品 ----------------------//
@interface AFUniversity : AFPerson

@end


//---------------- 抽象工厂 ----------------------//
@interface AFFactory : NSObject

+(AFPerson *)createPerson;
+(AFPerson *)createPersonWithType:(AFFactoryType)type;

@end

//---------------- 具体工厂1 ----------------------//
@interface AFPrimaryFactory : AFFactory



@end

//---------------- 具体工厂二 ----------------------//
@interface AFUniversityFactory : AFFactory



@end

NS_ASSUME_NONNULL_END
