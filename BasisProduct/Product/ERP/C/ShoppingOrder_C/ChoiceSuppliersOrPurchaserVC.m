//
//  ChoiceSuppliersVC.m
//  Product
//
//  Created by Sen wang on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChoiceSuppliersOrPurchaserVC.h"

#import "ChoiceSuppliersOrPurchaserCell.h"
#import "ScanHelper.h"



@interface ChoiceSuppliersOrPurchaserVC () <UITableViewDelegate, UITableViewDataSource, PYSearchViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, copy) NSMutableArray *dataArr;

@end

@implementation ChoiceSuppliersOrPurchaserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_titleType == 100) {
        self.title = @"选择供货商";

    } else if (_titleType == 200) {
        self.title = @"添加采购商";
    }
    SearchView *searchView = [SearchView viewFromXib];
    searchView.frame = CGRectMake(0, 64, kScreenWidth, 50);
    [self.view addSubview:searchView];
    
    // MARK: ------ 监听点击扫描方法 ------

        [[searchView rac_signalForSelector:@selector(scanQRBtnAction:)] subscribeNext:^(id  _Nullable x) {
        

        [self.navigationController pushViewController:[[ScanHelper shareInstance] ScanVCWithStyle:qqStyle qrResultCallBack:^(id result) {
            //扫码结果
            NSLog(@"扫结果-----%@",result);
        }] animated:YES];
        
        
    }];
    
    // MARK: ------ 监听点击搜索方法 ------

    [[searchView rac_signalForSelector:@selector(searchBtnAction:)] subscribeNext:^(id _Nullable x) {

        NSArray *hotSeaches = [SearchNetworkRequest requestHotSeaches];

        PYSearchViewController *searchViewController = [PYSearchViewController
            searchViewControllerWithHotSearches:hotSeaches
                           searchBarPlaceholder:@"搜索关键字"
                                 didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar,
                                                  NSString *searchText) {

                                     [searchViewController.navigationController
                                         pushViewController:[[SearchResultVC alloc] init]
                                                   animated:YES];
                                 }];
        searchViewController.hotSearchStyle = PYHotSearchStyleRankTag;
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;

        searchViewController.delegate = self;

        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:searchViewController];
        [self presentViewController:nav animated:YES completion:nil];

    }];
    // MARK: ------ 监听点击语音方法 ------

    [[searchView rac_signalForSelector:@selector(voiceBtnAction:)] subscribeNext:^(id _Nullable x) {

        SpeechViewController *speechVC = [[SpeechViewController alloc] init];

        [self.navigationController pushViewController:speechVC animated:YES];

    }];
    
    
    self.tableview = [[UITableView alloc]
        initWithFrame:CGRectMake(0, searchView.height + 70, kScreenWidth, kScreenHeight - searchView.height - 70)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [XXHelper deleteExtraCellLine:_tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:_tableview];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ChoiceSuppliersOrPurchaserCell class]) bundle:nil]
        forCellReuseIdentifier:@"ChoiceSuppliersOrPurchaserCellid"];

    _dataArr = [NSMutableArray arrayWithObjects:@"张三丰", @"德玛西亚", @"曙光女神", @"滑板鞋", @"钟馗",
                                                @"后裔", @"妲己", @"甄姬", nil];
    
    self.tableview.mj_header = [XXRefreshGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableview.mj_header endRefreshing];
        });
        

        
    }];
   
    
    self.tableview.mj_footer = [XXRefreshAutoGifFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ [self.tableview.mj_footer endRefreshing]; });
        
    
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChoiceSuppliersOrPurchaserCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"ChoiceSuppliersOrPurchaserCellid"];
    cell.tag = indexPath.row;

    if (_titleType == 100) {
        cell.Identity_tag_label.text = @"供货商";

    } else if (_titleType == 200) {
        cell.Identity_tag_label.text = @"采购商";
    }
    cell.name_label.text = _dataArr[indexPath.row];
    
    

    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:@"ChoiceSuppliersOrPurchaserCellid" cacheByIndexPath:indexPath configuration:^(ChoiceSuppliersOrPurchaserCell *cell) {
        cell.name_label.text = _dataArr[indexPath.row];

    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    if (_titleType == 100) {

        [self showAlertTitle:@"确定供货商" message:_dataArr[indexPath.row] clickArr:@[@"确定",@"我再想想"] click:^(NSInteger index) {
        
        }];
    } else if (_titleType == 200) {
        
   
        [self showAlertTitle:@"添加采购商" message:_dataArr[indexPath.row] clickArr:@[@"确定",@"我再想想"] click:^(NSInteger index) {

            if (_returnNameblock && index == 0) {
                self.returnNameblock(_dataArr[indexPath.row]);
                [self.navigationController popViewControllerAnimated:YES];
            }

        }];
    }
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
