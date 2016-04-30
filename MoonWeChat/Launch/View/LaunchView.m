//
//  LaunchView.m
//  MoonWeChat
//
//  Created by seth on 16/3/30.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "LaunchView.h"
#import "LoginViewController.h"

@implementation LaunchView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage-700"]];
        
        [self setButton];
    }
    return self;
}

-(void)setButton{

    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 505, 130, 40)];
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loginBtn.frame) + 28, 505, 130, 40)];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    loginBtn.layer.cornerRadius = 3.0;
    registerBtn.layer.cornerRadius = 3.0;
    
    
    loginBtn.backgroundColor = [UIColor whiteColor];
    registerBtn.backgroundColor = [UIColor colorWithRed:54/255.0 green:177/255.0 blue:0/255.0 alpha:1];
    
    [self addSubview:loginBtn];
    [self addSubview:registerBtn];
    
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];

}


-(void)clickLoginBtn{
    NSLog(@"you click login button...");
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    
}


@end
