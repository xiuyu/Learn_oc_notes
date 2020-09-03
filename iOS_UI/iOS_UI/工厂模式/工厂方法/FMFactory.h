//
//  FMFactory.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  抽象工厂角色：与应用程序无关，任何在模式中创建对象的工厂必须实现这个接口。
 *  具体工厂角色：实现了抽象工厂接口的具体类，含有与引用密切相关的逻辑，并且受到应用程序的调用以创建产品对象。
 *  抽象产品角色：工厂方法所创建产品对象的超类型，也就是产品对象的共同父类或共同拥有的接口。
 *  具体产品角色：这个角色实现了抽象产品角色所声名的接口。工厂方法所创建的每个具体产品对象都是某个具体产品角色的实例。
 */

NS_ASSUME_NONNULL_BEGIN

//---------------- 抽象产品 ----------------------//
@interface FMPerson : NSObject

@end

//---------------- 具体产品 ----------------------//
@interface FMUniversity : FMPerson

@end

//---------------- 具体产品 ----------------------//
@interface FMPrimary : FMPerson

@end


//---------------- 抽象工厂 ----------------------//
@interface FMFactory : NSObject

+ (FMPerson *)createPerson;

@end

//---------------- 具体工厂1 ----------------------//
@interface FMPrimaryFactory : FMFactory

@end

//---------------- 具体工厂2 ----------------------//
@interface FMUniversityFactory : FMFactory

@end

NS_ASSUME_NONNULL_END
