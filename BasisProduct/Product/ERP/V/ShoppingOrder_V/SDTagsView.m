//
//  SDTagsView.m
//  SDTagsView
//
//  Created by apple on 2017/2/20.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "SDTagsView.h"



#define SDRectangleTagMaxCoult 3 // 矩阵标签时，最多列数

#define SDtagsView @"SDtagsView"
@interface SDTagsView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>


@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UIView *sdTagsView;
@end
@implementation SDTagsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)sdTagsViewWithTagsArr:(NSArray*)tagsArr{
    SDTagsView *sdTagsView =[[SDTagsView alloc]init];
    sdTagsView.tagsArr =[[NSArray alloc]initWithArray:tagsArr];
    return sdTagsView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUP];
    }
    return self;
}

-(void)setUP{
    
    [self addSubview:self.collectionView];
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 20, kScreenWidth-30, kScreenHeight - 44) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.backgroundColor=[UIColor redColor];
       [_collectionView setBackgroundColor:[UIColor clearColor]];
//        [sdTagsView addSubview:_collectionView];
        //注册
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SDtagsView];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagsArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str1 =self.tagsArr[indexPath.row];
    CGFloat width = [XXHelper widthForLabel:[NSString stringWithFormat:@"%@",str1] fontSize:16];
    return CGSizeMake(width+10,22);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDtagsView forIndexPath:indexPath];
    NSString *str2 =self.tagsArr[indexPath.row];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%@",str2];
    label.frame = CGRectMake(0, 0, ([XXHelper widthForLabel:label.text fontSize:16] + 10), 22);
    label.font = [UIFont systemFontOfSize:16];
    label.layer.cornerRadius = 2.0;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 1.0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kRandomColor;
    label.layer.borderColor = [UIColor greenColor].CGColor;
    [cell.contentView addSubview:label];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"index:%ld",(long)indexPath.row);
}

@end
