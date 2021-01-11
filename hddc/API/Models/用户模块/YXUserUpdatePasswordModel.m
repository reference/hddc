//
//  YXUserUpdatePasswordModel.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXUserUpdatePasswordModel.h"


@implementation YXUpdatePasswordBody
@end

@implementation YXUserUpdatePasswordModel

+ (void)updatePasswordWithBody:(YXUpdatePasswordBody *)body completion:(void(^)(NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/updatePwd", YX_HOST];

    NSDictionary *param = @{@"userId":body.userId,@"oldPwd":body.oldPwd,@"newPwd":body.myNewPwd};
    [YXHTTP requestWithURL:url
                    params:nil
                      body:[param yy_modelToJSONObject]
             responseClass:StandardHTTPResponse.class
         responseDataClass:nil
           completion:^(id responseObject, NSError *error) {
                if (completion) {
                    completion(error);
                }
           }];
}
@end
