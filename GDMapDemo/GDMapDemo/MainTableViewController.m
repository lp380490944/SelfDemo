//
//  MainTableViewController.m
//  GDMapDemo
//
//  Created by apple on 2016/12/8.
//  Copyright © 2016年 bluceLiu. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()
@property(nonatomic,strong)NSArray * titleArr;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            [self performSegueWithIdentifier:@"toBasic" sender:nil];
            break;
        }
        case 1:{
            [self performSegueWithIdentifier:@"toAddControls" sender:nil];
            break;
        }
        default:
            break;
    }
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = @[@"基本设置标注视图和卫星云图等",
                           @"缩放控件定位按钮、指南针比例尺等"];
    }
    
    return _titleArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
