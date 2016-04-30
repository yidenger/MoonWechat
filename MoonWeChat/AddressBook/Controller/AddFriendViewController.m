//
//  AddFriendViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/19.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "AddFriendViewController.h"
#import "MoonSearchBar.h"
#import "SearchFriendViewController.h"

@interface AddFriendViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, weak)UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArr;
@property(nonatomic, strong)NSArray *imgArr;
@property(nonatomic, weak)MoonSearchBar *searchBar;
@property(nonatomic, strong)NSArray *descriptionArr;

@end

@implementation AddFriendViewController

-(void)viewWillAppear:(BOOL)animated{
    [self preData];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    MoonSearchBar *searchBar = [[MoonSearchBar alloc]init];
    searchBar.frame = CGRectMake(0, 64 + 16, 320, 47);
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"微信号/手机号";
    self.searchBar = searchBar;
    searchBar.delegate = self;
    [searchBar addTarget:self action:@selector(searchBarClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(94, CGRectGetMaxY(searchBar.frame) + 7, 98, 20)];
    codeLabel.text = @"我的二维码:";
    UIImage *codeImg = [UIImage imageNamed:@"add_friend_myQR"];
    UIImageView *codeImgview = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame) + 16, CGRectGetMidY(codeLabel.frame), codeImg.size.width, codeImg.size.height)];
    CGPoint codeLabelCenter= codeLabel.center;
    CGPoint codeImgviewCenter = codeImgview.center;
    codeImgviewCenter.y = codeLabelCenter.y;
    codeImgview.center = codeImgviewCenter;
    codeImgview.image = codeImg;
    [self.view addSubview:codeLabel];
    [self.view addSubview:codeImgview];
    
    //创建表格
    [self createTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + 61, 320, 300) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.tableView = tableView;
    [self.view addSubview: tableView];

}

-(void)preData{

    _dataArr = @[@"雷达加朋友", @"面对面建群", @"扫一扫", @"手机联系人", @"公众号"];
    _imgArr = @[@"add_friend_reda", @"add_friend_addgroup", @"add_friend_scanqr", @"add_friend_contacts", @"add_friend_offical"];
    _descriptionArr = @[@"添加身边的朋友", @"与身边的朋友进入同一个群聊", @"扫描二维码图片", @"添加通讯录中的朋友", @" 获取更多资讯和服务"];

}

#pragma mark - tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    const NSString *identifier = @"addFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];

    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.text = self.descriptionArr[indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.0f;
}

#pragma mark UITextFieldDelegate

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"textField did begin editing...");
//    
//}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    SearchFriendViewController *searchFriendVC = [[SearchFriendViewController alloc]init];
    //    [self presentViewController:searchFriendVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:searchFriendVC animated:YES];
//    searchFriendVC.navigationController.navigationBarHidden = YES;
    return NO;

}

-(void)searchBarClick{
    
    NSLog(@"you click searchBar textField ...");

}

@end
