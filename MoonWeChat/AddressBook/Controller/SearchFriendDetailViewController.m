//
//  SearchFriendDetailViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/21.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "SearchFriendDetailViewController.h"
#import "AddFriendViewController.h"
#import "MBProgressHUD.h"

@interface SearchFriendDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)UITableView *tableview;

@end

@implementation SearchFriendDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [super viewWillAppear:YES];
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    NSLog(@"hehe");
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    NSLog(@"view disappear ...");
}

#pragma mark 创建表格
-(void)createTableView{

    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
//    tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableview.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    self.tableview = tableview;

}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        default:
            return 1;
            break;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"searchFriendDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        if (indexPath.section == 3) {
            cell = [[UITableViewCell alloc]init];
            UIButton *addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(21, 0, 278, 47)];
            [addAddressBtn setTitle:@"添加到通讯录" forState:UIControlStateNormal];
            addAddressBtn.backgroundColor = [UIColor colorWithRed:26/255.0 green:173/255.0 blue:25/255.0 alpha:1];
            [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            addAddressBtn.layer.cornerRadius = 3.0;
            [addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addAddressBtn];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else{
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 87;
    }
    else if(indexPath.section == 3){
        return 47;
    }
    else{
        return 44;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 21.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"avatar"];
        cell.textLabel.text = self.userInfo[@"nickName"];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"设置备注和标签";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"地区";
                cell.detailTextLabel.text = @"中国";
                break;
            case 1:
                cell.textLabel.text = @"社交资料";
                cell.detailTextLabel.text = self.userInfo[@"userName"];
                break;
            case 2:
                cell.textLabel.text = @"来源";
                cell.detailTextLabel.text = @"来自帐号";
                break;
            default:
                break;
        }
    }


}

-(void)addAddressBtnClick{
    NSLog(@"you click addAddress button...");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在发送";
    
    EMError *error = [[EMClient sharedClient].contactManager addContact:self.userInfo[@"userName"] message:@"我想添加你为好友"];
    if (!error) {
        NSLog(@"添加好友成功");
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        
        //显示一个成功的提示
        MBProgressHUD *successHud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
        successHud.labelText = @"发送成功";
        successHud.mode = MBProgressHUDModeCustomView;
        successHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
        successHud.removeFromSuperViewOnHide = YES;
        [successHud hide:true afterDelay:1.5f];
    }
    else{
        NSLog(@"add contact fail: %@", error.errorDescription);
        //先移除原来的HUD
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:true afterDelay:0];
        
        MBProgressHUD *failHud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
        failHud.labelText = @"发送失败";
        failHud.mode = MBProgressHUDModeCustomView;
        failHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
        failHud.removeFromSuperViewOnHide = YES;
        [failHud hide:true afterDelay:1.5];
    }
}

@end
