//
//  MoonChatViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/23.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonChatViewController.h"
#import "Person.h"
#import "ChatViewController.h"

@interface MoonChatViewController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak)UITableView *tableView;

@property(nonatomic, copy)NSMutableArray *dataArr;

//会话列表
@property(nonatomic, copy)NSMutableArray *conversationArr;



@end
@implementation MoonChatViewController

-(void)viewWillAppear:(BOOL)animated{

    [self preData];

}

-(void)viewDidLoad{

    [super viewDidLoad];
    
    [self createTableView];
    
    [self getConversations];
    

}




-(void)preData{

    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i ++) {
            Person *people = [[Person alloc]init];
            [_dataArr addObject:people];
        }
    
    }
}

//创建表
-(void)createTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    self.tableView = tableView;

}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"chatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    return cell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    //当前cell的信息
//    Person *person = self.dataArr[indexPath.row];
    
    [cell.imageView setImage:[UIImage imageNamed:@"avatar"]];
    
//    cell.textLabel.text = person.nickName;
    EMConversation *conversation = self.conversationArr[indexPath.row];
    cell.textLabel.text = @"麻花藤";
//    cell.textLabel.text = conversation.latestMessage.from;
    UIImage *icon = cell.imageView.image;
    //修改icon尺寸
    CGSize itemSize = CGSizeMake(WGiveWidth(36), WGiveHeight(36));
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.detailTextLabel.text = @"最新消息";
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return WGiveHeight(10);
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return WGiveHeight(55);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EMConversation *conversation = self.conversationArr[indexPath.row];
    EaseMessageViewController *chatVC = [[EaseMessageViewController alloc]initWithConversationChatter:conversation.latestMessage.from conversationType:EMConversationTypeGroupChat];
    chatVC.title = conversation.latestMessage.from;
    chatVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

//获取会话列表
-(void)getConversations{
    NSArray *conversations = [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    [self.conversationArr addObjectsFromArray:conversations];
    [self.tableView reloadData];
    

}




@end
