//
//  PersonalViewController.m
//  MoonWeChat
//
//  Created by seth on 16/5/28.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "PersonalViewController.h"
#import "Person.h"



@interface PersonalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *dataArr;
@property(nonatomic, weak)UITableView *tableview;
@property(nonatomic, strong)Person *personInfo;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self preData];
    [self createTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)preData{
    _dataArr = @[
              @[@"头像", @"名字", @"微信号", @"我的二维码", @"我的地址"],
              @[@"性别", @"地区", @"个性签名"]
            ];
    _personInfo = [[Person alloc]init];
}

-(void)createTableview{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    
    tableview.dataSource = self;
    tableview.delegate = self;
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"personalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(220, 12, cell.frame.size.height - 2*12, cell.frame.size.height - 2*12)];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        imgView.image = [UIImage imageNamed: self.personInfo.avatar];
        [cell.contentView addSubview:imgView];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.detailTextLabel.text = self.personInfo.nickName;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.detailTextLabel.text = self.personInfo.weID;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        
    }
    if (indexPath.section == 0 && indexPath.row ==4) {
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"男";
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"广东 深圳";
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"明月几时有啊";
        }
    }
}

//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row ==0) {
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

@end
