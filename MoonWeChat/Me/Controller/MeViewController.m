//
//  MeViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/23.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MeViewController.h"
#import "Person.h"
#import "PersonCell.h"
#import "SettingViewController.h"
#import "PersonalViewController.h"

@interface MeViewController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak)UITableView *tableView;

@property(nonatomic, copy)NSArray *dataArr;

@property(nonatomic, copy)NSArray *imgArr;

@property(nonatomic, strong)Person *model;

@end

@implementation MeViewController

-(void)viewDidAppear:(BOOL)animated{

    [self preData];

}

-(void)viewDidLoad{

    [super viewDidLoad];
    
//    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTableView];

}

//准备数据
-(void)preData{
    
    _dataArr = @[@[@""],
                 @[@"相册", @"收藏", @"钱包"],
                 @[@"表情"],
                 @[@"设置"]
                 ];
    _imgArr = @[@[@""],
                @[@"me_photo", @"me_collect", @"me_money"],
                @[@"me_smile"],
                @[@"me_setting"]
                ];
    
    Person *model = [[Person alloc]init];
    _model = model;
    
    if (_tableView) {
        [_tableView reloadData];
    }
    
}

//创建tableView
-(void)createTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;

    //调整下分隔线位置
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView = tableView;
    
    [self.view addSubview:tableView];

}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArr.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *rowArr = _dataArr[section];
    return rowArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        PersonCell *cell = [[PersonCell alloc]init];
        
        return cell;
    }
    else{
        static NSString *identifier = @"meCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            //右侧小箭头
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell;
        
    }
}

//养成习惯在willDisplayCell中处理数据
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        PersonCell *personCell = (PersonCell *)cell;
        [personCell setModel:_model];
    }
    else{
        NSString *imgName = self.imgArr[indexPath.section][indexPath.row];
        NSLog(@"imgName: (%@)", imgName);
        cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    }
}

//设置row高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        return WGiveHeight(87);
    }
    return WGiveHeight(43);
}

//设置头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return WGiveHeight(15);
    }
    
    return WGiveHeight(10);
}

//设置脚视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return WGiveHeight(10);

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PersonalViewController *personalVC = [[PersonalViewController alloc]init];
        personalVC.title = @"个人信息";
        [self.navigationController pushViewController:personalVC animated:YES];
    }
    else{
        NSLog(@"table click...");
        SettingViewController *settingVC = [[SettingViewController alloc]init];
        settingVC.title = @"设置";
        [self.navigationController pushViewController:settingVC animated:YES];
    }

    

}

















@end
