//
//  PersonCell.m
//  MoonWeChat
//
//  Created by seth on 16/3/24.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "PersonCell.h"
#import "Person.h"

@interface PersonCell()

@property(nonatomic, weak)UIImageView *avatarView;//头像

@property(nonatomic, weak)UILabel *nameLabel;//用户密码

@property(nonatomic, weak)UILabel *weIDLabel;//微信号

@property(nonatomic, weak)UIImageView *wmImgView;//二维码

@end

@implementation PersonCell

-(void)setModel:(Person *)model{

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.avatarView.image = [UIImage imageNamed:model.avatar];
    self.nameLabel.text = model.nickName;
    self.weIDLabel.text = [NSString stringWithFormat:@"微信号: %@", model.weID];
    self.wmImgView.image = [UIImage imageNamed:@""];
    self.imageView.backgroundColor = [UIColor grayColor];
}

//懒加载
-(UIImageView *)avatarView{

    if (!_avatarView) {
        UIImageView *avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(12), WGiveHeight(12), self.frame.size.height - 2 *WGiveHeight(12), self.frame.size.height - 2 * WGiveHeight(12))];
        
        avatarView.clipsToBounds = YES;
        //加点圆角
        avatarView.layer.cornerRadius = 3;
        
        _avatarView = avatarView;
        [self addSubview:avatarView];
        
    }
    
    return _avatarView;
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height - 2 *WGiveHeight(12) + 2 *WGiveWidth(12), WGiveHeight(19), WGiveWidth(160), WGiveHeight(22))];
        nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel = nameLabel;
        [self addSubview:nameLabel];
    }
    return _nameLabel;
}


-(UILabel *)weIDLabel{

    if (!_weIDLabel) {
        UILabel *weIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height - 2 * WGiveHeight(12) + 2 *WGiveWidth(12), _nameLabel.frame.origin.y + _nameLabel.frame.size.height + WGiveHeight(5), WGiveWidth(160), WGiveHeight(20))];
        weIDLabel.font = [UIFont systemFontOfSize:12];
        _weIDLabel = weIDLabel;
        [self addSubview:weIDLabel];
    }
    return _weIDLabel;

}

-(UIImageView *)wmImgView{

    if (!_wmImgView) {
        UIImageView *wmImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 50, ((self.frame.size.height - (35/2.0))/2.0), 35/2.0, 35/2.0)];
        _wmImgView = wmImgView;
        [self addSubview:wmImgView];
    }
    return _wmImgView;


}











@end
