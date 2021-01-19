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
//YXForumDataInfoModel or YXTable
@property (nonatomic, strong) NSArray *forumDataInfoModels;
//YXForumDataInfoModel or YXTable
@property (nonatomic, copy) void (^didSelectForum)(id model);
@property (nonatomic, copy) void (^didAddNew)(AGSPoint *point);
@end

NS_ASSUME_NONNULL_END
