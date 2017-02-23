//
//  Person.h
//  数据持久化
//
//  Created by apple on 20/02/2017.
//  Copyright © 2017 bluceLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,assign)float height;
@end
