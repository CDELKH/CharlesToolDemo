//
//  PostRequestCell.m
//  CharlesDemo
//
//  Created by konghui on 2021/3/18.
//

#import "PostRequestCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CommUtls.h"

@interface PostRequestCell ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PostRequestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];

        [self addViews];
    }
    return self;
}

- (void)addViews{
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    backImageView.clipsToBounds = YES;
    [self.contentView addSubview:backImageView];
    [backImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    self.backImageView = backImageView;
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.5];
    [self.contentView addSubview:maskView];
    [maskView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(-10);
        make.height.equalTo(40);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-18);
        make.centerX.equalTo(0);
    }];
    self.titleLabel = titleLabel;
}

- (void)setModelDic:(NSDictionary *)modelDic{
    _modelDic = modelDic;
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:modelDic[@"icon"]]];
    self.titleLabel.text = modelDic[@"title"];
}

@end
