//
//  VController.m
//  Product
//
//  Created by Sen wang on 2017/8/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GreensDetailsVC.h"

#import "GreensDetailsCell.h"
#import "ShoppingOrderDefaultCell.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import "TZImageManager.h"
#import "UIView+Layout.h"

@interface GreensDetailsVC () <UITableViewDelegate, UITableViewDataSource,
                               UICollectionViewDataSource, UICollectionViewDelegate> {
    /** 采购标准分区的收缩用 section = 4 */
    BOOL selectCell4;
    /** 备注分区的收缩用 section = 6 */
    BOOL selectCell6;

    NSMutableArray *cellNameArr;

    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;

    CGFloat _itemWH;
    CGFloat _margin;
}

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) LxGridViewFlowLayout *layout;

@end

static NSString *GreensDetailsCellId = @"GreensDetailsCellid";
@implementation GreensDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"采购开单";
    [self loadTableview];
    selectCell4 = NO;
    selectCell6 = YES;
    cellNameArr = [[NSMutableArray alloc] init];
    [cellNameArr addObjectsFromArray:@[
        @[ @"采购商", @"供货商", @"商品名称" ], @[ @"件数", @"单价" ],
        @[
           @"总毛重",
           @"总皮重",
           @"总净重",
           @"商品流向",
        ],
        @[
           @"采购标准",
           @"包装形式",
           @"商品计价方式",
           @"毛重",
           @"皮重",
           @"净重",
           @"代收费计价方式",
           @"代收费",
           @"包装费",
           @"材料费",
           @"",
        ],
        @[
           @"应付金额",
           @"实付金额",
        ],
        @[ @"备注" ], @[ @"" ]
    ]];

    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
}

