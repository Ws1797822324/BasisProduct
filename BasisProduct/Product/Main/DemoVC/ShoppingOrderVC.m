//
//  ShoppingOrder.m
//  Product
//
//  Created by Sen wang on 2017/7/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShoppingOrderVC.h"

#import "ShoppingOrderDefaultCell.h"

#import "CommodityCell.h"

#import "CommodityModel.h"

#import "SearchResultVC.h"

#define typeHidden @"hiddentypeStr"

@interface ShoppingOrderVC () <UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, PYSearchViewControllerDelegate> {
    
    NSIndexPath *_originalIndexPath;
    NSIndexPath *_moveIndexPath;
    UIView *_snapshotView;

}


@property (nonatomic ,strong) SearchView *searchView;

@property (nonatomic ,strong) UITableView *tableview;

/// 点击 cell 用于箭头方向
@property (nonatomic ,assign) BOOL cellSelected;
/// 选中的是哪个供货商
@property (nonatomic ,assign) NSInteger selectedCell;

///长按手势
@property (nonatomic, assign) BOOL isEditing;


@property (nonatomic ,strong) NSMutableArray *personArr;  // 购货商

@property (nonatomic ,strong) NSMutableArray *commodityDataArr;

@property (nonnull , strong) UICollectionView * collectionView;

@property (nonatomic ,assign) NSInteger index;

@end

@implementation ShoppingOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"采购开单";
    self.searchView = [SearchView viewFromXib];
    self.searchView.frame = CGRectMake(0, 64, kScreenWidth, 50);
    [self.view addSubview:_searchView];
    
    [[self.searchView rac_signalForSelector:@selector(searchBtnAction:)] subscribeNext:^(id  _Nullable x) {

        NSArray *hotSeaches = [SearchNetworkRequest requestHotSeaches];

        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索关键字" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            

            [searchViewController.navigationController pushViewController:[[SearchResultVC alloc] init] animated:YES];
        }];
        searchViewController.hotSearchStyle = PYHotSearchStyleRankTag;
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;

        searchViewController.delegate = self;
        
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:searchViewController];
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
    
    self.tableview =  [[UITableView alloc]initWithFrame:CGRectMake(0, _searchView.height + 64, kScreenWidth, kScreenHeight - _searchView.height - 64)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview: _tableview];
    
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingOrderDefaultCell class]) bundle:nil] forCellReuseIdentifier:@"ShoppingOrderDefaultCellID"];

    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [XXHelper deleteExtraCellLine:_tableview];
    _personArr = [NSMutableArray array];
    [_personArr addObjectsFromArray:@[@"111",@"222",@"333",@"111",@"444",@"555",@"666",@"777",@"888",@"999",@"AAA",@"BBB",@"CCC",@"DDD",@"EEE",@"FFF"]];
    
    _commodityDataArr = [NSMutableArray arrayWithObjects:@"苹果",@"香蕉",@"橘子",@"火龙果",@"猕猴桃",@"荔枝",@"桑葚",@"哈密瓜",@"榴莲",@"石榴",@"无花果",@"栗子",@"西瓜" ,nil];

