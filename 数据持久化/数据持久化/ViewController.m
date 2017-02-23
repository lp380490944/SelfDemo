//
//  ViewController.m
//  数据持久化
//
//  Created by apple on 20/02/2017.
//  Copyright © 2017 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //查找应用根目录
    NSString * home = NSHomeDirectory();
    NSString * documents = [home stringByAppendingPathComponent:@"Documents"];
    
    NSString * tmp = NSTemporaryDirectory();
    
    NSArray * plistArr = @[@"张三",@7,@"男"];
    
    
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:@"man"];
    
    [plistArr writeToFile:path atomically:YES];
    
    NSLog(@"%@",path);
    [self StoreDictionaryWithPlist];
    [self restoreDicWithPlistPath];
    [self NSUserDefaults];
    [self Archiver];
    [self nskeyedArchiverPerson];
    [self archiverTwoPersonToOneFile];
    [self restoreTwoPersonFromFile];
    [self deepCopyOnePerson];
    
    
}

-(void)StoreDictionaryWithPlist
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"张三" forKey:@"name"];
    [dic setObject:@"14242435353" forKey:@"phone"];
    [dic setObject:@13 forKey:@"age"];
    //将字典持久化到Documents/object.plist
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"object.plist"];
    [dic writeToFile:path atomically:YES];
    
    NSLog(@"%@",path);
    
}

- (void)restoreDicWithPlistPath
{
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"object.plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSLog(@"%@",[dic objectForKey:@"name"]);
    
}
- (void)NSUserDefaults
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"张三" forKey:@"name"];
    [defaults setObject:@17 forKey:@"age"];
    [defaults setObject:@"187903342424" forKey:@"phone"];
    
    NSString * home  = NSHomeDirectory();
    
    NSString * path = [home stringByAppendingPathComponent:@"Library/Preference"];
    NSLog(@"%@",path);
    
    //读取偏好设置
    NSString * name = [defaults objectForKey:@"name"];
    NSString * phone = [defaults objectForKey:@"phone"];
    NSInteger age = [defaults integerForKey:@"age"];
    
    NSLog(@"%@、%@、%ld",name,phone,age);
    
}


-(void)Archiver{
    
    //归档编码
    NSArray * array = @[@"a",@"b",@"c"];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"array.Archive"];
    
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
    NSLog(@"%@",path);
    //解归档 解码
    
    NSArray * newArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"array = %@",newArray);
}

#pragma mark --  对象归档

- (void)nskeyedArchiverPerson
{
    Person * person = [[Person alloc] init];
    
    person.name = @"MJ";
    person.age = 19;
    person.height = 1.88;
    
    //先设置要归档的位置
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"person.Archiver"];
    
    //对象person归档
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
    NSLog(@"%@",path);
    
    //person对象的解归档
    Person * newPerson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    
    NSLog(@"%@,%ld,%.2f",newPerson.name,newPerson.age,newPerson.height);
    
}

#pragma mark -- 将两个person对象归档到同一个文件中。
- (void)archiverTwoPersonToOneFile
{
    
    //1、新建一个可变的数据区
    
    NSMutableData * data = [NSMutableData data];
    //2、将一个数据区连接到一个archiver对象
    
    //initForWritingWithMutableData:
    //Returns the receiver, initialized for encoding an archive into a given a mutable-data object. 这个方法的作用是返回一个接收者(初始化将归档编码为给定的mutableData)
    //data:The mutable-data object into which the archive is written.
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    
    //3、开始存储对象，存储的对象都会存储到NSMutableData中
    Person * person1 = [[Person alloc] init];
    person1.name = @"张三";
    person1.age = 50;
    person1.height = 1.999;
    
    
    Person * person2 = [[Person alloc] init];
    person2.name = @"李四";
    person2.age = 80;
    person2.height = 2.25;
    
    [archiver encodeObject:person1 forKey:@"person1"];
    [archiver encodeObject:person2 forKey:@"person2"];
    //4、存档完毕调用存档结束方法
    [archiver finishEncoding];
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"twoPerson.archiver"];
    
    //5、将存档写入文件
    [data writeToFile:path atomically:YES];
    
    NSLog(@"%@",path);
    
    
}

#pragma mark -- 从同一个文件中恢复两个person

- (void)restoreTwoPersonFromFile
{
    //1、获取存储的路径
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/twoPerson.archiver"];
    //2、从文件中读取数据
    NSData * data = [NSData dataWithContentsOfFile:path];
    
        //3、根据数据解析成archiver对象
    
    //Initializes the receiver for decoding an archive previously encoded by NSKeyedArchiver.//初始化接收器以解码先前由NSKeyedArchiver编码的档案。
    NSKeyedUnarchiver * unachiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];

    Person * person1 = [unachiver decodeObjectForKey:@"person1"];
    Person * person2 = [unachiver decodeObjectForKey:@"person2"];
    
    //4、恢复完毕
    [unachiver finishDecoding];
    
    NSLog(@"%@,%@",person1.name,person2.name);
    
}

- (void)deepCopyOnePerson
{
    Person * person = [[Person alloc] init];
    person.name = @"深复制";
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:person];
    Person * newPerson = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"person:%@",person);//person:<Person: 0x60800003c8e0>
    NSLog(@"newPerson:%@",newPerson);//newPerson:<Person: 0x60000003c900>
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
