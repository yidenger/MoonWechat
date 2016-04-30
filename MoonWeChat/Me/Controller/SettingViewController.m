//
//  SettingViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/11.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArr;

@end

@implementation SettingViewController


-(void)viewWillAppear:(BOOL)animated{

    [self preData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    
//    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [self createTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)preData{

    _dataArr = @[@[@"帐号与安全"],
                 @[@"新消息通知", @"隐私", @"通用"],
                 @[@"帮助与反馈", @"关于微信"],
                 @[@"退出登录"]
                ];
}

-(void)createTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

#pragma mark - tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArr[section] count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        //右侧小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 3) {
        cell.textAlignment = UITextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];

}

//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

    
    if (indexPath.section == 3) {
        NSLog(@"you click logout button");
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        EMError *error = [[EMClient sharedClient]logout:YES];
        if (!error) {
            NSLog(@"退出登录成功");
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:0];
            
            //显示一个成功的提示
            MBProgressHUD *successHud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            successHud.labelText = @"退出成功";
            successHud.mode = MBProgressHUDModeCustomView;
            successHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
            successHud.removeFromSuperViewOnHide = YES;
            [successHud hide:true afterDelay:2];
            successHud.completionBlock = ^(){
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [self presentViewController:loginVC animated:YES completion:nil];
            };
            
        }
        else{
            NSLog(@"退出登录失败");
        }
        
    }
}






@end
