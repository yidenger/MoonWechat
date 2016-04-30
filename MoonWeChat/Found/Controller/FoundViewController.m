//
//  FoundViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/23.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "FoundViewController.h"

@interface FoundViewController()<UITableViewDelegate, UITableViewDataSource>

//名字数组
@property(nonatomic, copy)NSArray *dataArr;

//图片数组
@property(nonatomic, copy)NSArray *imgArr;

@property(nonatomic, weak)UITableView *tableView;

@end

@implementation FoundViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self preData];
    
    [self createTableView];

}

//准备数据
-(void)preData{

    _dataArr = @[@[@"朋友圈"],
                 @[@"扫一扫", @"摇一摇"],
                 @[@"附近人", @"漂流瓶"],
                 @[@"购物", @"游戏"]
                 ];
    
    _imgArr = @[@[@"friend"],
                @[@"sao", @"shake"],
                @[@"nearBy", @"bottle"],
                @[@"shopping", @"game"]
                ];
}

//创建tableView
-(void)createTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    //调整下分隔线位置
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView = tableView;
    [self.view addSubview:tableView];

}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *rowArr = self.dataArr[section];
    return rowArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"foundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //右侧小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return cell;
    
}

//养成习惯在willDisplayCell中处理数据
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
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



















@end
