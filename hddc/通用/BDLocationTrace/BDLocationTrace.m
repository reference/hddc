/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "BDLocationTrace.h"
#import <INTULocationManager/INTULocationManager.h>
#import <UserNotifications/UserNotifications.h>
#import "YXTrace.h"

@interface BDLocationTrace()<CLLocationManagerDelegate>
@property (nonatomic) dispatch_source_t badgeTimer;
@property (nonatomic, assign) NSInteger tempTime; //时间点
@end

@implementation BDLocationTrace

- (id)init
{
    if (self = [super init]) {
        _state = PointState_Free;
        _tempTime = 0;
        _mode = PointMode_Foreground;
        _intervalTime = 10;
    }return self;
}

+ (BDLocationTrace *)instance
{
    static dispatch_once_t onceToken;
    static BDLocationTrace *q = nil;
    dispatch_once(&onceToken, ^{
        q = [self new];
    });
    return q;
}

- (void)start
{
    if (_state == PointState_Free) {
        _state = PointState_InUse;
        _mode = PointMode_Foreground;
        
        //新增一条数据
        YXTrace *trace = [YXTrace new];
        trace.userId = self.userId;
        trace.taskId = self.taskId;
        trace.projectId = self.projectId;
        trace.type = [self.forumType integerValue];
        trace.rowid = [NSString randomKey];
        trace.createDate = [NSDate date];
        trace.updateDate = [NSDate date];
        trace.color = self.color;
        [trace bg_saveAsync:^(BOOL isSuccess) {
            if (isSuccess) {
                //start
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self startBgTask];
                });
            }
        }];
    }else if(_state == PointState_Sespend){
        //resume
    }else{
        NSLog(@"Point manger is in use");
        
    }
}

- (void)stop
{
    if (_state == PointState_Sespend || _state == PointState_InUse) {
        //stop
        _state = PointState_Free;
        self.badgeTimer = nil;
    }
}

- (NSArray <AGSPoint*>*)latestPoints
{
    YXTrace *m = [YXTrace lastestRecord];
    NSString *traces = m.pointsData;
    if (m && traces.length) {
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *points = [m.pointsData yy_modelToJSONObject];
        for (NSDictionary *pt in points) {
            AGSPoint *p = [[AGSPoint alloc] initWithX:[pt[@"lon"] doubleValue] y:[pt[@"lat"] doubleValue] spatialReference:[AGSSpatialReference WGS84]];
            [arr addObject:p];
        }
        return arr;
    }
    return nil;
}

#pragma mark - private

//创建点
- (YXTracePointModel *)buildTracePoint
{
    //parse from db
    YXTracePointModel *tracePointModel = [YXTracePointModel new];
    NSString *startDate = [[NSDate date] dateString];
    tracePointModel.startTime = startDate;
    tracePointModel.endTime = startDate;
    tracePointModel.taskId = self.taskId;
    tracePointModel.userId = [YXUserModel currentUser].userId;
    tracePointModel.endTime = startDate;
    return tracePointModel;;
}

#pragma mark - delegate

- (void)enterBackground:(UIApplication *)application
{
    if (_state == PointState_InUse) {
        _mode = PointMode_Background;
        NSLog(@"enter background now");
        [self startTrace];
        [self startBgTask];
    }
}

- (void)enterForekground:(UIApplication *)application
{
    if (_state == PointState_InUse) {
        _mode = PointMode_Foreground;
        NSLog(@"enter foreground now");
    }
}

#pragma mark - location delegate

- (void)startBgTask{
    if (_mode == PointMode_Background) {
        UIApplication *application = [UIApplication sharedApplication];
        __block UIBackgroundTaskIdentifier bgTask;
        bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
            //这里延迟的系统时间结束
            [application endBackgroundTask:bgTask];
            NSLog(@"%f",application.backgroundTimeRemaining);
        }];
    }
    else{
        //forgrand
        [self startTrace];
    }
}

- (void)startTrace{
    if (_state == PointState_InUse) {
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        _badgeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_badgeTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_badgeTimer, ^{
            self->_tempTime++;
            
            if (self->_tempTime == self.intervalTime) {
                self->_tempTime = 0;
                
//                [UIApplication sharedApplication].applicationIconBadgeNumber++;
                
                //get location point
                [[INTULocationManager sharedInstance] setBackgroundLocationUpdate:YES];
                [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock timeout:self.intervalTime delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                    NSLog(@"status : %li",(long)status);
                    NSLog(@"坐标，经度：%f,纬度:%f",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude);
                    
                    //save to db
                    if (self->_state == PointState_InUse) {
                        YXTrace *m = [YXTrace lastestRecord];
                        NSDate *now = [NSDate date];
                        m.updateDate = now;
                        
                        //
                        NSMutableString *pointsString = [NSMutableString string];
                        
                        //parse from db
                        YXTracePointModel *tracePointModel = [YXTrace decodeDataInTrace:m];
                        if (tracePointModel) {
                            tracePointModel.endTime = [now dateTimeString];
                            
                            [pointsString setString:tracePointModel.lonlatArray];
                            
                        }else{
                            tracePointModel = [YXTracePointModel new];
                            tracePointModel.startTime = [now dateTimeString];
                            tracePointModel.endTime = [now dateTimeString];
                        }
                        // set task id
                        tracePointModel.taskId = self.taskId;
                        tracePointModel.userId = [YXUserModel currentUser].userId;

                        //add point
                        [pointsString appendString:[NSString stringWithFormat:@"%.6f,%.6f;",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude]];
                        
                        //set to YXTracePointModel
                        tracePointModel.lonlatArray = pointsString;
                        
                        //save as json string
                        m.pointsData = [tracePointModel yy_modelToJSONString];
                        //save to db
                        [m bg_updateAsyncWhere:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"rowid"),bg_sqlValue(m.rowid)] complete:^(BOOL isSuccess) {
                            if (isSuccess) {
                                NSLog(@"save success");
                            }
                        }];
                    }
                }];
            }
        });
        dispatch_resume(_badgeTimer);
    }
    else if (_state == PointState_Free) {
        NSLog(@"state == PointState_Free");
    }
}

@end
