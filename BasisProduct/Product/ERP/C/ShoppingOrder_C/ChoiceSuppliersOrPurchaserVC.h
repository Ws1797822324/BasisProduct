//
//  ChoiceSuppliersVC.h
//  Product
//
//  Created by Sen wang on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ returnNameblock) (id nameBlock);

@interface ChoiceSuppliersOrPurchaserVC : RootViewController
// ** 返回修选中的人 */
@property (nonatomic ,copy) returnNameblock returnNameblock;
// ** 跳转进来的时候判断是选择供货商 = 100 or 添加采购商  == 200*/
@property (nonatomic ,assign) NSInteger titleType;

@end
