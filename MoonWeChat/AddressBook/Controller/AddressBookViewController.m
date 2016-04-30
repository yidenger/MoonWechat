//
//  AddressBookViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/23.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "AddressBookViewController.h"
#import "NSString+PinYin.h"
#import "Person.h"
#import "ChatViewController.h"
#import "MeViewController.h"
#import "EaseMessageViewController.h"
#import "NewFriendViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AddressDetailViewController.h"


@interface AddressBookViewController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak)UITableView *tableView;

@property(nonatomic, copy)NSMutableArray *dataArr;

@property(nonatomic, copy)NSArray *sectionArr;

@property(nonatomic, copy)NSMutableArray *friendArr;


@end

@implementation AddressBookViewController

-(void)viewWillAppear:(BOOL)animated{

//    [self preData];
    [self preDataSection];
    if (!_friendArr) {
        _friendArr = [NSMutableArray array];
    }
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createTableView];
    [self getFriendList];

}

//准备数据
-(void)preDataSection{

    _sectionArr = @[@{
                        @"name": @"新的朋友",
                        @"imgName": @"book_newFriend"
                        },
                    @{
                        @"name": @"群聊",
                        @"imgName": @"book_group"
                        },
                    @{
                        @"name": @"标签",
                        @"imgName": @"book_tag"
                        },
                    @{
                        @"name": @"公众号",
                        @"imgName": @"book_gong"
                        }
                    ];
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
}




//准备数据
-(void)preData{

    _sectionArr = @[@{
                        @"name": @"新的朋友",
                        @"imgName": @"book_newFriend"
                    },
                    @{
                        @"name": @"群聊",
                        @"imgName": @"book_group"
                    },
                    @{
                        @"name": @"标签",
                        @"imgName": @"book_tag"
                    },
                    @{
                        @"name": @"公众号",
                        @"imgName": @"book_gong"
                    }
                ];
    
    
    NSArray *nameList = @[
                         @{
                            @"nickName": @"马化腾",
                            @"userName": @"1",
                            @"imgName": @"avatar"
                         },
                         @{
                            @"nickName": @"马云",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                         },
                         @{
                            @"nickName": @"乔帮主",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                         },
                         @{
                            @"nickName": @"李彦宏",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                         },
                         @{
                            @"nickName": @"周鸿伟",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                         },
                         @{
                            @"nickName": @"周渝民",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                         },
                         @{
                            @"nickName": @"周芷若",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                          },
                         @{
                            @"nickName": @"刘强东",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                          },
                         @{
                            @"nickName":@"陈天桥",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                          },
                         @{
                            @"nickName": @"hehe",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                          },
                         @{
                            @"nickName": @"Ceshi",
                            @"userName": @"1",
                            @"imgName": @"avatar.jpg"
                          },
                         @{
                             @"nickName": @"Leshi",
                             @"userName": @"1",
                             @"imgName": @"avatar.jpg"
                          },
                         @{
                             @"nickName": @"liuyuxi",
                             @"userName": @"1",
                             @"imgName": @"avatar.jpg"
                          },
                         @{
                             @"nickName": @"88iuyuxi",
                             @"userName": @"1",
                             @"imgName": @"avatar.jpg"
                          },
                         @{
                             @"nickName": @"669",
                             @"userName": @"1",
                             @"imgName": @"avatar.jpg"
                          },
                         
                    ];
    
    
    NSMutableArray *nameArr = [NSMutableArray array];
    
    [nameArr addObjectsFromArray:nameList];
    
    for(char i = 'A'; i <= 'Z'; i++){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        //属于这个数组的nameArr
        NSMutableArray *currNameArr = [[NSMutableArray alloc]init];
        NSString *sectionName = [NSString stringWithFormat:@"%c", i];
        for (int j = 0; j < nameArr.count; j++) {
            NSDictionary *nameDict = nameArr[j];
            NSString *name = nameDict[@"nickName"];
            NSString *imgName = nameDict[@"imgName"];
            
            if ([[name getFirstLetter].uppercaseString isEqualToString:sectionName]) {
                NSDictionary *currDict = @{
                                            @"name": name,
                                            @"imgName": imgName
                                        };
                [currNameArr addObject:currDict];
                
            }
            
        }
        if (currNameArr.count > 0) {
            [dict setObject:currNameArr forKey:@"nameArr"];
            [dict setObject:sectionName forKey:@"sectionName"];
            [_dataArr addObject:dict];
        }
    
    }
    
    //不在26个字母内的，存放在#号索引
    NSMutableDictionary *dictOther = [[NSMutableDictionary alloc]init];
    //属于这个数组的nameArr
    NSMutableArray *currNameArrOther = [[NSMutableArray alloc]init];
    NSString *sectionNameOther = @"#";
    for (int j = 0; j < nameArr.count; j++) {
        NSDictionary *nameDict = nameArr[j];
        NSString *name = nameDict[@"nickName"];
        NSString *imgName = nameDict[@"imgName"];
        NSString *str = [name getFirstLetter];
        
        if ([[name getFirstLetter] isEqualToString:sectionNameOther]) {
            NSDictionary *currDict = @{
                                       @"name": name,
                                       @"imgName": imgName
                                       };
            [currNameArrOther addObject:currDict];
            
        }
        
    }
    if (currNameArrOther.count > 0) {
        [dictOther setObject:currNameArrOther forKey:@"nameArr"];
        [dictOther setObject:sectionNameOther forKey:@"sectionName"];
        [_dataArr addObject:dictOther];
    }
}

