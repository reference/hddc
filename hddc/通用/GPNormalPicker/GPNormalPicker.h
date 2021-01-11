//
//  GPNormalPicker.h
//  BDGuPiao
//
//  Created by admin on 2020/11/30.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>
#import "YXSlectionDictModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPNormalPicker : BDView
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) KKBaseViewController *viewController;
@property (nonatomic, copy) void (^onCancel) (void);

/// data 类型根据传入的dataArray决定
@property (nonatomic, copy) void (^onDone) (id data);

/// Pop up from bottom
/// @param vc viewcontroller
+ (id)popUpInController:(BDBaseViewController *)vc dataArray:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
