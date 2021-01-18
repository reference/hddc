//
//  YXTaskModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXTaskModel.h"
#import "YXHTTP.h"

@implementation YXTaskModel

+ (void)newTaskWithBody:(YXTaskModel *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app", YX_HOST];

    [YXHTTP requestWithURL:url
                    params:nil
                      body:[body yy_modelToJSONObject]
             responseClass:StandardHTTPResponse.class
         responseDataClass:nil
           completion:^(id responseObject, NSError *error) {
                if (completion) {
                    completion(error);
                }
           }];
}

+ (void)updateTaskWithBody:(YXTaskModel *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app", YX_HOST];

    [YXHTTP putWithURL:url
                    params:nil
                      body:[body yy_modelToJSONObject]
             responseClass:StandardHTTPResponse.class
         responseDataClass:nil
           completion:^(id responseObject, NSError *error) {
                if (completion) {
                    completion(error);
                }
           }];
}
@end

@implementation YXTaskApiModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows" : [YXTaskModel class]};
}

+ (void)requestTasksWithPage:(NSInteger )page projectId:(NSString *)projectId completion:(void(^)(YXTaskApiModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/queryHddcCjTasksByProjectId", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"curPage":@(page),@"pageSize":@(Standard_Page_Size_Default),@"projectId":projectId}
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

+ (void)requestAllTasksWithProjectId:(NSString *)projectId completion:(void(^)(YXTaskApiModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/queryHddcCjTasksByProjectId", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"curPage":@(1),@"pageSize":@(1000000),@"projectId":projectId}
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

+ (void)requestTaskCodeByProjectId:(NSString *)pid completion:(void(^)(NSString *code,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/taskCode/%@", YX_HOST,[pid stringByAddingURLQueryPercentAllowedCharacterSet]];
    [YXHTTP requestWithURL:url
                    params:nil
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":NSString.class}
           completion:^(id responseObject, NSError *error) {
                StandardHTTPResponse *resp = responseObject;
                if (completion) {
                    completion(resp.data,error);
                }
           }];
}
@end
