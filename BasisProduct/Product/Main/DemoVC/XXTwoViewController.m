//
//  XXTwoViewController.m
//  Product
//
//  Created by Sen wang on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXTwoViewController.h"

#import "SearchResultVC.h"

@interface XXTwoViewController () <UITableViewDataSource,UITableViewDelegate, PYSearchViewControllerDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *toolView;

@property (nonatomic ,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic ,strong) PYPhotosView *photosView;


- (IBAction)searchAction:(UIButton *)sender;

@end

@implementation XXTwoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
        [_cycleScrollView adjustWhenControllerViewWillAppera];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 网络加载 --- 创建带标题的图片轮播器
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    NSArray *titlesArr = @[@"第一张",
                           @"第二张",
                           @"第三张",
                           @"第四张",
                           @"第五张",
                           ];
     _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.titlesGroup =  titlesArr;
    _cycleScrollView.pageDotImage = kImageNamed(@"pageControlDot");
    _cycleScrollView.currentPageDotImage = kImageNamed(@"pageControlCurrentDot");
    _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    self.tableview.tableHeaderView = _cycleScrollView;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
    } else {
        
        cell.backgroundColor = kRandomColor;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor blueColor] WithScrollView:scrollView AndValue:150];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"我是第%ld张",index);
}



- (IBAction)searchAction:(UIButton *)sender {
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"你想要说什么话" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {

        
        [searchViewController.navigationController pushViewController:[[SearchResultVC alloc] init] animated:YES];
    }];
    
    [searchViewController.cancelButton setTintColor:[UIColor redColor]];
    searchViewController.searchResultShowMode = PYSearchResultShowModeDefault;
    searchViewController.hotSearchStyle = PYHotSearchStyleRankTag;
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;

    searchViewController.delegate = self;

    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    NSLog(@"pp  %@",searchViewController.cancelButton.title);
}



@end
