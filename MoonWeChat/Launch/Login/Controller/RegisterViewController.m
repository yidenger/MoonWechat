//
//  RegisterViewController.m
//  MoonWeChat
//
//  Created by seth on 16/4/11.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property(nonatomic, weak)UITextField *passwordTF;
@property(nonatomic, weak)UITextField *userNameTF;
@property(nonatomic, weak)UITextField *passwordRepeatTF;
@property(nonatomic, weak)UITextField *nickNameTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setSubview];
    
    //监听键盘的通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//布局控件
-(void)setSubview{
    
    UIButton *cancleBtn = [[UIButton alloc]init];
    [cancleBtn setTitleColor:[UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.frame = CGRectMake(12, 36, 50, 40);
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview: cancleBtn];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请进行注册";
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
    prePhoneTF.text = @"用户名";
    prePhoneTF.textColor = [UIColor blackColor];
    prePhoneTF.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:prePhoneTF];
    
    //添加竖线
//    UIView *lineSecond = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(prePhoneTF.frame), prePhoneTF.frame.origin.y, 1, prePhoneTF.frame.size.height)];
//    lineSecond.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
//    [self.view addSubview:lineSecond];
    
    //用户名输入框
    UITextField *userNameTF = [[UITextField alloc]init];
    userNameTF.textAlignment = NSTextAlignmentLeft;
    userNameTF.placeholder = @"用户名只能包含英文和数字";
    [userNameTF setFont:[UIFont systemFontOfSize:13]];
    userNameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    userNameTF.leftViewMode = UITextFieldViewModeAlways;
//    userNameTF.keyboardType = UIKeyboardTypeNumberPad;
    userNameTF.clearButtonMode = UITextFieldViewModeAlways;
    userNameTF.frame = CGRectMake(CGRectGetMaxX(prePhoneTF.frame), CGRectGetMinY(prePhoneTF.frame), 238, 46);
    [self.view addSubview:userNameTF];
    self.userNameTF = userNameTF;
    
    //昵称label
    UILabel *nickNameLabel = [[UILabel alloc]init];
    nickNameLabel.text = @"昵称";
    nickNameLabel.textColor = [UIColor blackColor];
    nickNameLabel.textAlignment = NSTextAlignmentLeft;
    nickNameLabel.frame = CGRectMake(CGRectGetMinX(prePhoneTF.frame), CGRectGetMaxY(prePhoneTF.frame), prePhoneTF.frame.size.width, prePhoneTF.frame.size.height);
    [self.view addSubview:nickNameLabel];
    
    //昵称输入框
    UITextField *nickNameTF = [[UITextField alloc]init];
    nickNameTF.textAlignment = NSTextAlignmentLeft;
    nickNameTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    nickNameTF.leftViewMode = UITextFieldViewModeAlways;
    nickNameTF.clearButtonMode = UITextFieldViewModeAlways;
    nickNameTF.placeholder = @"昵称可包含中文";
    [nickNameTF setFont:[UIFont systemFontOfSize:13]];
    nickNameTF.frame = CGRectMake(CGRectGetMaxX(nickNameLabel.frame), CGRectGetMinY(nickNameLabel.frame), userNameTF.frame.size.width, prePhoneTF.frame.size.height);
    [self.view addSubview:nickNameTF];
    self.nickNameTF = nickNameTF;
    nickNameTF.delegate = self;
    
    //添加直线
    UIView *lineNickName = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(nickNameLabel.frame), CGRectGetMaxY(nickNameLabel.frame), 318, 1)];
    lineNickName.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:lineNickName];
    
    UILabel *passwordLabel = [[UILabel alloc]init];
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.frame = CGRectMake(CGRectGetMinX(prePhoneTF.frame), CGRectGetMaxY(nickNameLabel.frame), prePhoneTF.frame.size.width, prePhoneTF.frame.size.height);
    [self.view addSubview: passwordLabel];
    
    //密码输入框
    UITextField *passwordTF = [[UITextField alloc]init];
    passwordTF.textAlignment = NSTextAlignmentLeft;
    passwordTF.placeholder = @"请填写密码";
    [passwordTF setFont:[UIFont systemFontOfSize:13]];
    passwordTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    passwordTF.secureTextEntry = YES;
    passwordTF.clearButtonMode = UITextFieldViewModeAlways;
    passwordTF.frame = CGRectMake(CGRectGetMaxX(passwordLabel.frame), CGRectGetMinY(passwordLabel.frame), userNameTF.frame.size.width, userNameTF.frame.size.height);
    [self.view addSubview:passwordTF];
    self.passwordTF = passwordTF;
    passwordTF.delegate = self;
    
    //重复密码Label
    UILabel *passwordRepeatLabel = [[UILabel alloc]init];
    passwordRepeatLabel.text = @"重复密码";
    passwordRepeatLabel.textColor = [UIColor blackColor];
    passwordRepeatLabel.textAlignment = NSTextAlignmentLeft;
    passwordRepeatLabel.frame = CGRectMake(CGRectGetMinX(prePhoneTF.frame), CGRectGetMaxY(passwordLabel.frame), prePhoneTF.frame.size.width, prePhoneTF.frame.size.height);
    [self.view addSubview: passwordRepeatLabel];
    
    //重复密码输入框
    UITextField *passwordRepeatTF = [[UITextField alloc]init];
    passwordRepeatTF.textAlignment = NSTextAlignmentLeft;
    passwordRepeatTF.placeholder = @"请重复密码";
    [passwordRepeatTF setFont:[UIFont systemFontOfSize:13]];
    passwordRepeatTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    passwordRepeatTF.leftViewMode = UITextFieldViewModeAlways;
    passwordRepeatTF.secureTextEntry = YES;
    passwordRepeatTF.clearButtonMode = UITextFieldViewModeAlways;
    passwordRepeatTF.frame = CGRectMake(CGRectGetMaxX(passwordLabel.frame), CGRectGetMaxY(passwordLabel.frame), userNameTF.frame.size.width, userNameTF.frame.size.height);
    [self.view addSubview:passwordRepeatTF];
    self.passwordRepeatTF = passwordRepeatTF;
    passwordRepeatTF.delegate = self;
    
    //添加直线
    UIView *linePasswordRepeat = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(passwordLabel.frame), CGRectGetMaxY(passwordRepeatLabel.frame), 318, 1)];
    linePasswordRepeat.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:linePasswordRepeat];
    
    //添加两条横线
    UIView *lineThird = [[UIView alloc]initWithFrame:CGRectMake(passwordLabel.frame.origin.x, CGRectGetMaxY(userNameTF.frame) + 1, lineFirst.frame.size.width, 1)];
    UIView *lineFourth = [[UIView alloc]initWithFrame:CGRectMake(lineFirst.frame.origin.x, CGRectGetMaxY(passwordLabel.frame) + 1, lineFirst.frame.size.width, 1)];
    lineThird.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    lineFourth.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.view addSubview:lineThird];
    [self.view addSubview:lineFourth];
    
    
    
    //注册按钮
    UIButton *registerBtn = [[UIButton alloc]init];
    registerBtn.frame = CGRectMake(12, CGRectGetMaxY(passwordRepeatLabel.frame) + 30, 298, 40);
    registerBtn.backgroundColor = [UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = 3.0;
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];


}

