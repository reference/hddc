//
//  YXGeophySvyPointModel.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXGeophySvyPointModel.h"

@implementation YXGeophySvyPointModel

+ (void)saveWithBody:(YXGeophySvyPointModel *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcWyGeophysvypoints", YX_HOST];

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

+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeophySvyPointModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeophysvypoints/%@", YX_HOST,uuid];

    [YXHTTP requestWithURL:url
                    params:nil
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":self.class}
           completion:^(id responseObject, NSError *error) {
                if (completion) {
                    StandardHTTPResponse *resp = responseObject;
                    completion(resp.data,error);
                }
           }];
}
@end