#pragma mark - 添加占位数据 必做    //////////////////
    for (int kk = 0; kk< _personArr.count; kk ++) {
        
        if (kk % 2 != 0) {

            [_personArr insertObject:typeHidden atIndex:kk];
        }
    }
    [_personArr insertObject:typeHidden atIndex:_personArr.count];
     #pragma mark - ///////////////////////////

}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.selectedCell = 2;
    self.cellSelected = YES;
    self.index = 0;
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (_personArr.count) + 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ShoppingOrderDefaultCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"ShoppingOrderDefaultCellID" forIndexPath:indexPath];
    

    if (indexPath.section == 0 ) {
        cell.identityLabel.hidden = true;
        cell.automobileNumberBtn.hidden = true;
        cell.nameLabel.text = @"选择供货商";

    } else if (indexPath.section == _personArr.count + 1) {
        cell.identityLabel.hidden = true;
        cell.automobileNumberBtn.hidden = true;
        cell.nameLabel.text = @"选择采购商";
    }   else {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",_personArr[indexPath.section - 1]];
        cell.identityLabel.hidden = false;
        cell.automobileNumberBtn.hidden = false;
    }
    
        if (self.cellSelected && self.selectedCell == indexPath.section + 1) {
           
            cell.right_image.image = kImageNamed(@"bottom_arrow");
            
        } else {
            cell.right_image.image = kImageNamed(@"right_arrow");
            
        }
    if ([cell.nameLabel.text isEqualToString:typeHidden]) {

        cell.contentView.hidden = YES;
        cell.userInteractionEnabled = NO;
    } else {

        cell.contentView.hidden = NO;
        cell.userInteractionEnabled = YES;
    }
    

 
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSLog(@"点击的第 %ld 个",indexPath.section);
    
    if (indexPath.section == 0) {
        NSLog(@"跳转选择供货商");
        return;
    }
    if (indexPath.section == _personArr.count + 1) {
        NSLog(@"跳转选择采购商");
        return;

    }
   
    if ((self.selectedCell == indexPath.section + 1)) {
        self.cellSelected = !self.cellSelected;
    } else {
        self.cellSelected = YES;
    }
    self.selectedCell = indexPath.section + 1;

   
    

    for (int k = 1; k< _personArr.count + 1; k++ ) {
        NSIndexSet *indexSet2=[[NSIndexSet alloc]initWithIndex:k];
        [_tableview reloadSections:indexSet2 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    // 显示到指定的 section

    NSInteger section1 = indexPath.section == (_personArr.count +1) ?  indexPath.section : indexPath.section + 2;
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:section1];
    
    [self.tableview scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
}




-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    // MARK: ------ 点击采购商会弹出的 View ------
    if (section ==  self.selectedCell && self.cellSelected ) {


        CGRect rect = CGRectMake(0, 0, kScreenWidth, 310);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CommodityCell class]) bundle:nil] forCellWithReuseIdentifier:@"CommodityCellID"];
       
        UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_collectionView addGestureRecognizer:longPress];
        return _collectionView;
    }
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
     if (section ==  self.selectedCell && self.cellSelected) {
        return 310.f;
    }
    else {
        return 0.01f;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1 || section == _personArr.count + 1) {
        return 10;
    } else {
        return 0.01f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.section == 0 || (indexPath.section == _personArr.count + 1)) {
        return 44.f;
    }
    if ([_personArr[indexPath.section - 1 ] isEqualToString:typeHidden]) {
        return 0.001f;
    }
        return 44.f;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == _personArr.count - 1) || (indexPath.section == 0) || _cellSelected) {
        return false;
    } else {
        return true;
    }
    

}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        id data1 = _personArr[indexPath.section - 1];
        id data2 = _personArr[indexPath.section ];   // 占位
        [_personArr  removeObjectAtIndex:indexPath.section];
        [_personArr removeObjectAtIndex:indexPath.section - 1];
        [_personArr  insertObject:data1 atIndex:0];
        [_personArr insertObject:data2 atIndex:1];
        
        [_tableview reloadData];
        NSLog(@"置顶之后接口上传");
    }];
    

    return @[deleteRowAction];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _commodityDataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 90);
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
    
    CommodityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommodityCellID" forIndexPath:indexPath];
    cell.commodity_name.text = _commodityDataArr[indexPath.row];
    cell.commodity_img.backgroundColor = kRandomColor;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"ni dian ji le %ld",indexPath.row);
}

#pragma mark - 长按手势
- (void)longPressAction:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint touchPoint = [recognizer locationInView:self.collectionView];
    _moveIndexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (_isEditing == NO) {
                self.isEditing = YES;

                [self.collectionView reloadData];
                [self.collectionView layoutIfNeeded];
            }
            if (_moveIndexPath.section == 0) {

                CommodityCell *selectedItemCell = (CommodityCell *) [self.collectionView cellForItemAtIndexPath:_moveIndexPath];
                _originalIndexPath = [self.collectionView indexPathForItemAtPoint:touchPoint];
                if (!_originalIndexPath) {
                    return;
                }
                _snapshotView = [selectedItemCell.container snapshotViewAfterScreenUpdates:YES];
                _snapshotView.center = [recognizer locationInView:self.collectionView];
                [self.collectionView addSubview:_snapshotView];
                selectedItemCell.hidden = YES;
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     _snapshotView.transform = CGAffineTransformMakeScale(1.03, 1.03);
                                     _snapshotView.alpha = 0.98;
                                 }];
            }
            
        } break;
        case UIGestureRecognizerStateChanged: {
            
            _snapshotView.center = [recognizer locationInView:self.collectionView];
            
            if (_moveIndexPath.section == 0) {

                if (_moveIndexPath && ![_moveIndexPath isEqual:_originalIndexPath] &&
                    _moveIndexPath.section == _originalIndexPath.section) {
                    
                    NSMutableArray *array = _commodityDataArr;
                    
                    NSInteger fromIndex = _originalIndexPath.item;
                    
                    NSInteger toIndex = _moveIndexPath.item;

                    if (fromIndex < toIndex) {
                        for (NSInteger i = fromIndex; i < toIndex; i++) {
                            [array exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                        }
                    } else {
                        for (NSInteger i = fromIndex; i > toIndex; i--) {
                            [array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                        }
                    }
                    
                    _commodityDataArr = [NSMutableArray arrayWithArray:array];
                    
                    [self.collectionView moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
                    _originalIndexPath = _moveIndexPath;
                }
            }

        } break;
        case UIGestureRecognizerStateEnded: {
            NSLog(@"上传换号位置之后的请求吧");

            CommodityCell *cell = (CommodityCell *) [self.collectionView cellForItemAtIndexPath:_originalIndexPath];
            cell.hidden = NO;
            [_snapshotView removeFromSuperview];
        } break;
            
        default:
            break;
    }
    
}


@end
