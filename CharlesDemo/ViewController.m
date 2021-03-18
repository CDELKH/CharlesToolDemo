//
//  ViewController.m
//  CharlesDemo
//
//  Created by konghui on 2021/3/16.
//

#import "ViewController.h"
#import "CommUtls.h"
#import "CharlesTool.h"
#import "GetRequestViewController.h"
#import "PostRequestViewController.h"
#import "WebRequestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommUtls colorWithHexString:@"#f8f8f8"];
    [self initNav];
    [self addViews];
}

- (void)initNav{
    [self.navigationBarView.titleLabel setText:@"代理抓包Demo"];
}

- (void)addViews{
    CGFloat buttonHeight = 50;
    CGFloat buttonSpacing = 20;
    
    UIButton *entranceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    entranceButton.backgroundColor = [CommUtls colorWithHexString:@"#e0e0e0"];
    [entranceButton setTitle:@"抓包入口" forState:UIControlStateNormal];
    [entranceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[entranceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [CharlesTool debugSetViewControllerController];
    }];
    [self.view addSubview:entranceButton];
    [entranceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBarView.mas_bottom).offset(buttonSpacing);
        make.left.mas_equalTo(buttonSpacing);
        make.right.mas_equalTo(-buttonSpacing);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    @weakify(self)
    NSString *getRequestPageName = @"抓取GET请求";
    UIButton *getRequestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getRequestButton.backgroundColor = [CommUtls colorWithHexString:@"#e0e0e0"];
    [getRequestButton setTitle:getRequestPageName forState:UIControlStateNormal];
    [getRequestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[getRequestButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        GetRequestViewController *getRequestVC = [GetRequestViewController new];
        getRequestVC.showTitle = getRequestPageName;
        [self.navigationController pushViewController:getRequestVC animated:YES];
    }];
    [self.view addSubview:getRequestButton];
    [getRequestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(entranceButton.mas_bottom).offset(buttonSpacing);
        make.left.mas_equalTo(buttonSpacing);
        make.right.mas_equalTo(-buttonSpacing);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    NSString *postRequestPageName = @"抓取POST请求";
    UIButton *postRequestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postRequestButton.backgroundColor = [CommUtls colorWithHexString:@"#e0e0e0"];
    [postRequestButton setTitle:postRequestPageName forState:UIControlStateNormal];
    [postRequestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[postRequestButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        PostRequestViewController *postRequestVC = [PostRequestViewController new];
        postRequestVC.showTitle = postRequestPageName;
        [self.navigationController pushViewController:postRequestVC animated:YES];
    }];
    [self.view addSubview:postRequestButton];
    [postRequestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(getRequestButton.mas_bottom).offset(buttonSpacing);
        make.left.mas_equalTo(buttonSpacing);
        make.right.mas_equalTo(-buttonSpacing);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    NSString *webRequestPageName = @"抓取H5地址";
    UIButton *webRequestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    webRequestButton.backgroundColor = [CommUtls colorWithHexString:@"#e0e0e0"];
    [webRequestButton setTitle:webRequestPageName forState:UIControlStateNormal];
    [webRequestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[webRequestButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        WebRequestViewController *webRequestVC = [WebRequestViewController new];
        webRequestVC.showTitle = webRequestPageName;
        [self.navigationController pushViewController:webRequestVC animated:YES];
    }];
    [self.view addSubview:webRequestButton];
    [webRequestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(postRequestButton.mas_bottom).offset(buttonSpacing);
        make.left.mas_equalTo(buttonSpacing);
        make.right.mas_equalTo(-buttonSpacing);
        make.height.mas_equalTo(buttonHeight);
    }];
}

@end
