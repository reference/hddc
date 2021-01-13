//
//  YXFormListModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXFormListModel.h"

@implementation YXFormListModel

+ (void)requestProjectsWithPage:(NSInteger )page
                         userId:(NSString *)userId
                         taskId:(NSString *)tid
                     projectId:(NSString *)pid
                           type:(NSInteger)type
                     completion:(void(^)(NSArray <YXFormListModel *> *ms,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddcAppForminfo/findAppFormData", YX_HOST];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (page>0) {
        [param setInteger:page forKey:@"curPage"];
        [param setInteger:Standard_Page_Size_Default forKey:@"pageSize"];
    }
    [param setObject:userId forKey:@"userId"];
    [param setObject:tid forKey:@"taskId"];
    [param setObject:pid forKey:@"projectId"];
    [param setObject:@(type) forKey:@"type"];
    
    [YXHTTP requestWithURL:url
                    params:param
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":self.class}
           completion:^(id responseObject, NSError *error) {
                StandardHTTPResponse *resp = responseObject;
                if (completion) {
                    completion(resp.data,error);
                }
           }];
}
@end
