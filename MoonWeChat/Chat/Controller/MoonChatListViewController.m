//
//  MoonChatListViewController.m
//  MoonWeChat
//
//  Created by seth on 16/5/2.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonChatListViewController.h"

@interface MoonChatListViewController ()<EaseConversationListViewControllerDataSource, EaseConversationListViewControllerDelegate>

@end

@implementation MoonChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController modelForConversation:(EMConversation *)conversation{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];

    model.title = [conversation.ext objectForKey:@"subject"];
    model.avatarImage = [UIImage imageNamed:@"avatar"];
   
    return model;
}

-(void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController didSelectConversationModel:(id<IConversationModel>)conversationModel{

    NSLog(@"you click conversation list view controller...");
}

@end
