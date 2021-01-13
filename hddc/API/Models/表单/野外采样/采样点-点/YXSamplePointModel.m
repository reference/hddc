//
//  YXSamplePointModel.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXSamplePointModel.h"

@implementation YXSamplePointModel

+ (void)saveWithBody:(YXSamplePointModel *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcWySamplepoints", YX_HOST];

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

+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXSamplePointModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWySamplepoints/%@", YX_HOST,uuid];

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
