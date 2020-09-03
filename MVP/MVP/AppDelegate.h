//
//  AppDelegate.h
//  MVP
//
//  Created by 丘秀玉 on 2020/3/12.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

