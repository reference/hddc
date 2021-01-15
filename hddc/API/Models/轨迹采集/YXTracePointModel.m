//
//  YXTracePointModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXTracePointModel.h"

@implementation YXTracePointModel

+ (void)saveWithBody:(YXTracePointModel *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcCjHistorypointss", YX_HOST];

    body.createUser = [YXUserModel currentUser].userId;
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
@end
