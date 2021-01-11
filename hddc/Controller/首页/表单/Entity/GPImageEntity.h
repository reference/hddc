//
//  GPImageEntity.h
//  BDGuPiao
//
//  Created by admin on 2020/11/30.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  任务中10个图片的试题类型
#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPImageEntity : BDModel
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *localPath; //本地缓存路径 用于离线 实际是文件 .png格式
@end

NS_ASSUME_NONNULL_END
