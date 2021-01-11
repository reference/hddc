//
//  YXUserLoginModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXUserLoginBody : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *appCode;
@end

@interface YXUserLoginModel : NSObject
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *token;

+ (void)loginWithBody:(YXUserLoginBody *)body completion:(void(^)(YXUserLoginModel *m,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
