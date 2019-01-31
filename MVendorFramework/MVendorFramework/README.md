MVendorFramework
=

前言
-

MVendorFramework,主要为第三方库

简介
-


功能
-



修改说明
- FDFullScreenPopGesture
修改者
-       曹金果


针对iOS 9.3及以下系统连续push两个无导航的页面再触发了侧滑返回后导致导航错乱的bug,做了一下修复:
1. 拦截viewDidAppear方法:
2. 重置导航栏:
if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0f) {
    if (![self fd_prefersNavigationBarHidden] && self.navigationController.navigationBar.items.count) {
        if (self.navigationController.navigationBar.topItem != self.navigationItem && self.navigationController.viewControllers.count > 1 ) {
              [self.navigationController setNavigationBarHidden:YES animated:animated];
             [self.navigationController setNavigationBarHidden:NO animated:animated];
             }

    }
}
详见 UINavigationController+FDFullscreenPopGesture --> 121 Line

