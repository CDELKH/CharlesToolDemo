//
//  GetRequestViewController.m
//  CharlesDemo
//
//  Created by konghui on 2021/3/17.
//

#import "GetRequestViewController.h"
#import <JSONKit-NoWarning/JSONKit.h>
#import "CommUtls.h"
#import "DLBaseMacro.h"

@interface GetRequestViewController ()

@property (nonatomic, strong) UILabel *requestDataLabel;

@end

@implementation GetRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViews];
    [self getData];
}

- (void)addViews{
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"显示一首诗";
    textLabel.textColor = [CommUtls colorWithHexString:@"#249ff6"];
    [self.view addSubview:textLabel];
    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-8 - NAVIGATIONBAR_HEIGHT / 2.);
    }];
    
    UILabel *requestDataLabel = [[UILabel alloc] init];
    requestDataLabel.text = @"";
    requestDataLabel.numberOfLines = 0;
    [self.view addSubview:requestDataLabel];
    [requestDataLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel.bottom).offset(15);
        make.centerX.equalTo(0);
        make.left.equalTo(15);
        make.right.equalTo(-15);
    }];
    self.requestDataLabel = requestDataLabel;
}

- (void)getData{
    NSMutableURLRequest *requset = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.apiopen.top/singlePoetry"]];
    requset.HTTPMethod = @"GET";
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *responseDataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [responseDataStr objectFromJSONString];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.requestDataLabel.text = responseDic[@"result"];
        });
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
