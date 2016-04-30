//
//  MoonSearchFriendBar.m
//  MoonWeChat
//
//  Created by seth on 16/4/19.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonSearchFriendBar.h"

@implementation MoonSearchFriendBar

//使用代码创建控件的时候,使用init的时候调用此方法
-(instancetype)initWithFrame:(CGRect)frame{
    //由于是重写方法，记得一定得先调用父类初始化方法
    if (self = [super initWithFrame:frame]) {
        //设置内容垂直居中
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.font = [UIFont systemFontOfSize:13];
        
        [self setTintColor:[UIColor blackColor]];
        self.textColor = [UIColor blackColor];
        
        //添加图标放大镜
        UIImageView *searchBarIconView = [[UIImageView alloc]init];
        searchBarIconView.image = [UIImage imageNamed:@"searchBar"];
        
        //调整“放大镜”两边间距, view显示为正方形
        CGRect searchFrame = searchBarIconView.frame;
        searchFrame.size.width = searchBarIconView.image.size.width;
        searchFrame.size.height = searchFrame.size.width;
        searchBarIconView.frame = searchFrame;
        
        //设置“放大镜”在imageView中居中
        [searchBarIconView setContentMode: UIViewContentModeCenter];
        
        //设置textField的左部控件
        self.leftView = searchBarIconView;
        [self setLeftViewMode:UITextFieldViewModeAlways];
        
        //显示清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //return类型
        self.returnKeyType = UIReturnKeySearch;
        
        //圆角
        self.layer.cornerRadius = 3.0;
        
    }
    
    return self;
    
}


@end
