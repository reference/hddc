//
//  YXUserLoginModel.m
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXUserLoginModel.h"

@implementation YXUserLoginBody
@end

@implementation YXUserLoginModel

+ (void)loginWithBody:(YXUserLoginBody *)body completion:(void(^)(YXUserLoginModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/doLogin", YX_HOST];

    [YXHTTP requestWithURL:url
                    params:nil
                      body:[body yy_modelToJSONObject]
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
