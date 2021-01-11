//
//  GPTaskQueue.m
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTaskQueue.h"


@interface GPTaskQueue()
@property (nonatomic, strong) NSMutableArray *allTasks;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation GPTaskQueue

- (id)init
{
    if (self = [super init]) {
        self.isRunningTask = NO;
        self.allTasks = [NSMutableArray array];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(onDoTaskTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }return self;
}

+ (GPTaskQueue *)instance
{
    static dispatch_once_t onceToken;
    static GPTaskQueue *q = nil;
    dispatch_once(&onceToken, ^{
        q = [self new];
    });
    return q;
}

- (void)addTask:(GPTask *)task
{
    if (task) {
        [self.allTasks addObject:task];
    }
}

- (void)removeTaskById:(NSString *)identifier
{
    if ([identifier isNotEmpty]) {
        for (GPTask *task in self.allTasks) {
            if ([task.identifier isEqualToString:identifier]) {
                [self.allTasks removeObject:task];
                return;
            }
        }
    }
}

- (void)resume
{
    
}

- (void)start
{
    
}

- (void)stop
{
    
}

#pragma mark - timer

- (void)onDoTaskTimer:(NSTimer *)timer
{
    
}

@end
