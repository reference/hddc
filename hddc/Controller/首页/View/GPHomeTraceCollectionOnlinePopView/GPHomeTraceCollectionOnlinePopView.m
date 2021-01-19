//
//  GPHomeTraceCollectionOnlinePopView.m
//  BDGuPiao
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeTraceCollectionOnlinePopView.h"
@interface GPHomeTraceCollectionOnlinePopView()<MKDropdownMenuDataSource,MKDropdownMenuDelegate>
@property (nonatomic, strong) NSMutableArray *projectsArray;
@property (nonatomic, strong) NSMutableArray *tasksArray;
@property (nonatomic, strong) NSMutableArray *colorsArray;
@property (nonatomic, strong) YXProject *projectModel;
@property (nonatomic, strong) YXTaskModel *taskModel;
@property (nonatomic, strong) NSString *color;

@property (nonatomic, strong) IBOutlet MKDropdownMenu *projectMenu;
@property (nonatomic, strong) IBOutlet MKDropdownMenu *taskMenu;
@property (nonatomic, strong) IBOutlet MKDropdownMenu *colorMenu;
@end
@implementation GPHomeTraceCollectionOnlinePopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.projectsArray = [NSMutableArray array];
    self.tasksArray = [NSMutableArray array];
    self.colorsArray = [NSMutableArray array];

    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"icon-arrow-down"];
    //
    self.projectMenu.disclosureIndicatorImage = indicator;
    self.taskMenu.disclosureIndicatorImage = indicator;
    self.colorMenu.disclosureIndicatorImage = indicator;
    
    //
    self.projectMenu.presentingView = self;
    self.taskMenu.presentingView = self;
    self.colorMenu.presentingView = self;

    // Prevent the arrow image from stretching
    self.projectMenu.contentMode = UIViewContentModeCenter;
    self.taskMenu.contentMode = UIViewContentModeCenter;
    self.colorMenu.contentMode = UIViewContentModeCenter;
    
    // Set up dropdown menu loaded from storyboard
    // Note that `dataSource` and `delegate` outlets are connected in storyboard
    self.projectMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.taskMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.colorMenu.selectedComponentBackgroundColor = [UIColor clearColor];

    self.projectMenu.dropdownBackgroundColor = [UIColor whiteColor];
    self.taskMenu.dropdownBackgroundColor = [UIColor whiteColor];
    self.colorMenu.dropdownBackgroundColor = [UIColor whiteColor];

    self.projectMenu.dropdownShowsTopRowSeparator = YES;
    self.projectMenu.dropdownShowsBottomRowSeparator = YES;
    self.projectMenu.dropdownShowsBorder = YES;
    self.projectMenu.backgroundDimmingOpacity = 0;
    
    self.taskMenu.dropdownShowsTopRowSeparator = YES;
    self.taskMenu.dropdownShowsBottomRowSeparator = YES;
    self.taskMenu.dropdownShowsBorder = YES;
    self.taskMenu.backgroundDimmingOpacity = 0;
    
    self.colorMenu.dropdownShowsTopRowSeparator = YES;
    self.colorMenu.dropdownShowsBottomRowSeparator = YES;
    self.colorMenu.dropdownShowsBorder = YES;
    self.colorMenu.backgroundDimmingOpacity = 0;
    
    //
    [self onProject:nil];
    [self onTraceColor:nil];
}

#pragma mark - action

- (IBAction)onProject:(UIButton *)b
{
    [YXProjectModel requestAllProjectWithPersonId:[YXUserModel currentUser].userId completion:^(YXProjectModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
            
        }else{
            [self.projectsArray setArray:m.rows];
            [self.projectMenu reloadAllComponents];
            
            self.projectModel = self.projectsArray.firstObject;
            if (self.projectModel) {
                [self onTask:nil];
            }
        }
    }];
}

- (IBAction)onTask:(UIButton *)b
{
    [YXTaskApiModel requestAllTasksWithProjectId:self.projectModel.projectId completion:^(YXTaskApiModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
            
        }else{
            [self.tasksArray setArray:m.rows];
            [self.taskMenu reloadAllComponents];
        }
    }];
}

- (IBAction)onTraceColor:(UIButton *)b
{
    [self.colorsArray setArray:@[@"红",@"橙",@"黄",@"绿",@"青",@"蓝",@"紫"]];
    [self.colorMenu reloadAllComponents];
}

- (IBAction)onCancelled:(UIButton *)b
{
    if (self.onCancel) {
        self.onCancel();
    }
}

- (IBAction)onDone:(UIButton *)b
{
    if (self.projectModel == nil) {
        return;
    }
    if (self.taskModel == nil) {
        [BDAudioPlayer playSoundWithType:BDSoundType_ThreeTimes];
        return;
    }
    if (self.textFields.firstObject.text.length == 0) {
        [self.textFields.firstObject shake];
        [BDAudioPlayer playSoundWithType:BDSoundType_ThreeTimes];
        return;
    }
    if (self.color.length == 0) {
        return;
    }
    if (self.onStartCollection) {
        self.onStartCollection(self.projectModel,self.taskModel,[self.textFields.firstObject.text trim],self.color);
    }
}
#pragma mark - MKDropdownMenuDataSource

/// Return the number of column items in menu.
- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu
{
    return 1;
}

/// Return the number of rows in each component.
- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component
{
    if (dropdownMenu == self.projectMenu) {
        return self.projectsArray.count;
    }
    else if (dropdownMenu == self.taskMenu) {
        return self.tasksArray.count;
    }else{
        return self.colorsArray.count;
    }
}

#pragma mark - delegate

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (dropdownMenu == self.projectMenu) {
        YXProject *m = self.projectsArray[row];
        return m.projectName;
    }
    else if (dropdownMenu == self.taskMenu) {
        YXTaskModel *m = self.tasksArray[row];
        return m.taskName;
    }
    
    return self.colorsArray[row];
}

/// Called when a row was tapped. If selection needs to be handled, use `-(de)selectRow:inComponent:` as appropriate.
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (dropdownMenu == self.projectMenu) {
        self.projectModel = self.projectsArray[row];
        [self.labels labelForTag:0].text = self.projectModel.projectName;
        
        [self onTask:nil];
    }
    else if (dropdownMenu == self.taskMenu) {
        self.taskModel = self.tasksArray[row];
        [self.labels labelForTag:1].text = self.taskModel.taskName;

    }
    else{
        //color
        self.color = self.colorsArray[row];
        [self.labels labelForTag:2].text = self.color;

    }
    [dropdownMenu closeAllComponentsAnimated:YES];
}
@end
