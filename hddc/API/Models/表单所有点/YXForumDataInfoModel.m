//
//  YXForumDataInfoModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXForumDataInfoModel.h"

@implementation YXForumDataInfoModel

+ (void)requestUserId:(NSString *)uid completion:(void(^)(NSArray <YXForumDataInfoModel *> *ms,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/hddc/hddcAppForminfo/findAppFormDataInfo", YX_HOST];
    [YXHTTP requestWithURL:url
                    params:@{@"userId":uid}
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
