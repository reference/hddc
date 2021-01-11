//
//  GPHomeOfflinePicker.h
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPHomeOfflinePicker : BDView
@property (nonatomic, copy) void (^onCancel) (void);

///返回
@property (nonatomic, copy) void (^onDone) (NSString *forumType);
@end

NS_ASSUME_NONNULL_END
