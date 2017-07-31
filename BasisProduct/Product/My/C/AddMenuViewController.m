//
//  ViewController.m
//  demo
//
//  Created by zhong on 17/1/16.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import "AddMenuViewController.h"
#import "ItemCell.h"
#import "ItemCellHeaderView.h"

#import "ItemGroup.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


static NSString *reuseID = @"itemCell";
static NSString *sectionHeaderID = @"sectionHeader";

@interface AddMenuViewController () <UICollectionViewDelegate, UICollectionViewDataSource, ItemCellDelegate> {
    NSIndexPath *_originalIndexPath;
    NSIndexPath *_moveIndexPath;
    UIView *_snapshotView;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *itemGroups;
@property (nonatomic, strong) NSArray *allItemModel;
@property (nonatomic, assign) BOOL isEditing;


@end

@implementation AddMenuViewController


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    /// 关闭 侧滑返回功能
    self.fd_interactivePopDisabled = YES;
    [self.navigationController.navigationBar lt_reset];
   

    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    /// 开启 侧滑返回功能
    self.fd_interactivePopDisabled = NO;
    
    
  
}
- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    UIBarButtonItem *managerItem = self.navigationItem.rightBarButtonItem;
    UIButton *managerButton = managerItem.customView;
    managerButton.selected = isEditing;
}



- (NSArray *)itemGroups {
    if (!_itemGroups) {
        
        NSMutableArray * dictArr = [NSMutableArray array];
        
        for (ItemModel *model in _menuNewArr) {
            
            NSDictionary * dict = [model yy_modelToJSONObject];
            
            [dictArr addObject:dict];
        }
        
        
        NSArray *datas = @[
            @{
                @"type" : @"已添加功能",
                @"items" : dictArr
            },
            @{
                @"type" : @"全部功能",
                @"items" : @[

                    @{@"imageName" : @"我的订阅", @"itemTitle" : @"我的货车"},
                    @{@"imageName" : @"球爆", @"itemTitle" : @"我的店铺"},
                    @{@"imageName" : @"名人名单", @"itemTitle" : @"我的土地"},
                    @{@"imageName" : @"竞彩足球", @"itemTitle" : @"我的种植品"},
                    @{@"imageName" : @"竞彩篮球", @"itemTitle" : @"我的拼单"},
                    @{@"imageName" : @"足彩", @"itemTitle" : @"我的简历"},

                    @{@"imageName" : @"我的订阅", @"itemTitle" : @"我的购物车"},
                    @{@"imageName" : @"球爆", @"itemTitle" : @"我的时间"},
                    @{@"imageName" : @"名人名单", @"itemTitle" : @"我的冷库"},
                    @{@"imageName" : @"竞彩足球", @"itemTitle" : @"我的农机"},
                    @{@"imageName" : @"竞彩篮球", @"itemTitle" : @"我的档口"},
                    @{@"imageName" : @"足彩", @"itemTitle" : @"我的招聘"},

                    @{@"imageName" : @"我的订阅", @"itemTitle" : @"我的采购"},
                    @{@"imageName" : @"球爆", @"itemTitle" : @"我的求助"},
                    @{@"imageName" : @"名人名单", @"itemTitle" : @"我的代卖"},
                    @{@"imageName" : @"竞彩足球", @"itemTitle" : @"我的代收"},
                    @{@"imageName" : @"竞彩篮球", @"itemTitle" : @"我的报价"},
                    @{@"imageName" : @"足彩", @"itemTitle" : @"我的商品"},

                ]
            },
            
        ];

        NSMutableArray *array = [NSMutableArray arrayWithCapacity:datas.count];
        NSMutableArray *allItemModels = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in datas) {
            ItemGroup *group = [[ItemGroup alloc] initWithDict:dict];
            if ([group.type isEqualToString:@"已添加功能"]) {
                for (ItemModel *model in group.items) {
                    model.status = StatusMinusSign;
                }
            } else {
                [allItemModels addObjectsFromArray:group.items];
            }
            [array addObject:group];
        }
        _itemGroups = [array copy];
        _allItemModel = [allItemModels copy];
    }

    return _itemGroups;
}

- (void)viewDidLoad {
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightbarButtonItemWithNorImage:nil highImage:nil target:self action:@selector(managerAction:) withTitle:@"编辑"];
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftbarButtonItemWithNorImage:kImageNamed(@"navigationbar_back") highImage:kImageNamed(@"navigationbar_back") target:self action:@selector(leftBtnAction) withTitle:@""];
    [super viewDidLoad];
    
    self.title = @"添加应用";
  
 
    [self setupCollectionView];
}

-(void) leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
    if (_returnArrBlock) {
        
        self.returnArrBlock(self.menuNewArr);
    }
}
#pragma mark - 编辑按钮
- (void)managerAction:(UIButton *)managerButton {
    managerButton.selected = !managerButton.selected;
    self.isEditing = managerButton.selected;
    [self.collectionView reloadData];
}


- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 35);
    
    CGRect rect = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 );
    
    _collectionView = [[UICollectionView alloc] initWithFrame: rect collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ItemCell class] forCellWithReuseIdentifier:reuseID];
    
    [_collectionView registerClass:[ItemCellHeaderView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:sectionHeaderID];

    UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [_collectionView addGestureRecognizer:longPress];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemGroups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ItemGroup *group = self.itemGroups[section];
    return group.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.delegate = self;

    ItemGroup *group = self.itemGroups[indexPath.section];
    ItemModel *itemModel = group.items[indexPath.row];
    if (indexPath.section != 0) {
        BOOL isAdded = NO;
        ItemGroup *homeGroup = self.itemGroups[0];
        for (ItemModel *homeItemModel in homeGroup.items) {

            if ([homeItemModel.itemTitle isEqualToString:itemModel.itemTitle]) {
                isAdded = YES;
                break;
            }
        }

        if (isAdded) {
            itemModel.status = StatusCheck;
        } else {
            itemModel.status = StatusPlusSign;
        }
    }
    cell.isEditing = _isEditing;
    cell.itemModel = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {

    if (kind == UICollectionElementKindSectionHeader) {
        ItemCellHeaderView *headerView =
            [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                               withReuseIdentifier:sectionHeaderID
                                                      forIndexPath:indexPath];

        ItemGroup *group = self.itemGroups[indexPath.section];
        headerView.title = group.type;

        return headerView;
    } else {
        return nil;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 10, 10);

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@" section = %ld", indexPath.section);

    NSLog(@"row %ld", indexPath.row);
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
                ItemCell *selectedItemCell = (ItemCell *) [self.collectionView cellForItemAtIndexPath:_moveIndexPath];
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
                  
                    ItemGroup *homeGroup = self.itemGroups[0];
                    
                    NSMutableArray *array = homeGroup.items;
                    
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
                   #pragma mark - 移动结束后数组

                    _menuNewArr = [NSMutableArray arrayWithArray:array];
                    
                    
                    [self.collectionView moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
                    _originalIndexPath = _moveIndexPath;
                }
            }
        } break;
        case UIGestureRecognizerStateEnded: {
            NSLog(@"上传换号位置之后的请求吧");

            ItemCell *cell = (ItemCell *) [self.collectionView cellForItemAtIndexPath:_originalIndexPath];
            cell.hidden = NO;
            [_snapshotView removeFromSuperview];
        } break;

        default:
            break;
    }
}

#pragma mark - 点击右上角按钮 ＋ － √ 号
- (void)rightUpperButtonDidTappedWithItemCell:(ItemCell *)itemCell {

    ItemModel *itemModel = itemCell.itemModel;
    if (itemModel.status == StatusMinusSign) {   ///  减号
        ItemGroup *homeGroup = self.itemGroups[0];
        
        [(NSMutableArray *) homeGroup.items removeObject:itemModel];
#pragma mark - 减号操作数组
        _menuNewArr = [NSMutableArray array];
        [_menuNewArr addObjectsFromArray:homeGroup.items];
        
        
        for (ItemModel *model in self.allItemModel) {
            if ([itemModel.itemTitle isEqualToString:model.itemTitle]) {
                model.status = StatusPlusSign;
                break;
            }
        }
        UIView *snapshotView = [itemCell snapshotViewAfterScreenUpdates:YES];
        snapshotView.frame = [itemCell convertRect:itemCell.bounds toView:self.view];
        ;
        [self.view addSubview:snapshotView];
        itemCell.hidden = YES;
       
        [UIView animateWithDuration:0.4
            animations:^{
                snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            }
            completion:^(BOOL finished) {
                [snapshotView removeFromSuperview];
                itemCell.hidden = NO;
                [self.collectionView reloadData];
            }];

    } else if (itemModel.status == StatusPlusSign) {    ///   加号
        itemModel.status = StatusCheck;
        ItemGroup *homeGroup = self.itemGroups[0];
        ItemModel *homeItemModel = [[ItemModel alloc] init];
        homeItemModel.imageName = itemModel.imageName;
        homeItemModel.itemTitle = itemModel.itemTitle;
        homeItemModel.status = StatusMinusSign;
        [homeGroup.items addObject:homeItemModel];
        // MARK: ------ Arr加菜单 ------
        _menuNewArr = [NSMutableArray array];
        [_menuNewArr addObjectsFromArray:homeGroup.items];
        
        UIView *snapshotView = [itemCell snapshotViewAfterScreenUpdates:YES];
        snapshotView.frame = [itemCell convertRect:itemCell.bounds toView:self.view];
        [self.view addSubview:snapshotView];

        [self.collectionView reloadData];
        [self.collectionView layoutIfNeeded];

        ItemCell *lastCell = (ItemCell *) [self.collectionView
            cellForItemAtIndexPath:[NSIndexPath indexPathForItem:homeGroup.items.count - 1 inSection:0]];
        lastCell.hidden = YES;
        CGRect targetFrame = [lastCell convertRect:lastCell.bounds toView:self.view];
        
        [UIView animateWithDuration:0.4 animations:^{
            snapshotView.frame = targetFrame;
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            lastCell.hidden = NO;
        }];
        
    }else if (itemModel.status == StatusCheck) {
        ///
    }
}




@end
