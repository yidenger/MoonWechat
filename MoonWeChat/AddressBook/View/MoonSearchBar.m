//
//  MoonSearchBar.m
//  MoonWeChat
//
//  Created by seth on 16/4/18.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonSearchBar.h"

@implementation MoonSearchBar

//使用代码创建控件的时候,使用init的时候调用此方法
-(instancetype)initWithFrame:(CGRect)frame{
//由于是重写方法，记得一定得先调用父类初始化方法
    if (self = [super initWithFrame:frame]) {
        //设置内容垂直居中
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.font = [UIFont systemFontOfSize:13];
        
        //添加图标放大镜
        UIImageView *searchBarIconView = [[UIImageView alloc]init];
        searchBarIconView.image = [UIImage imageNamed:@"add_friend_searchicon~iphone"];
        
        //调整“放大镜”两边间距, view显示为正方形
        CGRect searchFrame = searchBarIconView.frame;
        searchFrame.size.width = searchBarIconView.image.size.width + 10;
        searchFrame.size.height = searchFrame.size.width;
        
        searchBarIconView.frame = searchFrame;
        
        //设置“放大镜”在imageView中居中
        [searchBarIconView setContentMode: UIViewContentModeCenter];
        
        //设置textField的左部控件
        self.leftView = searchBarIconView;
        [self setLeftViewMode:UITextFieldViewModeAlways];
        
        //显示清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }

    return self;

}

@end
