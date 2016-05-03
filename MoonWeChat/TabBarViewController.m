//
//  TabBarViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/23.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "TabBarViewController.h"
#import "AddressBookViewController.h"
#import "MoonChatViewController.h"
#import "FoundViewController.h"
#import "MeViewController.h"
#import "MoonChatListViewController.h"
#import "ConversationListController.h"

@implementation TabBarViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    
//    MoonChatViewController *chatVC = [[MoonChatViewController alloc]init];
//    MoonChatListViewController *chatVC = [[MoonChatListViewController alloc]init];
//    EaseConversationListViewController *chatVC = [[EaseConversationListViewController alloc]init];
    
    ConversationListController *chatVC = [[ConversationListController alloc]init];
    
    chatVC.title = @"微信";
    [self addChildViewController:chatVC andImage:[UIImage imageNamed:@"tabbar_mainframe~iphone"] andSelectedImage:[UIImage imageNamed:@"tabbar_mainframeHL~iphone"]];
    
    
    AddressBookViewController *addressBookVC = [[AddressBookViewController alloc]init];
    addressBookVC.title = @"通讯录";
    [self addChildViewController:addressBookVC andImage:[UIImage imageNamed:@"tabbar_contacts~iphone"] andSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL~iphone"]];
    
    FoundViewController *foundVC = [[FoundViewController alloc]init];
    foundVC.title = @"发现";
    [self addChildViewController:foundVC andImage:[UIImage imageNamed:@"tabbar_discover~iphone"] andSelectedImage:[UIImage imageNamed:@"tabbar_discoverHL~iphone"]];
    
    MeViewController *meVC = [[MeViewController alloc]init];
    meVC.title = @"我";
    [self addChildViewController:meVC andImage:[UIImage imageNamed:@"tabbar_me~iphone"] andSelectedImage:[UIImage imageNamed:@"tabbar_meHL~iphone"]];
    
    
    self.tabBar.tintColor = [UIColor colorWithRed:9/255.0 green:187/255.0 blue:7/255.0 alpha:1];
    
}


/**
 *  用navigationController包装一个控制器
 *
 *  @param VC            控制器
 *  @param image         普通状态图片
 *  @param selectedImage 选中状态图片
 *
 *  @return
 */
-(UINavigationController *)giveMeNavWithVC:(UIViewController *)VC andImage:(UIImage *)image andSelectImage:(UIImage *)selectedImage{

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:VC.tabBarItem.title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    return nav;

}

/**
 *  添加子控制器
 *
 *  @param childController 控制器
 *  @param image           普通状态图片
 *  @param selectedImage   选中状态图片
 */
-(void)addChildViewController:(UIViewController *)childController andImage:(UIImage *)image andSelectedImage:(UIImage *)selectedImage{
    UINavigationController *nav = [self giveMeNavWithVC:childController andImage:image andSelectImage:selectedImage];
    [self addChildViewController:nav];
}

@end
