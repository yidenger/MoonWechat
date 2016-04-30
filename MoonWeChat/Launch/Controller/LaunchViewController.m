//
//  LaunchViewController.m
//  MoonWeChat
//
//  Created by seth on 16/3/30.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "LaunchViewController.h"
#import "LaunchView.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage-700"]];
    [self setButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self.view addSubview:loginBtn];
    [self.view addSubview:registerBtn];
    
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn addTarget:self action:@selector(clickRegisterBtn) forControlEvents:UIControlEventTouchUpInside
     ];
    
}


-(void)clickLoginBtn{
    NSLog(@"you click login button...");
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    
    //设置动画
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    
//    animation.type = @"pageCurl";
    
    animation.type = kCATransitionPush;
    
    animation.subtype = kCATransitionFromTop;
    
//    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    [self presentViewController:loginVC animated:YES completion:nil];
//    [self presentModalViewController:loginVC animated:YES];
    
    
}

-(void)clickRegisterBtn{

    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    NSLog(@"you click register button...");
    [self presentViewController:registerVC animated:YES completion:nil];

}

@end
