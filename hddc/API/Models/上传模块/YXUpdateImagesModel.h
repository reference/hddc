//
//  YXUpdateImagesModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPImageEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXUpdateImagesModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;
/// 上传图片
/// @param img img
/// @param completion nil
+ (void)uploadImage:(UIImage *)img type:(NSString *)type completion:(void(^)(NSString *url,NSError *error))completion;

/// 上传图片
+ (void)uploadImageWithType:(NSInteger)type images:(NSArray <GPImageEntity *>*)paths completion:(void(^)(NSString *url,NSError *error))completion;

/// 从本地路径上传图片
/// @param type 类型1-24
/// @param paths 本地路径图片
/// @param completion nil
+ (void)uploadImageWithType:(NSInteger)type localImageUrls:(NSArray *)paths completion:(void(^)(NSString *url,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
