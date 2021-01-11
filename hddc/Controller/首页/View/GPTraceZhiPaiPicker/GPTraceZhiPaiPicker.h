//
//  GPTraceZhiPaiPicker.h
//  BDGuPiao
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPTraceZhiPaiPicker : BDView
@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onSubmit) (YXProject *project,YXTaskModel *task);
@end

NS_ASSUME_NONNULL_END