//创建表格
-(void)createTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //调整下分隔线的位置
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _tableView = tableView;
    
    [self.view addSubview:tableView];


}

#pragma mark - tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArr.count + 1;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return _sectionArr.count;
    }
    else{
        NSDictionary *dict = _dataArr[section - 1];
        NSArray *arr = dict[@"nameArr"];
        return arr.count;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"addressCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

//养成习惯在willDisplayCell中处理数据
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        NSDictionary *dict = _sectionArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed: dict[@"imgName"]];
        cell.textLabel.text = dict[@"name"];
        
    }
    else{
        NSDictionary *dict = _dataArr[indexPath.section - 1];
        NSArray *arr = dict[@"nameArr"];
        
        //当前cell的信息
//        NSDictionary *person = arr[indexPath.row];
//        Person *model = [[Person alloc]init];
//        model.nickName = person[@"name"];
//        model.avatar = person[@"imgName"];
//        [cell.imageView setImage:[UIImage imageNamed:model.avatar]];
//        
//        cell.textLabel.text = model.nickName;
        
        cell.textLabel.text = arr[indexPath.row][@"nickName"];
        [cell.imageView setImage:[UIImage imageNamed:@"avatar"]];
        UIImage *icon = cell.imageView.image;
        //修改icon尺寸
        CGSize itemSize = CGSizeMake(WGiveWidth(36), WGiveHeight(36));
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
}

//设置row高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return WGiveHeight(55);

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

    return WGiveHeight(0.01);


}

//设置头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section != 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WGiveWidth(30), WGiveHeight(20))];
        NSDictionary *dict = _dataArr[section - 1];
        label.text = [NSString stringWithFormat:@"  %@", dict[@"sectionName"]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:146/255.0 alpha:1];
        return label;
    }
    else{//搜索框

    
    
    
    
    }

    return nil;

}

//加索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    //索引背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //索引颜色
    tableView.sectionIndexColor = [UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    //加放大镜
    if (_dataArr.count > 0) {
        [arr addObject:UITableViewIndexSearch];
    }
    
    for(NSDictionary *dict in _dataArr){
        [arr addObject:dict[@"sectionName"]];
    }
    return arr;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {//新的朋友
        NSLog(@"push to newFriendVC...");
        NewFriendViewController *newFriendVC = [[NewFriendViewController alloc]init];
        newFriendVC.title = @"新的朋友";
        [newFriendVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:newFriendVC animated:YES];
    }

    if (indexPath.section > 0) {
        NSLog(@"push to chatVC...");
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        NSLog(@"section: %ld, row: %ld", indexPath.section, indexPath.row);
        
        NSDictionary *dict = self.dataArr[indexPath.section - 1][@"nameArr"][indexPath.row];
        NSString *title = dict[@"nickName"];
        
//        EaseMessageViewController *chatVC = [[EaseMessageViewController alloc]initWithConversationChatter:title conversationType:EMConversationTypeChat];
//        chatVC.title = title;
//        chatVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:chatVC animated:YES];
        
        AddressDetailViewController *addressDetailVC = [[AddressDetailViewController alloc]init];
        addressDetailVC.userInfo = dict;
        addressDetailVC.title = @"详细资料";
        addressDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressDetailVC animated:YES];
        
        
        
    }

}

