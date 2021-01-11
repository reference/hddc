//
//  GPHomeMapCalloutView.h
//  BDGuPiao
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPHomeMapCalloutView : BDView
@property (nonatomic, strong) NSArray <YXForumDataInfoModel *> *forumDataInfoModels;
@property (nonatomic, copy) void (^didSelectForum)(YXForumDataInfoModel *forumInfoModel);
@property (nonatomic, copy) void (^didAddNew)(AGSPoint *point);
@end

NS_ASSUME_NONNULL_END
