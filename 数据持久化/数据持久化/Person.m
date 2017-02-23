//
//  Person.m
//  数据持久化
//
//  Created by apple on 20/02/2017.
//  Copyright © 2017 bluceLiu. All rights reserved.
//

#import "Person.h"

@implementation Person
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.height = [aDecoder decodeFloatForKey:@"height"];
    
    return self;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeFloat:self.height forKey:@"height"];
    
}
@end
