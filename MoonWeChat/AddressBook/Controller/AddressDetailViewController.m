//
//  AddressDetailViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/27.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "AddressDetailViewController.h"
#import "MoonChatViewController.h"
#import "ChatViewController.h"


@interface AddressDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)UITableView *tableview;

@end

@implementation AddressDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableview];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    NSLog(@"addressDetailViewController will disappear...");
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableview {
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate = self;
    self.tableview = tableview;
    tableview.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number = 0;
    switch (section) {
        case 0:
            number = 1;
            break;
        case 1:
            number = 1;
            break;
        case 2:
            number = 3;
            break;
        case 3:
            number = 1;
            break;
        case 4:
            number = 1;
            break;
        default:
            number = 1;
            break;
    }
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        [cell.imageView setImage:[UIImage imageNamed:@"avatar"]];
        cell.textLabel.text = self.userInfo[@"nickName"];
        cell.detailTextLabel.text = @"个性签名";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.section == 1) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = @"设置备注和标签";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (indexPath.section == 2) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        NSString *content;
        switch (indexPath.row) {
            case 0:
                content = @"地区";
                break;
            case 1:
                content = @"个人相册";
                break;
            case 2:
                content = @"更多";
                break;
            default:
                content = nil;
                break;
        }
        cell.textLabel.text = content;
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"奥地利 维也纳";
        }
        
    }
    
    if (indexPath.section == 3) {
        cell = [[UITableViewCell alloc]init];
        UIButton *sendMsgBtn = [[UIButton alloc]initWithFrame:CGRectMake(21, 0, 280, 47)];
        [sendMsgBtn setTitle:@"发消息" forState:UIControlStateNormal];
        sendMsgBtn.backgroundColor = [UIColor colorWithRed:26/255.0 green:173/255.0 blue:25/255.0 alpha:1];
        [sendMsgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendMsgBtn.layer.cornerRadius = 3.0;
        [sendMsgBtn addTarget:self action:@selector(sendMsgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:sendMsgBtn];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.section == 4) {
        cell = [[UITableViewCell alloc]init];
        UIButton *videoChatBtn = [[UIButton alloc]initWithFrame:CGRectMake(21, 0, 280, 47)];
        [videoChatBtn setTitle:@"视频聊天" forState:UIControlStateNormal];
        videoChatBtn.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        [videoChatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        videoChatBtn.layer.cornerRadius = 3.0;
        [videoChatBtn addTarget:self action:@selector(videoChatBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:videoChatBtn];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0.0f;
    switch (indexPath.section) {
        case 0:
            height = 87.0f;
            break;
        case 1:
        case 2:
            height = 44.0f;
            break;
        case 3:
        case 4:
            height = 47.0f;
            break;
        default:
            height = 0.0f;
            break;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        height = 87.0f;
    }
    return height;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 18.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark - Click Event
-(void)sendMsgBtnClick{
    NSLog(@"you click send msg button...");
    NSString *title = self.userInfo[@"userName"];
//    EaseMessageViewController *chatVC = [[EaseMessageViewController alloc]initWithConversationChatter:title conversationType:EMConversationTypeChat];
    
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:title conversationType:EMConversationTypeChat];
    
    chatVC.title = self.userInfo[@"nickName"];
    chatVC.hidesBottomBarWhenPushed = YES;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    [backItem setTitle:@"微信"];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.action = @selector(backToChatVC);
    backItem.target = self;
    
    [self.navigationController pushViewController:chatVC animated:YES];
    

}

-(void)videoChatBtnClick{
    NSLog(@"you click vieo chat button...");
}

-(void)backToChatVC{

    MoonChatViewController *chatVC = [[MoonChatViewController alloc]init];
    [self presentViewController:chatVC animated:YES completion:nil];

}

@end
