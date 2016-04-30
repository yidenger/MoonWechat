//
//  SearchFriendViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/19.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "SearchFriendViewController.h"
#import "MoonSearchFriendBar.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "SearchFriendDetailViewController.h"
#import "AddFriendViewController.h"

@interface SearchFriendViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)MoonSearchFriendBar *searchBar;

@property(nonatomic, weak)UITableView *tableview;

@property(nonatomic, weak)UIView *backgroundView;

@property(nonatomic, weak)UIButton *searchBtn;

@property(nonatomic, weak)UILabel *searchLabel;

@property(nonatomic, strong)NSMutableArray *searchResult;



@end

@implementation SearchFriendViewController

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"searchFriendView will appear...");
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    [super viewWillAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"searchFriendViewController did disappear...");
    [super viewDidDisappear:YES];
    
}


- (void)viewDidLoad {
    NSLog(@"view did load...");
    [super viewDidLoad];

//    [self.searchBar removeFromSuperview];
//    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    MoonSearchFriendBar *searchBar = [[MoonSearchFriendBar alloc]init];
//    searchBar.frame = CGRectMake(9, 29, 258, 28);
    searchBar.frame = CGRectMake(0, 8, 258, 28);
//    [self.view addSubview:searchBar];
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [searchView addSubview:searchBar];
    self.navigationItem.titleView = searchView;
    
    searchBar.placeholder = @"微信号/手机号";
    self.searchBar = searchBar;
    searchBar.delegate = self;
    if(self.searchBar.text){
        searchBar.text = self.searchBar.text;
    }
    
    [searchBar addTarget: self action:@selector(searchBarInput) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchBar.frame), searchBar.frame.origin.y, 320 - CGRectGetMaxX(searchBar.frame), 15)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    CGPoint cancleBtnCenter = cancleBtn.center;
    cancleBtnCenter.y = searchBar.center.y;
    cancleBtn.center = cancleBtnCenter;
    [cancleBtn setTitleColor:[UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [searchView addSubview:cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *line = [[UIView alloc]init];
//    line.frame = CGRectMake(0, CGRectGetMaxY(searchBar.frame) + 9, 320, 1);
//    line.backgroundColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:213/255.0 alpha:1];
//    [self.view addSubview:line];
    
//    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), 320, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(line.frame)) style:UITableViewStylePlain];
//    tableview.delegate = self;
//    tableview.dataSource = self;
//    tableview.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
//    self.tableview = tableview;
//    [self.view addSubview:tableview];
//    tableview.backgroundColor = [UIColor whiteColor];
    
    
//    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), 320, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(line.frame))];
//    backgroundView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview: backgroundView];
//    self.backgroundView = backgroundView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancleBtnClick{

    NSLog(@"you click cancle button...");
//    AddFriendViewController *addVC = [[AddFriendViewController alloc]init];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToViewController:addVC animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField 
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//
//    NSLog(@"textField did begin editing...");
//    
//    
//}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"change input (%@)", self.searchBar.text);
////    [self.searchBtn setTitle:self.searchBar.text forState:UIControlStateNormal];
//    
//    return YES;
//}

-(void)searchBarInput{

    NSLog(@"searchbar input (%@)", self.searchBar.text);
    NSLog(@"length: %ld", self.searchBar.text.length);
    if (self.searchBar.text.length < 1) {
        self.searchBtn.hidden  = YES;
        return;
    }
    
    for (UIView *view in [self.searchBtn subviews]) {
        [view removeFromSuperview];
    }
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 320, 65)];
    [self.view addSubview:searchBtn];
    self.searchBtn = searchBtn;
    
    [searchBtn addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *searchIcon = [UIImage imageNamed:@"add_friend_search"];
    UIImageView *searchIconView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 0, searchIcon.size.width, searchIcon.size.height)];
    CGPoint searchIconViewCenter = searchIconView.center;
    searchIconViewCenter.y = searchBtn.frame.size.height / 2;
    searchIconView.center = searchIconViewCenter;
    searchIconView.image = searchIcon;
    [searchBtn addSubview: searchIconView];
    
    UILabel *searchLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(searchIconView.frame) + 12, 0, 246, 18)];
    CGPoint searchLabelCenter = searchLabel.center;
    searchLabelCenter.y = searchBtn.frame.size.height / 2;
    searchLabel.center = searchLabelCenter;
    [searchBtn addSubview:searchLabel];
    searchLabel.text = [NSString stringWithFormat:@"搜索: %@", self.searchBar.text];
    
    //给搜索text上色.
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc]initWithString:searchLabel.text];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:43/255.0 green:162/255.0 blue:69/255.0 alpha:1] range:NSMakeRange(4, searchLabel.text.length - 4)];
    searchLabel.attributedText = attriString;
    
    self.searchLabel = searchLabel;
    
    //给按钮底部添加一条横线
    UIView *lineBtn = [[UIView alloc]initWithFrame:CGRectMake(16, self.searchBtn.frame.size.height, 304, 1)];
    lineBtn.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1];
    [searchBtn addSubview:lineBtn];
    
    
}

//根据关键词搜索用户
-(void)searchFriend{

    NSLog(@"you click search button...");
    NSLog(@"search text: %@", self.searchBar.text);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userName"] = self.searchBar.text;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *url = [NSString stringWithFormat:@"%@/user/list/userName", SERVER_URL];
    
    _searchResult = [NSMutableArray array];
    
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj){
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        NSLog(@"%@", responseObj);
//        self.searchResult  [responseObj objectForKey:@"data"];
        [self.searchResult addObjectsFromArray:[responseObj objectForKey:@"data"]];
//        [self createTableView];
        
        if (self.searchResult.count >0) {
            SearchFriendDetailViewController *searchFriendDetailVC = [[SearchFriendDetailViewController alloc]init];
            searchFriendDetailVC.userInfo = [self.searchResult objectAtIndex:0];
            
            searchFriendDetailVC.title = @"详细资料";
            
            NSLog(@"(%@)", self.navigationController);
            if (nil == self.navigationController) {
                
            }
//            searchFriendDetailVC.navigationController.navigationBarHidden = NO;
            
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"添加朋友" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            searchFriendDetailVC.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:searchFriendDetailVC animated:YES];
            
            
        }
        
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error){
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        NSLog(@"%@", [error localizedDescription]);
    }];

}

//创建搜索结果表格
-(void)createTableView{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.backgroundView.frame.size.height) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.backgroundView addSubview:tableview];
    self.tableview = tableview;

}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.searchResult.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"searchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.imageView.image = [UIImage imageNamed:@"avatar"];
    cell.textLabel.text = self.searchResult[indexPath.row][@"nickName"];
    cell.detailTextLabel.text = @"此人太懒，还未填写个性签名";

}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
@end
