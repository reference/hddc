//
//  YXAppBannerModel.m
//  YunXiangAlive
//
//  Created by B-A-N on 2020/7/14.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXAppBannerModel.h"
@implementation YXAppBanner
@end

@implementation YXAppBannerModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"records" : [YXAppBanner class]};
}

+ (void)requestBannerWithPosition:(NSInteger)pos completion:(void(^)(YXAppBannerModel *m,NSError *error))completion
{
    NSString *url = [NSString stringWithFormat:@"%@/app/appbanner/list", YX_HOST];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setInteger:pos forKey:@"position"];

    [YXHTTP requestWithURL:url
                    params:param
                      body:nil
             responseClass:StandardHTTPResponse.class
         responseDataClass:@{@"data":self.class}
                completion:^(id responseObject, NSError *error)
    {
        StandardHTTPResponse *resp = responseObject;
        if (completion) {
            completion(resp.data,error);
        }
    }];
}
@end
