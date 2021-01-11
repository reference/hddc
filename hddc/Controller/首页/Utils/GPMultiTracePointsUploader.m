//
//  GPMultiTracePointsUploader.m
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPMultiTracePointsUploader.h"

@interface GPMultiTracePointsUploader()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation GPMultiTracePointsUploader

- (id)init
{
    if (self = [super init]) {
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)startUpload
{
    //
    [self.dataArray setArray:self.traces];
    [self innerUpload];
    
    if (self.didStart) {
        self.didStart();
    }
}

- (void)innerUpload
{
    if (self.dataArray.count) {
        //取出第一条
        YXTrace *trace = self.dataArray.lastObject;
        
        NSLog(@"table:%@",trace);
        [self uploadTrace:trace];
    }else{
        if (self.didSuccess) {
            self.didSuccess();
        }
    }
}

- (void)uploadTrace:(YXTrace *)trace
{
    YXTracePointModel *model = [YXTrace decodeDataInTrace:trace];
    
    model.taskId = self.taskId;
    model.userId = [YXUserModel currentUser].userId;
    
    [YXTracePointModel saveWithBody:model completion:^(NSError * _Nonnull error) {
        if (error) {
            if (self.didError) {
                self.didError(error);
            }
        }else{
            //删除本地数据
            [YXTrace deleteRowById:trace.rowid];
            
            //
            [self.dataArray removeLastObject];
            
            //
            [self innerUpload];
        }
    }];
}
@end
