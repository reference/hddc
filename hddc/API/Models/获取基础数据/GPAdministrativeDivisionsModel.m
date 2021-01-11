/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "GPAdministrativeDivisionsModel.h"
#import <FMDB.h>

@implementation GPAdministrativeDivisionsModel

+ (void)requestADWithId:(NSString *)ids completion:(void(^)(NSArray <GPAdministrativeDivisionsModel *> *ms,NSError *error))completion
{
//    NSString *url = [NSString stringWithFormat:@"%@/app/divisions/%@/subdivisions", YX_HOST,ids?ids:@"root"];
//    [YXHTTP requestWithURL:url
//                    params:nil
//                      body:nil
//             responseClass:StandardHTTPResponse.class
//         responseDataClass:@{@"data":self.class}
//           completion:^(id responseObject, NSError *error) {
//                StandardHTTPResponse *resp = responseObject;
//                if (completion) {
//                    completion(resp.data,error);
//                }
//           }];
    
    [GPAdministrativeDivisionsModel requestWithParentId:ids completion:completion];
}

+ (void)requestWithParentId:(NSString *)parentId completion:(void(^)(NSArray <GPAdministrativeDivisionsModel *> *ms,NSError *error))completion
{
    /*
     --查询省
     --SELECT * from org_division WHERE parent_id='root' ORDER BY create_time ASC;

     --20c49eb015cf48e9a45eee413578e62f
     --SELECT * FROM org_division;
     --查询市
     --SELECT * from org_division WHERE parent_id='20c49eb015cf48e9a45eee413578e62f';

     --13afafd6a30f4169a11a6ef8174b6581
     --查询区
     --SELECT * from org_division WHERE parent_id='13afafd6a30f4169a11a6ef8174b6581';
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"4330d398bfc148e2964492aead40b907" ofType:@"sqlite3"];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:path];
    
    if ([fmdb open]) {
        fmdb.logsErrors = YES;
        //1.query
        NSString *query = [NSString stringWithFormat:@"SELECT * from org_division WHERE parent_id='%@' ORDER BY create_time ASC",parentId == nil ? @"root" : parentId];
        FMResultSet *rs = [fmdb executeQuery:query];
        // 2.遍历结果集
        NSMutableArray *arrM = [NSMutableArray array];
        while (rs.next) {
            NSMutableDictionary* dictM = [[NSMutableDictionary alloc] init];
            for (int i=0;i<[[[rs columnNameToIndexMap] allKeys] count];i++) {
                dictM[[rs columnNameForIndex:i]] = [rs objectForColumnIndex:i];
            }
            GPAdministrativeDivisionsModel *m = [GPAdministrativeDivisionsModel new];
            m.divisionCode = dictM[@"division_code"];
            m.divisionName = dictM[@"division_name"];
            m.divisionId = dictM[@"division_id"];
            m.parentId = dictM[@"parent_id"];
            m.divisionType = @"";
            //单独处理4个直辖市
            if ([m.divisionName isEqualToString:@"北京市"] || [m.divisionName isEqualToString:@"上海市"]
                || [m.divisionName isEqualToString:@"天津市"] || [m.divisionName isEqualToString:@"重庆市"]) {
                m.divisionType = @"Municipality";
            }
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
