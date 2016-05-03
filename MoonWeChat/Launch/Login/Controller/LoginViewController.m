//
//  LoginViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/31.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "TabBarViewController.h"
#import "LaunchViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic, weak)UITextField *phoneNumberTF;

@property(nonatomic, weak)UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setSubView];
    
    self.phoneNumberTF.delegate = self;
    self.passwordTF.delegate = self;
    
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//界面布局
-(void)setSubView{
    
    UIButton *cancleBtn = [[UIButton alloc]init];
    [cancleBtn setTitleColor:[UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.frame = CGRectMake(12, 36, 50, 40);
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview: cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"使用手机号登录";
    titleLabel.frame = CGRectMake(90, 112, 142, 25);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview: titleLabel];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text = @"国家/地区";
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.frame = CGRectMake(12, 170, 74, 18);
    addressLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:addressLabel];
    
    UILabel *nationLabel = [[UILabel alloc]init];
    nationLabel.textAlignment = NSTextAlignmentCenter;
    nationLabel.text = @"中国";
    nationLabel.textColor = [UIColor blackColor];
    nationLabel.font = [UIFont systemFontOfSize:15];
    nationLabel.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame) + 22, CGRectGetMinY(addressLabel.frame), 34, 18);
    [self.view addSubview: nationLabel];
    
    //添加直线
    UIView *lineFirst = [[UIView alloc]initWithFrame:CGRectMake(addressLabel.frame.origin.x, CGRectGetMaxY(addressLabel.frame) + 11, 318, 1)];
    lineFirst.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:lineFirst];
    
    UITextField *prePhoneTF = [[UITextField alloc]init];
    prePhoneTF.frame = CGRectMake(addressLabel.frame.origin.x, CGRectGetMaxY(addressLabel.frame) + 12, 74, 46);
    prePhoneTF.text = @"+86";
    prePhoneTF.textColor = [UIColor blackColor];
    prePhoneTF.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:prePhoneTF];
    
    //添加竖线
    UIView *lineSecond = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prePhoneTF.frame), prePhoneTF.frame.origin.y, 1, prePhoneTF.frame.size.height)];
    lineSecond.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:lineSecond];
    
    //手机号输入框
    UITextField *phoneNumberTF = [[UITextField alloc]init];
    phoneNumberTF.textAlignment = NSTextAlignmentLeft;
    phoneNumberTF.placeholder = @"请填写手机号码";
    phoneNumberTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
