//
//  YXSlectionDictModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXSlectionDictModel.h"
#import <FMDB.h>

@implementation YXSlectionDictModel

+ (void)requestDictWithType:(FormType)type code:(NSString *)code completion:(void(^)(NSArray <YXSlectionDictModel *> *ms,NSError *error))completion
{
    NSString *path = nil;
    switch (type) {
        case FormType_FaultSvyPoint:
            path = @"hddcWyFaultsvypoints";
            break;
        case FormType_GeoGeomorphySvyPoint:
            path = @"hddcWyGeogeomorphysvypoints";
            break;
        case FormType_GeologicalSvyPoint:
            path = @"hddcWyGeologicalsvypoints";
            break;
        case FormType_StratigraphySvyPoint:
            path = @"hddcWyStratigraphysvypoints";
            break;
        case FormType_Trench:
            path = @"hddcWyTrenchs";
            break;
        case FormType_GeomorphySvyLine:
            path = @"hddcWyGeomorphysvylines";
            break;
        case FormType_DrillHole:
            path = @"hddcWyDrillholes";
            break;
        case FormType_SamplePoint:
            path = @"hddcWySamplepoints";
            break;
        case FormType_GeophySvyLine:
            path = @"hddcWyGeophysvylines";
            break;
        case FormType_GeophySvyPoint:
            path = @"hddcWyGeophysvypoints";
            break;
        case FormType_GeochemicalSvyLine:
            path = @"hddcWyGeochemicalsvylines";
            break;
        case FormType_GeochemicalSvyPoint:
            path = @"hddcWyGeochemicalsvypoints";
            break;
        case FormType_Crater:
            path = @"hddcWyCraters";
            break;
        case FormType_Lava:
            path = @"hddcWyLavas";
            break;
        case FormType_VolcanicSamplePoint:
            path = @"hddcWyVolcanicsamplepoints";
            break;
        default:
            break;
    }
//    NSString *url = [NSString stringWithFormat:@"%@/hddc/%@/getValidDictItemsByDictCode/%@", YX_HOST,path,code];
    
//    [YXHTTP requestWithURL:url
//                    params:nil
//                      body:nil
//             responseClass:StandardHTTPResponse.class
//         responseDataClass:@{@"data":self.class}
//           completion:^(id responseObject, NSError *error) {
//                if (completion) {
//                    StandardHTTPResponse *rep = responseObject;
//                    completion(rep.data,error);
//                }
//           }];
    
    [YXSlectionDictModel requestLocalWithCode:code completion:completion];
}

+ (void)requestLocalWithCode:(NSString *)code completion:(void(^)(NSArray <YXSlectionDictModel *> *ms,NSError *error))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"4330d398bfc148e2964492aead40b907" ofType:@"sqlite3"];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:path];
    
    if ([fmdb open]) {
        fmdb.logsErrors = YES;
        //1.query
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM sys_dict_item WHERE dict_id in (SELECT dict_id FROM sys_dict WHERE dict_dir_id='4330d398bfc148e2964492aead40b907' and dict_code='%@')",code];
        FMResultSet *rs = [fmdb executeQuery:query];
        // 2.遍历结果集
        NSMutableArray *arrM = [NSMutableArray array];
        while (rs.next) {
            NSMutableDictionary* dictM = [[NSMutableDictionary alloc] init];
            for (int i=0;i<[[[rs columnNameToIndexMap] allKeys] count];i++) {
                dictM[[rs columnNameForIndex:i]] = [rs objectForColumnIndex:i];
            }
            YXSlectionDictModel *m = [YXSlectionDictModel new];
            m.dictItemCode = dictM[@"dict_item_code"];
            m.dictItemName = dictM[@"dict_item_name"];
            [arrM addObject:m];
        }
        //查询完后要关闭rs，不然会报@"Warning: there is at least one open result set around after performing
        [rs close];
        [fmdb close];
        if (completion) {
            completion(arrM,nil);
        }
    }else{
        NSLog(@"db is not open.");
        if (completion) {
            completion(nil,[NSError errorWithDomain:NSURLErrorDomain code:@"400" userInfo:@{NSLocalizedDescriptionKey:@"内部数据库打开失败"}]);
        }
    }
}


@end
