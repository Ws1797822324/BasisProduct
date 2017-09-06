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

#import "GreensDetailsVC.h"
#import "ScanHelper.h"

/** 选择购货商或购货商 */
#import "ChoiceSuppliersOrPurchaserVC.h"

#define typeHidden @"hiddentypeStr"

@interface ShoppingOrderVC () <UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, PYSearchViewControllerDelegate> {
    
    NSIndexPath *_originalIndexPath;
    NSIndexPath *_moveIndexPath;
    UIView *_snapshotView;

}

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

//** block 返回来的选择的那个供货商 */
@property (nonatomic ,copy) NSString *supplier_nameStr;

@end

@implementation ShoppingOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"采购开单";
    SearchView *searchView = [SearchView viewFromXib];
    searchView.frame = CGRectMake(0, 64, kScreenWidth, 50);
    [self.view addSubview:searchView];
    
    [[searchView rac_signalForSelector:@selector(searchBtnAction:)] subscribeNext:^(id  _Nullable x) {

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
    [[searchView rac_signalForSelector:@selector(voiceBtnAction:)] subscribeNext:^(id  _Nullable x) {
        
        SpeechViewController * speechVC = [[SpeechViewController alloc]init];
        
        [self.navigationController pushViewController:speechVC animated:YES];
    
    
    }];
    
    
    // MARK: ------ 监听点击扫描方法 ------
    
    [[searchView rac_signalForSelector:@selector(scanQRBtnAction:)] subscribeNext:^(id  _Nullable x) {
        
        
        [self.navigationController pushViewController:[[ScanHelper shareInstance] ScanVCWithStyle:qqStyle qrResultCallBack:^(id result) {
            //扫码结果
            NSLog(@"扫结果-----%@",result);
        }] animated:YES];
        
        
    }];
    
    self.tableview =  [[UITableView alloc]initWithFrame:CGRectMake(0, searchView.height + 64, kScreenWidth, kScreenHeight - searchView.height - 64)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview: _tableview];
    
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingOrderDefaultCell class]) bundle:nil] forCellReuseIdentifier:@"ShoppingOrderDefaultCellID"];

    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [XXHelper deleteExtraCellLine:_tableview];
    _personArr = [[NSMutableArray alloc]init];
    [_personArr addObjectsFromArray:@[@"李白",@"杜甫",]];
    
    _commodityDataArr = [NSMutableArray arrayWithObjects:@"苹果",@"香蕉",@"橘子",@"火龙果",@"猕猴桃",@"荔枝",@"桑葚",@"哈密瓜",@"榴莲",@"石榴",@"无花果",@"栗子",@"西瓜" ,nil];

#pragma mark - 添加占位数据 必做    //////////////////
    for (int kk = 0; kk< _personArr.count; kk ++) {
        
        if (kk % 2 != 0) {

            [_personArr insertObject:typeHidden atIndex:kk];
        }
    }
    
    if (_personArr.count != 0) {
        
        [_personArr insertObject:typeHidden atIndex:_personArr.count];
    }
     #pragma mark - ///////////////////////////

}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

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
        cell.supplier_nameLabel.hidden = false;
        cell.supplier_nameLabel.text = _supplier_nameStr;

    } else if (indexPath.section == _personArr.count + 1) {
        cell.identityLabel.hidden = true;
        cell.automobileNumberBtn.hidden = true;
        cell.nameLabel.text = @"选择采购商";
        cell.supplier_nameLabel.hidden = true;

    }   else {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",_personArr[indexPath.section - 1]];
        cell.identityLabel.hidden = false;
        cell.automobileNumberBtn.hidden = false;
        cell.supplier_nameLabel.hidden = true;

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

         ChoiceSuppliersOrPurchaserVC * choiceSuppliersVc = [[ChoiceSuppliersOrPurchaserVC alloc]init];
        choiceSuppliersVc.titleType = 100;
        choiceSuppliersVc.returnNameblock = ^(id nameBlock) {
            _supplier_nameStr = nameBlock;
            
            NSIndexSet  *indexSet = [NSIndexSet indexSetWithIndex:0];
            [_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:choiceSuppliersVc animated:YES];
        return;
    }
    if (indexPath.section == _personArr.count + 1) {

        ChoiceSuppliersOrPurchaserVC *purchaserVc = [[ChoiceSuppliersOrPurchaserVC alloc]init];
        purchaserVc.titleType = 200;
        purchaserVc.returnNameblock = ^(id nameBlock) {


            [_personArr insertObject:nameBlock atIndex:0];
            // ** 这一部添加占位数据  必做   */
            [_personArr insertObject :typeHidden atIndex:1];
            [_tableview reloadData];
        };
        [self.navigationController pushViewController:purchaserVc animated:YES];

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

    if (section == 0) {
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        view1.backgroundColor = [UIColor whiteColor];
        UIButton * btn1 = [[UIButton alloc]init];
        btn1.backgroundColor =[UIColor redColor];
        kViewRadius(btn1, 4);
        btn1.frame = CGRectMake(20, 10, (kScreenWidth - 60) * 0.5, 55);
        [btn1 setTitle:@"恭喜发财" forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"恭喜发财哦");
        }];
        [view1 addSubview:btn1];
        UIButton * btn2 = [[UIButton alloc]init];
        btn2.frame = CGRectMake(kScreenWidth * 0.5 + 10, 10, btn1.width, 55);
        btn2.backgroundColor =[UIColor greenColor];
        kViewRadius(btn2, 4);
[[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    NSLog(@"万事如意");
}];
        [btn2 setTitle:@"万事如意" forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [view1 addSubview:btn2];
        return view1;
    } else if ((section ==  self.selectedCell) && self.cellSelected ) {

        // MARK: ------ 点击采购商会弹出的 View ------

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
    if (section == 0) {
        return 80.f;
    } else if (section ==  self.selectedCell && self.cellSelected) {
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
    
    if ((indexPath.section == _personArr.count + 1) || (indexPath.section == 0) || _cellSelected) {
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
    
    GreensDetailsVC * detailsVc = [GreensDetailsVC new];
    [self.navigationController pushViewController:detailsVc animated:true];
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
