//
//  YXGeologicalSvyPlanningLineModel.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXGeologicalSvyPlanningLineModel.h"

@implementation YXGeologicalSvyPlanningLineModel

+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeologicalSvyPlanningLineModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcWyGeologicalsvyplanninglines/%@", YX_HOST,uuid];

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
