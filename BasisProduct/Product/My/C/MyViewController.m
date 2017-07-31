//
//  XXViewController.m
//  Demo
//
//  Created by Sen wang on 2017/6/26.
//  Copyright © 2017年 王森. All rights reserved.
//

#import "MyViewController.h"

#import "MyToolView.h"
#import "MyCollectionCell.h"
#import "SettingVC.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MyViewController () <UICollectionViewDelegate, UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout>

/// 背景图片
@property (nonatomic, strong) UIImageView *backgroundImageView;

/// 基本信息加 一排 Button View
@property (nonatomic, strong) MyToolView *myToolView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MyViewController

static NSString *const cellId = @"myCollectionCellID";

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    /// 设置 导航栏
    [self settingNav];


    for (id model in _menuArray) {

        NSLog(@"shouye - %@", [model yy_modelToJSONObject]);
    }
}
- (void)viewDidLoad {

    _menuArray = [NSMutableArray array];
    NSArray *arr = @[
        @{ @"imageName" : @"热门话题",
           @"itemTitle" : @"热门话题" },
        @{ @"imageName" : @"热点资讯",
           @"itemTitle" : @"热点资讯" },
        @{ @"imageName" : @"我不是头条",
           @"itemTitle" : @"我不是头条" },
        @{ @"imageName" : @"焦点赛事",
           @"itemTitle" : @"焦点赛事" },
    ];

    for (NSDictionary *dict in arr) {

        ItemModel *model = [ItemModel yy_modelWithDictionary:dict];
        [_menuArray addObject:model];
    }

    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myBackgroundImage"]];

    self.backgroundImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.35);

    [self.view addSubview:_backgroundImageView];

    self.myToolView = [[MyToolView alloc] init];
    self.myToolView.frame = CGRectMake(0, self.backgroundImageView.height * 0.5, kScreenWidth, kScreenHeight * 0.3);
    [self.view addSubview:_myToolView];

    CGFloat fliatY = self.myToolView.buttonView.y + self.backgroundImageView.height - 40;
    CGRect rect = CGRectMake(0, fliatY, kScreenWidth, kScreenHeight - fliatY - 49);

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionCell class]) bundle:nil]
        forCellWithReuseIdentifier:cellId];
    
//    [_collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:cellId];
    [self.view addSubview:_collectionView];
    [super viewDidLoad];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)settingNav {


    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 20)];

    statusBarView.backgroundColor = [UIColor clearColor];

    [self.navigationController.navigationBar addSubview:statusBarView];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
//    //消除导航栏阴影

        [self.navigationController.navigationBar hiddenLine];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:kImageNamed(@"setting_icon") highImage:kImageNamed(@"setting_icon") target:self action:@selector(myRightBarButtonItem) withTitle:nil];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:kImageNamed(@"bell") highImage:kImageNamed(@"bell") target:self action:@selector(myLeftBarButtonItem) withTitle:nil];
}

-(void) myRightBarButtonItem {
    

    SettingVC *vc = [[SettingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) myLeftBarButtonItem {
    
    NSLog(@"铃铛");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _menuArray.count + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(80, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                                      layout:(UICollectionViewLayout *)collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                                 layout:(UICollectionViewLayout *)collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    kViewRadius(cell, 4);
    if (indexPath.row == _menuArray.count) {
        cell.imgView.image = kImageNamed(@"addMenu");
        cell.nameLabel.text = @"添加功能";
    } else {
        cell.model = _menuArray[indexPath.row];
    }

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == _menuArray.count) {

        // MARK: ------ 跳转到添加菜单页面 ------
        AddMenuViewController *addVC = [[AddMenuViewController alloc] init];

        addVC.menuNewArr = [NSMutableArray array];

        addVC.menuNewArr = _menuArray;

        addVC.returnArrBlock = ^(NSMutableArray *newMenuArr) {
            _menuArray = [NSMutableArray array];
            [_menuArray addObjectsFromArray:newMenuArr];
            [_collectionView reloadData];

        };
        [self.navigationController pushViewController:addVC animated:YES];

        return;
    }
    ItemModel *menuModel = _menuArray[indexPath.row];
    NSString *menuName = menuModel.itemTitle;
    NSLog(@"%ld -- %ld  -- %@", indexPath.section, indexPath.row, menuName);
    if ([menuName isEqualToString:@"热门话题"]) {


    }
#warning 这里的 collection 点击跳转必须名字判断

    
    
}



@end
