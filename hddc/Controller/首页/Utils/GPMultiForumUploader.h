//
//  GPMultiForumUploader.h
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  批量表单上传
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPMultiForumUploader : NSObject
@property (nonatomic, strong) YXProject *project;
@property (nonatomic, strong) YXTaskModel *task;
@property (nonatomic, strong) NSArray <YXTable *> *tables;
@property (nonatomic, copy) void (^didStart)(void);
@property (nonatomic, copy) void (^didError)(NSError *error);
@property (nonatomic, copy) void (^didSuccess)(void);

- (void)startUpload;
@end

NS_ASSUME_NONNULL_END
