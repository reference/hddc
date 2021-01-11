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
    
    //check whether has images
    NSArray *images = nil;//
    
    if ([model isKindOfClass:YXGeologicalSvyPlanningLineModel.class]) {
        YXGeologicalSvyPlanningLineModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeologicalSvyPlanningPtModel.class]) {
        YXGeologicalSvyPlanningPtModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeomorphySvyLineModel.class]) {
        YXGeomorphySvyLineModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeomorphySvyPointModel.class]) {
        YXGeomorphySvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeomorphySvyRegionModel.class]) {
        YXGeomorphySvyRegionModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeomorphySvyReProfModel.class]) {
        YXGeomorphySvyReProfModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeomorphySvySamplePointModel.class]) {
        YXGeomorphySvySamplePointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeomorStationModel.class]) {
        YXGeomorStationModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeochemicalSvyLineModel.class]) {
        YXGeochemicalSvyLineModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeochemicalSvyPointModel.class]) {
        YXGeochemicalSvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeophySvyLineModel.class]) {
        YXGeophySvyLineModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeophySvyPointModel.class]) {
        YXGeophySvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXStratigraphySvyPointModel.class]) {
        YXStratigraphySvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeoGeomorphySvyPointModel.class]) {
        YXGeoGeomorphySvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeologicalSvyLineModel.class]) {
        YXGeologicalSvyLineModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXGeologicalSvyPointModel.class]) {
        YXGeologicalSvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXFaultSvyPointModel.class]) {
        YXFaultSvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXTrenchModel.class]) {
        YXTrenchModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXVolcanicSvyPointModel.class]) {
        YXVolcanicSvyPointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXVolcanicSamplePointModel.class]) {
        YXVolcanicSamplePointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXCraterModel.class]) {
        YXCraterModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXLavaModel.class]) {
        YXLavaModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXSamplePointModel.class]) {
        YXSamplePointModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    else if ([model isKindOfClass:YXDrillHoleModel.class]) {
        YXDrillHoleModel *m = model;
        images = [m.extends7 componentsSeparatedByString:@","];
        m.taskId = self.task.taskId;
        m.projectId = self.project.projectId;
    }
    
    
    
    //prepare
    //submit
    void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
        if (imgUrls.length) {
            if ([model isKindOfClass:YXGeologicalSvyPlanningLineModel.class]) {
                YXGeologicalSvyPlanningLineModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeologicalSvyPlanningPtModel.class]) {
                YXGeologicalSvyPlanningPtModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeomorphySvyLineModel.class]) {
                YXGeomorphySvyLineModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeomorphySvyPointModel.class]) {
                YXGeomorphySvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeomorphySvyRegionModel.class]) {
                YXGeomorphySvyRegionModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeomorphySvyReProfModel.class]) {
                YXGeomorphySvyReProfModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeomorphySvySamplePointModel.class]) {
                YXGeomorphySvySamplePointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeomorStationModel.class]) {
                YXGeomorStationModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeochemicalSvyLineModel.class]) {
                YXGeochemicalSvyLineModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeochemicalSvyPointModel.class]) {
                YXGeochemicalSvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeophySvyLineModel.class]) {
                YXGeophySvyLineModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeophySvyPointModel.class]) {
                YXGeophySvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXStratigraphySvyPointModel.class]) {
                YXStratigraphySvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeoGeomorphySvyPointModel.class]) {
                YXGeoGeomorphySvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeologicalSvyLineModel.class]) {
                YXGeologicalSvyLineModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXGeologicalSvyPointModel.class]) {
                YXGeologicalSvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXFaultSvyPointModel.class]) {
                YXFaultSvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXTrenchModel.class]) {
                YXTrenchModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXVolcanicSvyPointModel.class]) {
                YXVolcanicSvyPointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXVolcanicSamplePointModel.class]) {
                YXVolcanicSamplePointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXCraterModel.class]) {
                YXCraterModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXLavaModel.class]) {
                YXLavaModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXSamplePointModel.class]) {
                YXSamplePointModel *m = model;
                m.extends7 = imgUrls;
            }
            else if ([model isKindOfClass:YXDrillHoleModel.class]) {
                YXDrillHoleModel *m = model;
                m.extends7 = imgUrls;
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
