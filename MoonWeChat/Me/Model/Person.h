//
//  Person.h
//  MoonWeChat
//
//  Created by seth on 16/3/24.
//  Copyright © 2016年 seth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic, copy)NSString *avatar; //用户头像

@property(nonatomic, copy)NSString *nickName; //用户昵称

@property(nonatomic, copy)NSString *weID; //微信号

@end
