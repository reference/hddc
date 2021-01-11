//
//  ABHTTP.h
//  ActBers
//
//  Created by https://github.com/reference on 2019/6/18.
//  Copyright © 2019 com.kubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXAPI.h"
#import "GPImageEntity.h"

@interface YXHTTP : NSObject
+ (void)requestWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
         responseClass:(Class)responseClass
     responseDataClass:(NSDictionary *)responseDataClass
            completion:(void(^)(id responseObject, NSError *error))completion;

+ (void)putWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
         responseClass:(Class)responseClass
     responseDataClass:(NSDictionary *)responseDataClass
            completion:(void(^)(id responseObject, NSError *error))completion;

+ (void)requestWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
            completion:(void(^)(id responseObject, NSError *error))completion;


+ (void)putWithURL:(NSString *)url
                params:(NSDictionary *)params
                  body:(id)body
            completion:(void(^)(id responseObject, NSError *error))completion;

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
                 data:(NSArray<ZXHTTPFormData *> *)data
        responseClass:(Class)responseClass
           completion:(void(^)(id responseObject, NSError *error))completion;

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
                 data:(NSArray<ZXHTTPFormData *> *)data
        responseClass:(Class)responseClass
    responseDataClass:(NSDictionary *)responseDataClass
             progress:(void(^)(NSProgress *progress))progressCallback
           completion:(void(^)(id responseObject, NSError *error))completion;

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
        withFilePaths:(NSArray <GPImageEntity *> *)imgArr
        responseClass:(Class)responseClass
    responseDataClass:(NSDictionary *)responseDataClass
             progress:(void(^)(NSProgress *progress))progressCallback
           completion:(void(^)(id responseObject, NSError *error))completion;

+ (void)uploadWithURL:(NSString *)url
               params:(NSDictionary *)params
           localPaths:(NSArray *)imgArr
             progress:(void(^)(NSProgress *progress))progressCallback
           completion:(void(^)(id responseObject, NSError *error))completion;
@end
