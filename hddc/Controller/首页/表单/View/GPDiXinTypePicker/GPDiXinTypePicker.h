//
//  GPDiXinTypePicker.h
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPDiXinTypePicker : BDView
@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onDone) (NSString *type);

/// Pop up from bottom
/// @param vc viewcontroller
+ (id)popUpInController:(BDBaseViewController *)vc;
@end

NS_ASSUME_NONNULL_END