/**
 *  点击取消按钮
 */
-(void)cancleBtnClick{
    
    NSLog(@"cancle button click...");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"you click return button...");
//    return [textField resignFirstResponder];
//    
//}

//点击注册按钮事件
-(void)registerBtnClick{

    NSLog(@"you click register button...");
    NSLog(@"userName: %@\n, nickName: %@\n, password: %@\n, passwordRepeat: %@", self.userNameTF.text, self.nickNameTF.text, self.passwordTF.text, self.passwordRepeatTF.text);
    if (self.userNameTF.text.length == 0 || self.nickNameTF.text.length == 0 || self.passwordTF.text.length == 0 || self.passwordRepeatTF.text.length == 0) {
        NSLog(@"null....");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"填写信息不完整，请补全" message:nil delegate:self cancelButtonTitle: @"确定" otherButtonTitles:nil];
        [alertView show];
    }
    else{
        NSLog(@"not null....");
        if (self.passwordTF.text != self.passwordRepeatTF.text) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"两次密码不一致，重填" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
        if (![self validateUserName:self.userNameTF.text]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"用户名格式不对, 请重填" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
        //注册
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url = [NSString stringWithFormat:@"%@/user/signup", SERVER_URL];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.userNameTF.text forKey:@"userName"];
        [dict setObject:self.nickNameTF.text forKey:@"nickName"];
        [dict setObject:self.passwordTF.text forKey:@"password"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
        hud.backgroundColor = [UIColor clearColor];
        
        [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary *response){
            NSLog(@"response: %@", response);
            NSLog(@"msg: %@", response[@"msg"]);
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
//            [alertView show];
//            [self performSelector:@selector(disMissAlertView:) withObject:alertView afterDelay:3];
            
            //先移除原来的HUD
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:true afterDelay:0];
            
            if ([response[@"status"] integerValue] != 200) {
                MBProgressHUD *unSuccessHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                unSuccessHud.labelText = response[@"msg"];
                unSuccessHud.mode = MBProgressHUDModeCustomView;
                unSuccessHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
                unSuccessHud.removeFromSuperViewOnHide = YES;
                [unSuccessHud hide:true afterDelay:2];
                return;
            }
            
            //显示一个成功的提示
            MBProgressHUD *successHud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            successHud.labelText = @"注册成功";
            successHud.mode = MBProgressHUDModeCustomView;
            successHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
            successHud.removeFromSuperViewOnHide = YES;
            [successHud hide:true afterDelay:2];
            
            successHud.completionBlock = ^(){
                //跳转登陆界面提示
                MBProgressHUD *jumpHud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
                jumpHud.labelText = @"正在跳转到登录界面...";
                jumpHud.removeFromSuperViewOnHide = YES;
                [jumpHud hide:true afterDelay:1.5f];
                jumpHud.completionBlock = ^{
                    //跳转到登陆界面
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    [self presentModalViewController:loginVC animated:YES];
                };
            };
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"error: %@", error);
            //先移除原来的HUD
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:true afterDelay:0];
            
            MBProgressHUD *failHud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            failHud.labelText = @"注册失败";
            failHud.mode = MBProgressHUDModeCustomView;
            failHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error"]];
            failHud.removeFromSuperViewOnHide = YES;
            [failHud hide:true afterDelay:2];
        }];
        
        
        
    
    }
    
    NSLog(@"hehe...");


}

//校验用户名
-(BOOL)validateUserName:(NSString *)userName{

    NSString *reg = @"[a-zA-Z0-9_-]*";
    NSPredicate *userNamePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [userNamePre evaluateWithObject:userName];

}

//关闭提示框
-(void)disMissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

//监听键盘弹出
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    
    //取出键盘当前的y坐标
    CGRect beginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //中间的差值
    CGFloat minus = endFrame.origin.y - beginFrame.origin.y;
    //根据差值改变控制器view的frame
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += minus;
    self.view.frame = viewFrame;
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationBeginsFromCurrentState:animationDuration];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat offset = textField.frame.origin.y - 216;
    if (offset > 0) {
        //上移
        CGRect rect = CGRectMake(0, -offset, width, height);
        self.view.frame = rect;
    }
    
    [UIView commitAnimations];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //处理键盘遮挡
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    return YES;
}





@end
