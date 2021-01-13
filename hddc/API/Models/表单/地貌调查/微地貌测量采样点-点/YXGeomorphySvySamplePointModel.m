//
//  YXGeomorphySvySamplePointModel.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXGeomorphySvySamplePointModel.h"

@implementation YXGeomorphySvySamplePointModel

+ (void)saveWithBody:(YXGeomorphySvySamplePointModel *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcWyGeomorphysvyreprofs", YX_HOST];

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

+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeomorphySvySamplePointModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorphysvyreprofs/%@", YX_HOST,uuid];

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