//    phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTF.clearButtonMode = UITextFieldViewModeAlways;
    phoneNumberTF.frame = CGRectMake(CGRectGetMaxX(prePhoneTF.frame), CGRectGetMinY(prePhoneTF.frame), 238, 46);
    [self.view addSubview:phoneNumberTF];
    self.phoneNumberTF = phoneNumberTF;
    
    UILabel *passwordLabel = [[UILabel alloc]init];
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.frame = CGRectMake(CGRectGetMinX(prePhoneTF.frame), CGRectGetMaxY(prePhoneTF.frame), prePhoneTF.frame.size.width, prePhoneTF.frame.size.height);
    [self.view addSubview: passwordLabel];
    
    //密码输入框
    UITextField *passwordTF = [[UITextField alloc]init];
    passwordTF.textAlignment = NSTextAlignmentLeft;
    passwordTF.placeholder = @"请填写密码";
    passwordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    passwordTF.secureTextEntry = YES;
    passwordTF.clearButtonMode = UITextFieldViewModeAlways;
    passwordTF.frame = CGRectMake(CGRectGetMaxX(passwordLabel.frame), CGRectGetMinY(passwordLabel.frame), phoneNumberTF.frame.size.width, phoneNumberTF.frame.size.height);
    [self.view addSubview:passwordTF];
    self.passwordTF = passwordTF;
    
    //添加两条横线
    UIView *lineThird = [[UIView alloc]initWithFrame:CGRectMake(passwordLabel.frame.origin.x, CGRectGetMaxY(phoneNumberTF.frame) + 1, lineFirst.frame.size.width, 1)];
    UIView *lineFourth = [[UIView alloc]initWithFrame:CGRectMake(lineFirst.frame.origin.x, CGRectGetMaxY(passwordLabel.frame) + 1, lineFirst.frame.size.width, 1)];
    lineThird.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    lineFourth.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:lineThird];
    [self.view addSubview:lineFourth];
    
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(12, CGRectGetMaxY(passwordLabel.frame) + 30, 298, 40);
    loginBtn.backgroundColor = [UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 3.0;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //通过短信验证码登录
    UIButton *msgLoginBtn = [[UIButton alloc]init];
    msgLoginBtn.frame = CGRectMake(102, CGRectGetMaxY(loginBtn.frame) + 28, 140, 20);
    msgLoginBtn.center = CGPointMake(160, CGRectGetMaxY(loginBtn.frame) + 28 + 10);
    [msgLoginBtn setTitle:@"通过短信验证码登录" forState:UIControlStateNormal];
    msgLoginBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [msgLoginBtn setTitleColor:[UIColor colorWithRed:119/255.0 green:127/255.0 blue:148/255.0 alpha:1] forState:UIControlStateNormal];
    msgLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:msgLoginBtn];
    
    //登录遇到问题？
    UIButton *loginProblemBtn = [[UIButton alloc]init];
    loginProblemBtn.frame = CGRectMake(0, CGRectGetMaxY(loginBtn.frame) + 152, 160, 32);
    loginProblemBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginProblemBtn setTitle:@"登录遇到问题?" forState:UIControlStateNormal];
    [loginProblemBtn setTitleColor:[UIColor colorWithRed:119/255.0 green:127/255.0 blue:148/255.0 alpha:1] forState:UIControlStateNormal];
    loginProblemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginProblemBtn];
    
    //其他登录方式
    UIButton *loginOtherBtn = [[UIButton alloc]init];
    loginOtherBtn.frame = CGRectMake(CGRectGetMaxX(loginProblemBtn.frame), CGRectGetMaxY(loginBtn.frame) + 152, 160, 32);
    loginOtherBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginOtherBtn setTitle:@"其他方式登录" forState:UIControlStateNormal];
    [loginOtherBtn setTitleColor:[UIColor colorWithRed:119/255.0 green:127/255.0 blue:148/255.0 alpha:1] forState:UIControlStateNormal];
    loginOtherBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginOtherBtn];
    
    //添加竖线
    UIView *lineLogin = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loginProblemBtn.frame) - 0.5, CGRectGetMinY(loginProblemBtn.frame), 1, 32)];
    lineLogin.backgroundColor = [UIColor colorWithRed:119/255.0 green:127/255.0 blue:148/255.0 alpha:1];
    [self.view addSubview:lineLogin];
    
}

/**
 *  点击取消按钮
 */
-(void)cancleBtnClick{

    NSLog(@"cancle button click...");
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    LaunchViewController *launchVC = [[LaunchViewController alloc]init];
    [self presentViewController:launchVC animated:YES completion:nil];

}

/**
 *  点击登录按钮
 */
-(void)loginBtnClick{
    NSLog(@"login button click...");
    NSString *phoneNumber = self.phoneNumberTF.text;
    NSString *password = self.passwordTF.text;
    NSLog(@"phoneNumber: %@, password: %@", phoneNumber, password);
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    EMError *error = [[EMClient sharedClient]loginWithUsername:phoneNumber password:password];
    if (!error) {
        TabBarViewController *tabbarVC = [[TabBarViewController alloc]init];
                [self presentViewController:tabbarVC animated:YES completion:nil];
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        //存储用户信息到文件中
        [self saveUserInfoToFile:phoneNumber andPassword:password];
        [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    }
    else{
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:0];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"用户名或密码错误，请重新输入" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"登录失败, %@", error.errorDescription);
    }
}

//关闭键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"end edit...");
//    if (![self.phoneNumberTF isExclusiveTouch] && ![self.passwordTF isExclusiveTouch]) {
//        [self.phoneNumberTF resignFirstResponder];
//        
//        [self.passwordTF resignFirstResponder];
//    }
    
    //关闭键盘
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}

//点击Return按钮时收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"you click return button...");
    return [textField resignFirstResponder];

}

/**
 *  保存用户信息至文件
 *
 *  @param userName 用户名
 *  @param password 密码
 */
-(void)saveUserInfoToFile:(NSString *)userName andPassword:(NSString *)password{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:userName forKey:@"userName"];
    [dict setObject:password forKey:@"password"];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"userInfo.plist"];
    
    BOOL flag = [dict writeToFile:filePath atomically:YES];
    if (flag) {
        NSLog(@"userInfo.plist文件写入成功");
    }
    else{
        NSLog(@"userInfo.plist文件写入失败");
    }
    
}





@end
