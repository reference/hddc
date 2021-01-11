//
//  GPForumType.m
//  BDGuPiao
//
//  Created by admin on 2020/12/14.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPForumType.h"

@implementation GPForumType

+ (NSString *)nameOfType:(NSInteger)type
{
    switch (type) {
        case 1:return @"地质调查规划路线-线";
        case 2:return @"地质调查规划点-点";
        case 3:return @"断层观测点-点";
        case 4:return @"地质地貌调查观测点-点";
        case 5:return @"地质调查路线-线";
        case 6:return @"地质调查观测点-点";
        case 7:return @"地层观测点-点";
        case 8:return @"探槽-点";
        case 9:return @"微地貌测量线-线";
        case 10:return @"微地貌测量点-点";
        case 11:return @"微地貌测量面-面";
        case 12:return @"微地貌面测量切线-线";
        case 13:return @"微地貌测量采样点-点";
        case 14:return @"微地貌测量基站点-点";
        case 15:return @"钻孔-点";
        case 16:return @"采样点-点";
        case 17:return @"地球物理测线-线";
        case 18:return @"地球物理测点-点";
        case 19:return @"地球化学探测测线-线";
        case 20:return @"地球化学探测测点-点";
        case 21:return @"火山口-点";
        case 22:return @"熔岩流-面";
        case 23:return @"火山采样点-点";
        case 24:return @"火山调查观测点-点";
    }
    return nil;
}

+ (NSString *)enNameOfType:(NSInteger)type
{
    switch (type) {
        case 1:return @"GeologicalSvyPlanningLine";
        case 2:return @"GeologicalSvyPlanningPt";
        case 3:return @"FaultSvyPoint";
        case 4:return @"GeoGeomorphySvyPoint";
        case 5:return @"GeologicalSvyLine";
        case 6:return @"GeologicalSvyPoint";
        case 7:return @"StratigraphySvyPoint";
        case 8:return @"Trench";
        case 9:return @"GeomorphySvyLine";
        case 10:return @"GeomorphySvyPoint";
        case 11:return @"GeomorphySvyRegion";
        case 12:return @"GeomorphySvyReProf";
        case 13:return @"GeomorphySvySamplePoint";
        case 14:return @"GeomorStation";
        case 15:return @"DrillHole";
        case 16:return @"SamplePoint";
        case 17:return @"GeophySvyLine";
        case 18:return @"GeophySvyPoint";
        case 19:return @"GeochemicalSvyLine";
        case 20:return @"GeochemicalSvyPoint";
        case 21:return @"Crater";
        case 22:return @"Lava";
        case 23:return @"VolcanicSamplePoint";
        case 24:return @"VolcanicSvyPoint";
    }
    return nil;
}

+ (NSInteger)typeOfName:(NSString *)name{
    if (name) {
        if ([name isEqualToString:@"地质调查规划路线-线"]) return 1;
        else if ([name isEqualToString:@"地质调查规划点-点"]) return 2;
        else if ([name isEqualToString:@"断层观测点-点"]) return 3;
        else if ([name isEqualToString:@"地质地貌调查观测点-点"]) return 4;
        else if ([name isEqualToString:@"地质调查路线-线"]) return 5;
        else if ([name isEqualToString:@"地质调查观测点-点"]) return 6;
        else if ([name isEqualToString:@"地层观测点-点"]) return 7;
        else if ([name isEqualToString:@"探槽-点"]) return 8;
        else if ([name isEqualToString:@"微地貌测量线-线"]) return 9;
        else if ([name isEqualToString:@"微地貌测量点-点"]) return 10;
        else if ([name isEqualToString:@"微地貌测量面-面"]) return 11;
        else if ([name isEqualToString:@"微地貌面测量切线-线"]) return 12;
        else if ([name isEqualToString:@"微地貌测量采样点-点"]) return 13;
        else if ([name isEqualToString:@"微地貌测量基站点-点"]) return 14;
        else if ([name isEqualToString:@"钻孔-点"]) return 15;
        else if ([name isEqualToString:@"采样点-点"]) return 16;
        else if ([name isEqualToString:@"地球物理测线-线"]) return 17;
        else if ([name isEqualToString:@"地球物理测点-点"]) return 18;
        else if ([name isEqualToString:@"地球化学探测测线-线"]) return 19;
        else if ([name isEqualToString:@"地球化学探测测点-点"]) return 20;
        else if ([name isEqualToString:@"火山口-点"]) return 21;
        else if ([name isEqualToString:@"熔岩流-面"]) return 22;
        else if ([name isEqualToString:@"火山采样点-点"]) return 23;
        else if ([name isEqualToString:@"火山调查观测点-点"]) return 24;

    }return 0;
}
@end
