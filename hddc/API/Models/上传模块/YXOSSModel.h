//
//  YXOSSModel.h
//  YunXiangAlive
//
//  Created by B-A-N on 2020/7/7.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  对象存储端点
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXOSSModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;
/// 上传图片
/// @param img img
/// @param completion nil
+ (void)uploadImage:(UIImage *)img completion:(void(^)(NSString *url,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
