//
//  YXForumSaver.h
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXForumSaver : NSObject

+ (void)saveWithBody:(id)body completion:(void(^)(NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
