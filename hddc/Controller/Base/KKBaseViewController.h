/**
 **@brief 基类
 **@copyright kubo.com 2019/04
 **/
#import <UIKit/UIKit.h>
#import "BDBaseViewController.h"
@interface KKBaseViewController : BDBaseViewController
/**
 * 导航标题 title  字体设置默认为黑色 需要自行修改
 */
- (void)showNoDataView;
- (void)hideNoDataView;

- (void)setBackButtonBlack;
- (void)setBackButtonWhite;

- (void)setThemeNavigation;
@end