/**
 *  获取好友列表
 */
-(void)getFriendList{
    NSLog(@"sandbox path: %@", NSHomeDirectory());
    NSDictionary *userInfo = [self getUserInfoFromFile];
    NSString *url = [NSString stringWithFormat:@"%@/user/friend/list", SERVER_URL];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject: userInfo[@"userName"] forKey:@"userName"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSLog(@"before...");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary *responseData){
        [_friendArr addObjectsFromArray:responseData[@"data"]];
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        NSLog(@"mid....");
        NSLog(@"friendArr: %@", self.friendArr);
        
        [self getContactFromFriendArr:self.friendArr];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        [hud hide:YES afterDelay:0];
        
        MBProgressHUD *failHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        failHud.labelText = @" 获取好友列表失败";
        failHud.mode = MBProgressHUDModeCustomView;
        failHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
        failHud.removeFromSuperViewOnHide = YES;
        [failHud hide:YES afterDelay:1.5f];
        
        
    }];
    
    NSLog(@"after...");


}

/**
 *  从文件中获取用户信息
 *
 *  @return 用户信息
 */
-(NSDictionary *)getUserInfoFromFile{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"userInfo.plist"];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    return userInfo;
}

-(void)getContactFromFriendArr: (NSArray *)nameList{

    NSMutableArray *nameArr = [NSMutableArray array];
    
    [nameArr addObjectsFromArray:nameList];
    
    _dataArr = [NSMutableArray array];
    
    for(char i = 'A'; i <= 'Z'; i++){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        //属于这个数组的nameArr
        NSMutableArray *currNameArr = [[NSMutableArray alloc]init];
        NSString *sectionName = [NSString stringWithFormat:@"%c", i];
        for (int j = 0; j < nameArr.count; j++) {
            NSDictionary *nameDict = nameArr[j];
            NSString *name = nameDict[@"nickName"];
            NSString *imgName = @"avatar.jpg";
            
            if ([[name getFirstLetter].uppercaseString isEqualToString:sectionName]) {
                NSDictionary *currDict = @{
                                           @"nickName": name,
                                           @"imgName": imgName,
                                           @"userName": nameDict[@"userName"]
                                           };
                [currNameArr addObject:currDict];
                
            }
            
        }
        if (currNameArr.count > 0) {
            [dict setObject:currNameArr forKey:@"nameArr"];
            [dict setObject:sectionName forKey:@"sectionName"];
            [_dataArr addObject:dict];
        }
        
    }
    
    //不在26个字母内的，存放在#号索引
    NSMutableDictionary *dictOther = [[NSMutableDictionary alloc]init];
    //属于这个数组的nameArr
    NSMutableArray *currNameArrOther = [[NSMutableArray alloc]init];
    NSString *sectionNameOther = @"#";
    for (int j = 0; j < nameArr.count; j++) {
        NSDictionary *nameDict = nameArr[j];
        NSString *name = nameDict[@"nickName"];
        NSString *imgName = @"avatar.jpg";
        NSString *str = [name getFirstLetter];
        
        if ([[name getFirstLetter] isEqualToString:sectionNameOther]) {
            NSDictionary *currDict = @{
                                       @"nickName": name,
                                       @"imgName": imgName,
                                       @"userName": nameDict[@"userName"]
                                       };
            [currNameArrOther addObject:currDict];
            
        }
        
    }
    if (currNameArrOther.count > 0) {
        [dictOther setObject:currNameArrOther forKey:@"nameArr"];
        [dictOther setObject:sectionNameOther forKey:@"sectionName"];
        [_dataArr addObject:dictOther];
    }

}










@end
