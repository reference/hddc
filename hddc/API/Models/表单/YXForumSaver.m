//
//  YXForumSaver.m
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "YXForumSaver.h"

@implementation YXForumSaver

+ (void)saveWithBody:(id)body completion:(void(^)(NSError *error))completion
{
    NSString *url = nil;
    
    if ([body isKindOfClass:YXGeologicalSvyPlanningLineModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeologicalsvyplanninglines", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeologicalSvyPlanningPtModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeologicalsvyplanningpts", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeomorphySvyLineModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorphysvylines", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeomorphySvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorphysvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeomorphySvyRegionModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorphysvyregions", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeomorphySvyReProfModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorphysvyreprofs", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeomorphySvySamplePointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorphysvysamplepoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeomorStationModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeomorstations", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeochemicalSvyLineModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeochemicalsvylines", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeochemicalSvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeochemicalsvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeophySvyLineModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeophysvylines", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeophySvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeophysvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXStratigraphySvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyStratigraphysvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeoGeomorphySvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeogeomorphysvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeologicalSvyLineModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeologicalsvylines", YX_HOST];
    }
    else if ([body isKindOfClass:YXGeologicalSvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyGeologicalsvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXFaultSvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyFaultsvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXTrenchModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyTrenchs", YX_HOST];
    }
    else if ([body isKindOfClass:YXVolcanicSvyPointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyVolcanicsvypoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXVolcanicSamplePointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyVolcanicsamplepoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXCraterModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyCraters", YX_HOST];
    }
    else if ([body isKindOfClass:YXLavaModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyLavas", YX_HOST];
    }
    else if ([body isKindOfClass:YXSamplePointModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWySamplepoints", YX_HOST];
    }
    else if ([body isKindOfClass:YXDrillHoleModel.class]) {
        url = [NSString stringWithFormat:@"%@/hddcAppForminfo/hddcWyDrillholes", YX_HOST];
    }
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
