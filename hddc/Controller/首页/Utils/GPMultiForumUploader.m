//
//  GPMultiForumUploader.m
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//
#import "GPMultiForumUploader.h"
#import "GPImageEntity.h"

@interface GPMultiForumUploader()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation GPMultiForumUploader

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
    [self.dataArray setArray:self.tables];
    [self innerUpload];
    
    if (self.didStart) {
        self.didStart();
    }
}

- (void)innerUpload
{
    if (self.dataArray.count) {
        //取出第一条
        YXTable *table = self.dataArray.lastObject;
        
        NSLog(@"table:%@",table);
        [self uploadForum:table];
    }else{
        if (self.didSuccess) {
            self.didSuccess();
        }
    }
}

- (void)uploadForum:(YXTable *)table
{
    id model = [YXTable decodeDataInTable:table];
    
    //
    NSMutableDictionary *mInfo = [NSMutableDictionary dictionary];
    [mInfo setDictionary:[model yy_modelToJSONObject]];
    
    //check whether has images
    NSArray *images = nil;
    NSString *extends7 = mInfo[@"extends7"];
    if (extends7.length > 0) {
        images = [extends7 componentsSeparatedByString:@","];
    }
    //
    [mInfo setObject:self.task.taskId forKey:@"taskId"];
    [mInfo setObject:self.project.projectId forKey:@"projectId"];

    //submit
    void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
        if (imgUrls.length) {
            //
            if (imgUrls.length) {
                [mInfo setObject:imgUrls forKey:@"extends7"];
            }
        }
        
        [YXForumSaver saveWithBody:model completion:^(NSError * _Nonnull error) {
            if (error) {
                if (self.didError) {
                    self.didError(error);
                }
            }else{
                //删除本地数据
                [YXTable deleteRowById:table.rowid];
                
                //删除图片
                for (NSString *localPath in images) {
                    NSString *filePath = [NSFileManager documentFile:localPath];
                    [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:filePath] error:nil];
                }
                
                [self.dataArray removeLastObject];
                
                [self innerUpload];
            }
        }];
    };
        
    //do upload
    if (images && images.count) {
        //upload images first if it has photos
        [YXUpdateImagesModel uploadImageWithType:table.type
                                  localImageUrls:images
                                      completion:^(NSString * _Nonnull urls, NSError * _Nonnull error) {
            if (error) {
                if (self.didError) {
                    self.didError(error);
                }
            }else{
                submitRequest(urls);
            }
        }];
    } else {
        submitRequest(nil);
    }
}

@end
