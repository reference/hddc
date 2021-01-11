//
//  YXProjectModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXProjectModel.h"
@implementation YXProject
@end

@implementation YXProjectModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows" : [YXProject class]};
}

+ (void)requestProjectsWithPage:(NSInteger )page personId:(NSString *)personId completion:(void(^)(YXProjectModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/queryHddcCjProjectsByPersonId", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"curPage":@(page),@"pageSize":@(Standard_Page_Size_Default),@"personId":personId}
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

+ (void)requestAllProjectWithPersonId:(NSString *)personId completion:(void(^)(YXProjectModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/queryHddcCjProjectsByPersonId", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"curPage":@(1),@"pageSize":@(1000000),@"personId":personId}
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
