//
//  ViewController.h
//  demo
/*if (self.returnArrBlock) {
 
 self.returnArrBlock(_menuNewArr);
 
 
 }*/
//  Created by zhong on 17/1/16.
//  Copyright © 2017年 Xz Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnArrBlock)(NSMutableArray * newMenuArr);

@interface AddMenuViewController : RootViewController


///  首页功能列表 
@property (nonatomic ,strong) NSMutableArray *menuNewArr;
///   传回应用 model
@property (nonatomic ,copy) ReturnArrBlock returnArrBlock;



@end

