//
//  ViewController.m
//  带扩展的tableView
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "SectionModel.h"
#import "HeaderView.h"

static  NSString * const ID = @"cellID";
static  NSString * const sectionID = @"sectionID";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray * sectionDataSource;//分区数据源

@end

@implementation ViewController

- (NSMutableArray *)sectionDataSource
{
    if (!_sectionDataSource) {
        _sectionDataSource = [[NSMutableArray alloc] init];
        
        
        for (int i = 0; i < 20; ++i) {
            
            SectionModel * model = [[SectionModel alloc] init];
            model.isExpanded = NO;
            model.sectionTitle = [NSString stringWithFormat:@"section:%d",i];
        
        
        NSMutableArray * cellDataSource = [NSMutableArray array];
        for (int j = 0; j < 10; ++j) {
            
            CellModel * cellModel = [CellModel new];
            
            cellModel.cellTitle = [NSString stringWithFormat:@"cell:Section = %d;row = %d",i,j];
            [cellDataSource addObject:cellModel];
        }
            model.cellModels = [NSMutableArray array];
            [model.cellModels addObjectsFromArray:cellDataSource];
            
            [_sectionDataSource addObject:model];
        }
    }
    
    return _sectionDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_group_t  group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"线程一");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        
        [NSThread sleepForTimeInterval:10];
        NSLog(@"线程二");
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程一二都执行完毕");
    });
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:sectionID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //方法一
    //HeaderView * headerView = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil].lastObject;
    //方法二
    HeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionID];
    SectionModel * sectionModel = self.sectionDataSource[section];
    headerView.model = sectionModel;
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor purpleColor];
    headerView.backgroundView = view;
    headerView.expandCallBack = ^(BOOL isExpanded){
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel * model = self.sectionDataSource[section];
    
    return  model.isExpanded ? model.cellModels.count : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionModel * sectionModel = self.sectionDataSource[indexPath.section];
    CellModel * cellModel = sectionModel.cellModels[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        NSLog(@"创建了cell");
    }
    cell.textLabel.text = cellModel.cellTitle;
    
    return cell;
}


@end
