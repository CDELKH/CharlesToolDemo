//
//  PostRequestViewController.m
//  CharlesDemo
//
//  Created by konghui on 2021/3/17.
//

#import "PostRequestViewController.h"
#import <JSONKit-NoWarning/JSONKit.h>
#import "PostRequestCell.h"
#import "CommUtls.h"

@interface PostRequestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation PostRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    
    [self addViews];
    [self getData];
}

- (void)addViews{
    UITableView *mainTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    mainTable.backgroundColor = [CommUtls colorWithHexString:@"#eeeeee"];
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    [self nearByNavigationBarView:mainTable isShowBottom:NO];
    self.mainTable = mainTable;
}

- (void)getData{
    NSMutableURLRequest *requset = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.apiopen.top/videoCategoryDetails"]];
    requset.HTTPMethod = @"POST";
    requset.HTTPBody = [@"id=14" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString *responseDataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *responseDic = [responseDataStr objectFromJSONString];
            for (NSDictionary *item in responseDic[@"result"]) {
                NSDictionary *data = item[@"data"];
                NSDictionary *header = data[@"header"];
                [self.dataSource addObject:header];
            }
            @weakify(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                [self.mainTable reloadData];
            });
        }
    }];
    [task resume];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = NSStringFromClass([PostRequestCell class]);
    PostRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PostRequestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.modelDic = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

@end
