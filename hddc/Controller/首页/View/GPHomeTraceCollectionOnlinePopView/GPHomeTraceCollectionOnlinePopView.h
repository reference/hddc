//
//  GPHomeTraceCollectionOnlinePopView.h
//  BDGuPiao
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPHomeTraceCollectionOnlinePopView : BDView
@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onStartCollection) (YXProject *project,YXTaskModel *task,NSString *time,NSString *color);
@end

NS_ASSUME_NONNULL_END