- (UIView *)configCollectionView {

    _layout = [[LxGridViewFlowLayout alloc] init];
    _collectionView =
        [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 230) collectionViewLayout:_layout];

    _collectionView.alwaysBounceVertical = NO; // 分页
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    return _collectionView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadTableview {
    _tableview =
        [[UITableView alloc] initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight - kNavHeight)];
    [self.view addSubview:_tableview];
    _tableview.backgroundColor = kHexColor(@"#F7F7F7");
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([GreensDetailsCell class]) bundle:nil]
        forCellReuseIdentifier:GreensDetailsCellId];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingOrderDefaultCell class]) bundle:nil]
        forCellReuseIdentifier:@"ShoppingOrderDefaultCell_id"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return cellNameArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellNameArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GreensDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:GreensDetailsCellId];

    cell.nameLabel.text = cellNameArr[indexPath.section][indexPath.row];

    cell.backgroundColor = [UIColor whiteColor];

    // MARK: ------ 借用上个类的 cell ------
    ShoppingOrderDefaultCell *contractiveCell =
        [tableView dequeueReusableCellWithIdentifier:@"ShoppingOrderDefaultCell_id"];
    // MARK: ------ 设置星星 ------
    if (indexPath.section == 1) {
        cell.stars_imageView.hidden = NO;
        cell.textF.hidden = NO;
    } else {
        cell.stars_imageView.hidden = YES;
        cell.textF.hidden = YES;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.priceButton.hidden = NO;
        cell.price_width.constant = 45;
    } else {
        cell.priceButton.hidden = YES;
        cell.price_width.constant = 0.001;
    }

    if (indexPath.section == 2 && indexPath.row == 3) {

        cell.jianTou_Image.hidden = NO;
        cell.jianTou_width.constant = 20;

    } else {
        cell.jianTou_Image.hidden = YES;
        cell.jianTou_width.constant = 0.0001;
    }

    if (indexPath.section == 3) {

        if (indexPath.row == 0) {
            contractiveCell.nameLabel.text = @"采购标准";

            contractiveCell.right_image.image =
                selectCell4 ? kImageNamed(@"bottom_arrow") : kImageNamed(@"right_arrow");
            return contractiveCell;
        }

        if (indexPath.row != 0 && !selectCell4) {
            cell.contentView.hidden = YES;

            cell.nameLabel.text = cellNameArr[indexPath.section][indexPath.row];
            return cell;
        }
        cell.nameLabel.font = kFont(12);

    } else {
        cell.contentView.hidden = NO;
        cell.nameLabel.font = kFont(14);
    }

    if (indexPath.section == 5 && indexPath.row == 0) {

        contractiveCell.nameLabel.text = @"备注";
        contractiveCell.right_image.image = selectCell6 ? kImageNamed(@"bottom_arrow") : kImageNamed(@"right_arrow");
        return contractiveCell;
    }

    if (indexPath.section == 3 && indexPath.row == 10) {

        cell.modifyView.hidden = NO;

        cell.rightLabel.hidden = YES;

    } else {
        cell.modifyView.hidden = YES;

        cell.rightLabel.hidden = NO;
    }

    cell.contentView.hidden = NO;

    if (indexPath.section == 6) {
        return [UITableViewCell new];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 && indexPath.row != 0 && !selectCell4) {
        return 0.001f;
    }
    if (indexPath.section == 6) {

        return 0;
    }

    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.section == 3 && indexPath.row == 0) {
        selectCell4 = !selectCell4;
    }
    if (indexPath.section == 5 && indexPath.row == 0) {
        selectCell6 = !selectCell6;
    }

    if ((indexPath.section == 3 && indexPath.row == 0)) {

        [_tableview reloadData];

        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    }

    if (indexPath.section == 5 && indexPath.row == 0) {
        [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:6]
                              atScrollPosition:UITableViewScrollPositionNone
                                      animated:YES];

        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
    }

    NSLog(@"select  %ld -- %ld", indexPath.section, indexPath.row);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section == 6) {

        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];

        XXTextView *textView = [[XXTextView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 40)];
        textView.xx_placeholder = @"请填写备注";
        textView.xx_placeholderColor = kHexColor(@"#DCDCDC");
        textView.xx_placeholderFont = kFont(14);
        textView.font = kFont(16);
        [tempView addSubview:textView];
        [tempView addSubview:[self configCollectionView]];

        return tempView;
    }
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = kRGBColor(240, 240, 240, 1);
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 2 || section == 5) {

        return 0.f;
    }
    if (section == 6) {
        CGFloat collectionViewHeight = selectCell6 ? 300 : 0;

        return collectionViewHeight;
    }
    return 10.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }

    cell.gifLable.hidden = YES;

    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//定义每一个cell的大小

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    return CGSizeMake(115, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        _selectedPhotos = [NSMutableArray array];
        [UIImage openPhotoPickerGetImages:^(NSArray<AlbumsModel *> *imagesModel, NSArray *photos, NSArray *assets) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            [_collectionView reloadData];
        } target:self selectedAssets:_selectedAssets maxCount:9];
    }

      else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
        }
        if ([[asset valueForKey:@"filename"] tz_containsString:@"GIF"]) {
            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (isVideo ) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc]
initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
            imagePickerVc.maxImagesCount = 9;
            imagePickerVc.allowPickingGif = YES;
            imagePickerVc.allowPickingOriginalPhoto = YES;
            imagePickerVc.allowPickingMultipleVideo = YES;
//            imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL
isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
                _selectedAssets = [NSMutableArray arrayWithArray:assets];
//                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                [_collectionView reloadData];
                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
    
    
}
#pragma mark - Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];

    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[ indexPath ]];
    }
        completion:^(BOOL finished) {
            [_collectionView reloadData];
        }];
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl;
            if (alertView.tag == 1) {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
            } else {
                privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            }
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:@"抱歉"
                              message:@"无法跳转到隐私设置页面，请手动前往设置页面，谢谢"
                             delegate:nil
                    cancelButtonTitle:@"确定"
                    otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
    canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
    didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}




@end
