//
//  PersonalViewController.m
//  MoonWeChat
//
//  Created by seth on 16/5/28.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "PersonalViewController.h"
#import "Person.h"



@interface PersonalViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong)NSArray *dataArr;
@property(nonatomic, weak)UITableView *tableview;
@property(nonatomic, strong)Person *personInfo;
@property(nonatomic, strong)NSData *imageData;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self preData];
    [self createTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)preData{
    _dataArr = @[
              @[@"头像", @"名字", @"微信号", @"我的二维码", @"我的地址"],
              @[@"性别", @"地区", @"个性签名"]
            ];
    _personInfo = [[Person alloc]init];
    _imageData = nil;
}

-(void)createTableview{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStyleGrouped];
    
    tableview.dataSource = self;
    tableview.delegate = self;
    self.tableview = tableview;
    [self.view addSubview:tableview];
    
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"personalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(220, 12, cell.frame.size.height - 2*12, cell.frame.size.height - 2*12)];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        UIImage *personImage = [UIImage imageNamed:self.personInfo.avatar];
        if (self.imageData) {
            personImage = [UIImage imageWithData:self.imageData];
        }
        imgView.image = personImage;
        [cell.contentView addSubview:imgView];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.detailTextLabel.text = self.personInfo.nickName;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.detailTextLabel.text = self.personInfo.weID;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        
    }
    if (indexPath.section == 0 && indexPath.row ==4) {
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"男";
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"广东 深圳";
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"明月几时有啊";
        }
    }
}

//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        return WGiveHeight(87);
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"you click the cell...");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self openCamera];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"来自手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self openAlbum];
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"保存图片");
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];

}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //取得原图
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image,0.75);
    self.imageData = imageData;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.tableview reloadData];
    }];
    
}


/**
 *  打开相机
 */
-(void)openCamera{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

/**
 *  打开相册
 */
- (void)openAlbum{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}








@end
