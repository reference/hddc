//
//  GPHomeTraceCollectionOfflinePopView.h
//  BDGuPiao
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPHomeTraceCollectionOfflinePopView : BDView
@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onStartCollection) (NSString *time,NSString *color);
@end

NS_ASSUME_NONNULL_END
