//
//  YXUpdateImagesModel.m
//  BDGuPiao
//
//  Created by admin on 2020/12/23.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXUpdateImagesModel.h"

@implementation YXUpdateImagesModel
+ (void)uploadImage:(UIImage *)img type:(NSString *)type completion:(void(^)(NSString *url,NSError *error))completion
{
    NSString *url = [YX_HOST stringByAppendingString:@"/hddc/hddcWyGeologicalsvyplanninglines/uploadimags"];
    ZXHTTPFormData *data = [[ZXHTTPFormData alloc] initWithData:[img compressToData:1024 * 1024]
                                                           name:@"file"
                                                       fileName:@"avatar.png"
                                                       mimeType:@"image/png"];
    [YXHTTP uploadWithURL:url
                   params:@{@"type":type}
                     data:@[data]
            responseClass:StandardHTTPResponse.class
        responseDataClass:@{@"data":NSString.class}
                 progress:nil
               completion:^(id responseObject, NSError *error) {
                   if (completion) {
                       StandardHTTPResponse *response = responseObject;
                       completion(response.data, error);
                   }
               }];
}

+ (void)uploadImageWithType:(NSInteger)type images:(NSArray <GPImageEntity *>*)paths completion:(void(^)(NSString *url,NSError *error))completion
{
    NSString *url = [YX_HOST stringByAppendingString:@"/hddc/hddcWyGeologicalsvyplanninglines/uploadimags"];
    [YXHTTP uploadWithURL:url
                   params:@{@"type":@(type)}
            withFilePaths:paths
            responseClass:StandardHTTPResponse.class
        responseDataClass:@{@"data":NSString.class}
                 progress:nil
               completion:^(id responseObject, NSError *error) {
                   if (completion) {
                       StandardHTTPResponse *response = responseObject;
                       completion(response.data, error);
                   }
               }];
}

+ (void)uploadImageWithType:(NSInteger)type localImageUrls:(NSArray *)paths completion:(void(^)(NSString *url,NSError *error))completion
{
    NSString *url = [YX_HOST stringByAppendingString:@"/hddc/hddcWyGeologicalsvyplanninglines/uploadimags"];
    [YXHTTP uploadWithURL:url
                   params:@{@"type":@(type)}
               localPaths:paths
                 progress:nil
               completion:^(id responseObject, NSError *error) {
        if (completion) {
            StandardHTTPResponse *response = responseObject;
            completion(response.data, error);
        }
    }];
}
@end
