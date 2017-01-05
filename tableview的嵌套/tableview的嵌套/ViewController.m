//
//  ViewController.m
//  tableview的嵌套
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "LPListModel.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataList;//数据源
@end

@implementation ViewController

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
      
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]];
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray * LPModelArray = dataDic[@"data"][@"rows"];
        
        
        for (NSDictionary * dic in LPModelArray) {
            
            NSError * error = nil;
            LPListModel * model = [[LPListModel alloc] initWithDictionary:dic error:&error];
            [_dataList addObject:model];
        }
        
    }
    
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
}
#pragma mark ---tableView  Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPListModel * model = self.dataList[indexPath.row];
    
    //通过fd_heightForCellWithIdentifier一行代码返回cell高度
    return [tableView fd_heightForCellWithIdentifier:@"TableViewCell" configuration:^(TableViewCell *cell) {
        
        [cell configureCellWithModel:model withIndexpath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //添加预估高度改变heightForRow 和 cellForRow：的顺序
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LPListModel * model = self.dataList[indexPath.row];
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"forIndexPath:indexPath];
    [cell configureCellWithModel:model withIndexpath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
