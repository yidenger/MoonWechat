//
//  Person.m
//  MoonWeChat
//
//  Created by seth on 16/3/24.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "Person.h"
#import <UIKit/UIKit.h>

@implementation Person

-(instancetype)init{
    self = [super init];
    if (self) {
        if (!_avatar) {
            _avatar = @"avatar";
        }
        if (!_nickName) {
            _nickName = @"慕微澜";
        }
        if (!_weID) {
            _weID = @"334466";
        }
    }
    return self;
}


-(NSString *)avatar{
    if (!_avatar) {
        return @"avatar";
    }
    return _avatar;
}

-(NSString *)nickName{
    if (!_nickName) {
        return @"慕微澜";
    }
    return _nickName;
}

-(NSString *)weID{
    if (!_weID) {
        return @"28999299";
    }
    return _weID;
}


@end
