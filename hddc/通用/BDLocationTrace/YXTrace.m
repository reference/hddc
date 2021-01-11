//
//  YXTrace.m
//  BDGuPiao
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXTrace.h"

@implementation YXTrace

+ (id)lastestRecord
{
    NSString* where = [NSString stringWithFormat:@"where %@=%@ order by %@ desc",bg_sqlKey(@"userId"),bg_sqlValue([YXUserModel currentUser].userId),bg_sqlKey(@"createDate")];
    NSArray *arr = [YXTrace bg_find:NSStringFromClass(YXTrace.class) where:where];
    NSLog(@"-------------->>>%@",arr);
    
    for (YXTrace *trace in arr) {
        NSLog(@">>>>>>>>>>>>>>>>>>rowid:%@ 时间：%@",trace.rowid,trace.createDate);
    }
    if (arr) {
        return arr.firstObject;
    }
    return nil;
}

+ (NSArray <YXTrace *> *)findTraceWithoutBelongByUserId:(NSString *)uId
{
    NSString* where = [NSString stringWithFormat:@"where %@=%@"
                       ,bg_sqlKey(@"userId"),bg_sqlValue(uId)];
    return [YXTrace bg_find:NSStringFromClass(YXTrace.class) where:where];
}

/// @param rowId rowid
+ (BOOL)deleteRowById:(NSString *)rowId
{
    return [YXTrace bg_delete:NSStringFromClass(YXTrace.class) where:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"rowid"),bg_sqlValue(rowId)]];
}

+ (YXTracePointModel *)decodeDataInTrace:(YXTrace *)tb
{
    if (tb.pointsData == nil) {
        return nil;
    }
    //decode data
    NSDictionary *decodedData = [NSJSONSerialization JSONObjectWithData:[tb.pointsData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];;
    
    //使用一个模型代替所有，每个模型都不会被强转
    return [YXTracePointModel yy_modelWithDictionary:decodedData];
}

- (NSArray <AGSPoint *> *)toAGSPoints
{
    if (self) {
        NSMutableArray *pointsArr = [NSMutableArray array];
        YXTracePointModel *traceModel = [YXTrace decodeDataInTrace:self];
        NSArray *points = [traceModel.lonlatArray componentsSeparatedByString:@";"];
        for (NSString *point in points) {
            if ([point trim].length == 0) {
                continue;
            }
            NSArray *pts = [point componentsSeparatedByString:@","];
            AGSPoint *p = [[AGSPoint alloc] initWithX:[pts[0] doubleValue] y:[pts[1] doubleValue] spatialReference:[AGSSpatialReference WGS84]];
            [pointsArr addObject:p];
        }
        return pointsArr;
    }return nil;
}
@end
