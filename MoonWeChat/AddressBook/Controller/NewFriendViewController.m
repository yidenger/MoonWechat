//
//  NewFriendViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/18.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "NewFriendViewController.h"
#import "MoonSearchBar.h"
#import "AddFriendViewController.h"
#import "MBProgressHUD.h"


@interface NewFriendViewController ()<UITextFieldDelegate, EMContactManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)MoonSearchBar *searchBar;

@property(nonatomic, weak)UITableView *tableview;

@property(nonatomic, strong)NSMutableArray *friendAddArr;

@end

@implementation NewFriendViewController

-(void)viewWillAppear:(BOOL)animated{
//    [self.tabBarController setHidesBottomBarWhenPushed:YES];
//    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加朋友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendBtnClick)];
    
//    MoonSearchBar *searchBar = [[MoonSearchBar alloc]initWithFrame:CGRectMake(0, 8, 320, 40)];
    MoonSearchBar *searchBar = [[MoonSearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 64 + 4, 320, 40);
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"微信号/手机号";
    searchBar.delegate = self;
    self.searchBar = searchBar;
    
    if (!_friendAddArr) {
        _friendAddArr = [NSMutableArray array];
    }
    
    //监听加好友请求
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [self createTableview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加朋友按钮点击事件
-(void)addFriendBtnClick{

    NSLog(@"you click add friend button ...");
    AddFriendViewController *addVC = [[AddFriendViewController alloc]init];
    addVC.title = @"添加朋友";
    [self.navigationController pushViewController:addVC animated:YES];

}

//监听好友请求回调
/**
 *  用户A发送添加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername 用户名
 *  @param aMessage  附属信息
 */
-(void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage{

    NSLog(@"did receive from user: %@ with message: %@", aUsername, aMessage);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:aUsername forKey:@"userName"];
    [dict setObject:aMessage forKey:@"message"];
    [dict setObject:@"1" forKey:@"flagAccept"];
    
    [self.friendAddArr addObject:dict];
    
    [self.tableview reloadData];
    
}

/**
 *  创建表格
 */
-(void)createTableview{
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), 320, 568) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate = self;
    self.tableview = tableview;
    [self.view addSubview:tableview];

}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.friendAddArr.count;
            break;
        default:
            return 1;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        if (indexPath.section == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            UIImage *image = [UIImage imageNamed:@"NewFriend_Contacts_icon~iphone"];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(0, 14, image.size.width + 4, image.size.height);
            imageView.image = image;
            CGPoint imageViewCenter = imageView.center;
            imageViewCenter.x = 160;
            imageView.center = imageViewCenter;
            [cell.contentView addSubview:imageView];
            
            NSString *content = @"添加手机联系人";
            UILabel *phoneLabel = [[UILabel alloc]init];
            phoneLabel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, 100, 17);
            phoneLabel.textAlignment = NSTextAlignmentCenter;
            phoneLabel.adjustsFontSizeToFitWidth = YES;
            CGPoint phoneLabelCenter = phoneLabel.center;
            phoneLabelCenter.x = 160;
            phoneLabel.center = phoneLabelCenter;
            phoneLabel.text = content;
            [phoneLabel setTextColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1]];
            [cell.contentView addSubview:phoneLabel];
            NSLog(@"phoneLabel: %@", phoneLabel);
            
            return cell;
        }
        else{
            static NSString *identifier = @"newFriendAddCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (nil == cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
            cell.imageView.image = [UIImage imageNamed:@"avatar"];
            cell.textLabel.text = self.friendAddArr[indexPath.row][@"userName"];
            cell.detailTextLabel.text = self.friendAddArr[indexPath.row][@"message"];
    
            UIButton *cellBtn = [[UIButton alloc]init];
            NSString *cellBtnTitle;
            if ([self.friendAddArr[indexPath.row][@"flagAccept"] integerValue]) {
                cellBtnTitle = @"接受";
                cellBtn.backgroundColor = [UIColor colorWithRed: 54/255.0 green:177/255.0 blue:0/255.0 alpha:1];
                [cellBtn setTitle:cellBtnTitle forState:UIControlStateNormal];
                cellBtn.frame = CGRectMake(0, 0, 54, 24);
                cellBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                cellBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                cellBtn.layer.cornerRadius = 3.0;
                cell.accessoryView = cellBtn;
                cellBtn.tag = 100 + indexPath.row;
                [cellBtn addTarget:self action:@selector(acceptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                UILabel *cellAddLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 54, 24)];
                cellAddLabel.text = @"已添加";
                cellAddLabel.textAlignment = NSTextAlignmentCenter;
                cellAddLabel.adjustsFontSizeToFitWidth = YES;
                cellAddLabel.font = [UIFont systemFontOfSize:14];
                [cellAddLabel setTextColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1]];
                cell.accessoryView = cellAddLabel;
            }
            
            return cell;
        }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 80.0f;
    }
    else{
        return 60.0f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    else{
        return 21;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark - accept button click
-(void)acceptBtnClick:(UIButton *)btn{

    NSLog(@"you click accept button, tag: %ld", btn.tag);
    NSInteger index = btn.tag - 100;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在发送";
    //同意好友的申请
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.friendAddArr[index][@"userName"]];
    if (!error) {
        NSLog(@"发送同意成功");
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        
        [self.friendAddArr[index] setObject:@"0" forKey:@"flagAccept"];
        [self.tableview reloadData];
        
        MBProgressHUD *successHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        successHud.labelText = @"发送成功";
        successHud.mode = MBProgressHUDModeCustomView;
        successHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
        successHud.removeFromSuperViewOnHide = YES;
        [successHud hide:YES afterDelay:1.5f];
        
    }
    else{
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        
        MBProgressHUD *failHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        failHud.labelText = @"发送失败";
        failHud.mode = MBProgressHUDModeCustomView;
        failHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
        failHud.removeFromSuperViewOnHide = YES;
        [failHud hide:YES afterDelay:1.5f];
    
    }

}







@end














