//
//  LoginView.m
//  MoonWeChat
//
//  Created by seth on 16/3/30.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()

@property(nonatomic, weak)UIButton *cancleBtn;
@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UILabel *addressLabel;
@property(nonatomic, weak)UILabel *nationLabel;

@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    
    return self;
}

//界面布局
-(void)setSubView{

    UIButton *cancleBtn = [[UIButton alloc]init];
    [cancleBtn setTitleColor:[UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.frame = CGRectMake(12, 36, 50, 40);
    [self addSubview: cancleBtn];
    self.cancleBtn = cancleBtn;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"使用手机号登录";
    titleLabel.frame = CGRectMake(90, 112, 142, 25);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview: titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text = @"国家/地区";
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.frame = CGRectMake(12, 170, 68, 18);
    [self addSubview:addressLabel];
    self.addressLabel = addressLabel;
                         
    UILabel *nationLabel = [[UILabel alloc]init];
    nationLabel.textAlignment = NSTextAlignmentCenter;
    nationLabel.text = @"中国";
    nationLabel.textColor = [UIColor blackColor];
    nationLabel.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame) + 22, CGRectGetMinY(addressLabel.frame), 34, 18);
    [self addSubview: nationLabel];
    self.nationLabel = nationLabel;
    
    UITextField *prePhoneTF = [[UITextField alloc]init];
    prePhoneTF.frame = CGRectMake(addressLabel.frame.origin.x, CGRectGetMaxY(addressLabel.frame) + 12, 74, 46);
    prePhoneTF.text = @"+86";
    prePhoneTF.textColor = [UIColor blackColor];
    prePhoneTF.textAlignment = NSTextAlignmentLeft;
    [self addSubview:prePhoneTF];
    
    UITextField *phoneNumberTF = [[UITextField alloc]init];
    phoneNumberTF.textAlignment = NSTextAlignmentLeft;
    phoneNumberTF.placeholder = @"请填写手机号码";
    phoneNumberTF.frame = CGRectMake(CGRectGetMaxX(prePhoneTF.frame), CGRectGetMinX(prePhoneTF.frame), 238, 46);
    [self addSubview:phoneNumberTF];
    
    UILabel *passwordLable = [[UILabel alloc]init];
    passwordLable.text = @"密码";
    passwordLable.textColor = [UIColor blackColor];
    passwordLable.textAlignment = NSTextAlignmentLeft;
    passwordLable.frame = CGRectMake(CGRectGetMinX(prePhoneTF.frame), CGRectGetMaxY(prePhoneTF.frame), prePhoneTF.frame.size.width, prePhoneTF.frame.size.height);
    [self addSubview: passwordLable];
    
    UITextField *passwordTF = [[UITextField alloc]init];
    passwordTF.textAlignment = NSTextAlignmentLeft;
    passwordTF.placeholder = @"请填写密码";
    passwordTF.frame = CGRectMake(CGRectGetMaxX(passwordLable.frame), CGRectGetMaxY(passwordLable.frame), phoneNumberTF.frame.size.width, phoneNumberTF.frame.size.height);
    [self addSubview:passwordTF];
    
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(12, CGRectGetMaxY(passwordLable.frame) + 30, 298, 40);
    loginBtn.backgroundColor = [UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 3.0;
    [self addSubview:loginBtn];
    
}

















@end
