
#pragma mark - 该工程里的一些三方库使用  示例


 
 // MARK:  =========  MJRefresh  =========

 self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
 self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
 
 self.tableView.mj_header.automaticallyChangeAlpha = YES;
 
 [self.tableView.mj_header beginRefreshing];
 
 self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

 
 #pragma mark - 关于侧滑返回设置

项目中加入了一个 NAVC的分类  所以  隐藏导航栏用
self.fd_prefersNavigationBarHidden = YES;

设置侧滑范围  默认是全屏
self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 300;

如果想要scrollView（或之类）支持全屏策侧滑返回（scrollView滚动到最左的时候），自定义的scrollView，实现此方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
