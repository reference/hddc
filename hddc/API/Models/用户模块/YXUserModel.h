//
//  YXUserModel.h
//  YunXiangAlive
//
//  Created by B-A-N on 2020/7/3.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  用户 信息
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface YXRegisterBody : NSObject
//用户等级
@property (nonatomic, strong) NSString *userLevel;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *mobilePhone;
@property (nonatomic, strong) NSString *relName;
//身份证号
@property (nonatomic, strong) NSString *idNumber;
//所属单位
@property (nonatomic, strong) NSString *unit;
//行政区划（ID）
@property (nonatomic, strong) NSString *division;

@end


@interface YXUserModel : NSObject
@property (nonatomic, strong) NSString *division;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *relName;
@property (nonatomic, strong) NSString *mobilePhone;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userLevel;

- (void)save;

- (void)setAsCurrnet;

- (void)saveAsCurrent;

+ (YXUserModel *)currentUser;

+ (void)addUser:(YXUserModel *)user;

+ (void)removeUser:(YXUserModel *)user;

+ (void)removeCurrentUser;

+ (void)updateUser:(YXUserModel *)user;

+ (BOOL)isLogin;

+ (void)logout;

+ (NSArray *)allUsers;

+ (NSArray *)usersWithoutCurrent;

/// 用户注册
/// @param body body
/// @param completion nil
+ (void)registerWithBody:(YXRegisterBody *)body completion:(void(^)(NSError *error))completion;

/// 获取用户信息
/// @param userId userid
/// @param completion nil
+ (void)getUserInfoById:(NSString *)userId completion:(void(^)(YXUserModel *m,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
