//
//  AFOOPMainController.h
//  AFOOnlinePlay
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 在线播放入口（作为 Tab 子模块提供 returnController）。
@interface AFOOPMainController : UIViewController

/// 供宿主 TabBar 组装调用，返回一个用于展示的根控制器（通常为 UINavigationController）。
- (UIViewController *)returnController;

@end

NS_ASSUME_NONNULL_END

