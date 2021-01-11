//
//  YXUserUpdatePasswordModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXUpdatePasswordBody : NSObject
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *oldPwd;
@property (nonatomic, strong) NSString *myNewPwd;
@end

@interface YXUserUpdatePasswordModel : NSObject

+ (void)updatePasswordWithBody:(YXUpdatePasswordBody *)body completion:(void(^)(NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
