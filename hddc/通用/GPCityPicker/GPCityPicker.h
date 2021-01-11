//
//  GPCityPicker.h
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>
#import "GPAdministrativeDivisionsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPCityPicker : BDView
@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onDone) (GPAdministrativeDivisionsModel *model);

/// Pop up from bottom
/// @param vc viewcontroller
/// @param rootId nil 根 else 子
+ (id)popUpInController:(BDBaseViewController *)vc rootId:(NSString *)rootId;
@end

NS_ASSUME_NONNULL_END
