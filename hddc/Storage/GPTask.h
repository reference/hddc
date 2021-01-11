//
//  GPTask.h
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  任务
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPTask : BDModel
@property (nonatomic, strong) NSString *dataInfo;
@property (nonatomic, assign) BOOL hasUploaded;
@end

NS_ASSUME_NONNULL_END
