//
//  GPForumJumper.h
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPForumJumper : NSObject

/// 跳转到表单采集界面
/// @param type 1-24
/// @param vc vc
/// @param taskModel task
/// @param projectModel project
/// @param mapPoint point
+ (void)jumpToForumWithType:(NSString *)type
         fromViewController:(KKBaseViewController *)vc
                  taskModel:(YXTaskModel *)taskModel
               projectModel:(YXProject *)projectModel
                      point:(AGSPoint *)mapPoint
                    address:(NSString *)address
            interfaceStatus:(InterfaceStatus)interfaceStatus
                      forum:(YXFormListModel *)forum
                      table:(YXTable *)table;
@end

NS_ASSUME_NONNULL_END
