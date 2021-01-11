//
//  YXUserModel.m
//  YunXiangAlive
//
//  Created by B-A-N on 2020/7/3.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXUserModel.h"
#define kCurrentUserKey   @"kCurrentUserKey"
#define kALL @"kAllUsers"

@implementation YXRegisterBody

@end

@implementation YXUserModel

- (void)save
{
    [YXUserModel addUser:self];
}

- (void)setAsCurrnet
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.userId forKey:kCurrentUserKey];
    [ud synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:BDUserNotificationLogin object:nil];
}

- (void)saveAsCurrent
{
    [self save];
    [self setAsCurrnet];
}

+ (id)currentUser
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *currentUserAccount = [ud objectForKey:kCurrentUserKey];
    if (currentUserAccount && currentUserAccount.length) {
        NSArray *oldUsers = [self retrieve:kALL];
        if (oldUsers) {
            for (YXUserModel *user in oldUsers) {
                if ([user.userId isEqualToString:currentUserAccount]) {
                    return user;
                    break;
                }
            }
        }
    }
    return nil;
}

+ (void)addUser:(YXUserModel *)user
{
    NSMutableArray *newUsers = [NSMutableArray array];
    NSArray *oldUsers = [self retrieve:kALL];
    if (oldUsers) {
        //判断是否存在 存在则删除
        [newUsers addObjectsFromArray:oldUsers];
        
        for (YXUserModel *u in newUsers) {
            if ([u.userId isEqualToString:user.userId]) {
                [newUsers removeObject:u];
                break;
            }
        }
    }
    [newUsers addObject:user];
    [self persist:newUsers key:kALL];
}

+ (void)updateUser:(YXUserModel *)user
{
    [user save];
}

+ (void)removeCurrentUser
{
    [self removeUser:[YXUserModel currentUser]];
    //
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:kCurrentUserKey];
    [ud synchronize];
}

+ (void)removeUser:(YXUserModel *)user
{
    NSMutableArray *newUsers = [NSMutableArray array];
    NSArray *oldUsers = [self retrieve:kALL];
    if (oldUsers) {
        //判断是否存在 存在则删除
        [newUsers addObjectsFromArray:oldUsers];
        
        for (YXUserModel *u in newUsers) {
            if ([u.userId isEqualToString:user.userId]) {
                [newUsers removeObject:u];
                break;
            }
        }
    }
    
    [self persist:newUsers key:kALL];
}

+ (BOOL)isLogin
{
    YXUserModel *user = [self currentUser];
    return user && user.userId.length > 0;
}

+ (void)logout
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:kCurrentUserKey];
    [ud synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:BDUserNotificationLogout object:nil];
}

+ (NSArray *)allUsers
{
    return [self retrieve:kALL];
}

+ (NSArray *)usersWithoutCurrent
{
    YXUserModel *cUser = [YXUserModel currentUser];
    NSMutableArray *newUsers = [NSMutableArray array];
    NSArray *oldUsers = [self retrieve:kALL];
    if (oldUsers) {
        //判断是否存在 存在则删除
        [newUsers addObjectsFromArray:oldUsers];
        
        for (YXUserModel *user in newUsers) {
            if ([user.userId isEqualToString:cUser.userId]) {
                [newUsers removeObject:user];
                break;
            }
        }
    }
    
    return newUsers;
}

+ (void)registerWithBody:(YXRegisterBody *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/register", YX_HOST];

    [YXHTTP requestWithURL:url
                    params:nil
                      body:[body yy_modelToJSONObject]
             responseClass:StandardHTTPResponse.class
         responseDataClass:nil
           completion:^(id responseObject, NSError *error) {
               if (completion) {
                   completion(error);
               }
           }];
}

+ (void)getUserInfoById:(NSString *)userId completion:(void(^)(YXUserModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/userInfo", YX_HOST];

    [YXHTTP requestWithURL:url
                    params:@{@"userId":userId}
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":self.class}
           completion:^(id responseObject, NSError *error) {
                    StandardHTTPResponse *resp = responseObject;
                    if (completion) {
                        completion(resp.data,error);
                    }
           }];
}
@end
