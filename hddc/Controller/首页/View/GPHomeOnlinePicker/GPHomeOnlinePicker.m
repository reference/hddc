//
//  GPHomeOnlinePicker.m
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeOnlinePicker.h"

@interface GPHomeOnlinePicker()<MKDropdownMenuDataSource,MKDropdownMenuDelegate>
@property (nonatomic, strong) NSMutableArray *projectsArray;
@property (nonatomic, strong) NSMutableArray *tasksArray;
@property (nonatomic, strong) NSMutableArray *forumArray;
@property (nonatomic, strong) NSMutableArray *subForumArray;

@property (nonatomic, strong) YXProject *projectModel;
@property (nonatomic, strong) YXTaskModel *taskModel;
@property (nonatomic, strong) NSString *selectedForum;
@property (nonatomic, strong) NSDictionary *selectedSubForumInfo;

@property (nonatomic, strong) IBOutlet MKDropdownMenu *projectMenu;
@property (nonatomic, strong) IBOutlet MKDropdownMenu *taskMenu;
@property (nonatomic, strong) IBOutlet MKDropdownMenu *forumTypeMenu;
@property (nonatomic, strong) IBOutlet MKDropdownMenu *subForumTypeMenu;
@end
@implementation GPHomeOnlinePicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.projectsArray = [NSMutableArray array];
    self.tasksArray = [NSMutableArray array];
    self.forumArray = [NSMutableArray array];
    self.subForumArray = [NSMutableArray array];
    
    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"icon-arrow-down"];
    //
    self.projectMenu.disclosureIndicatorImage = indicator;
    self.taskMenu.disclosureIndicatorImage = indicator;
    self.forumTypeMenu.disclosureIndicatorImage = indicator;
    self.subForumTypeMenu.disclosureIndicatorImage = indicator;

    //
    self.projectMenu.presentingView = self;
    self.taskMenu.presentingView = self;
    self.forumTypeMenu.presentingView = self;
    self.subForumTypeMenu.presentingView = self;

    // Prevent the arrow image from stretching
    self.projectMenu.contentMode = UIViewContentModeCenter;
    self.taskMenu.contentMode = UIViewContentModeCenter;
    self.forumTypeMenu.contentMode = UIViewContentModeCenter;
    self.subForumTypeMenu.contentMode = UIViewContentModeCenter;

    // Set up dropdown menu loaded from storyboard
    // Note that `dataSource` and `delegate` outlets are connected in storyboard
    self.projectMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.taskMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.forumTypeMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.subForumTypeMenu.selectedComponentBackgroundColor = [UIColor clearColor];

    self.projectMenu.dropdownBackgroundColor = [UIColor whiteColor];
    self.taskMenu.dropdownBackgroundColor = [UIColor whiteColor];
    self.forumTypeMenu.dropdownBackgroundColor = [UIColor whiteColor];
    self.subForumTypeMenu.dropdownBackgroundColor = [UIColor whiteColor];

    //
    self.projectMenu.dropdownShowsTopRowSeparator = YES;
    self.projectMenu.dropdownShowsBottomRowSeparator = YES;
    self.projectMenu.dropdownShowsBorder = YES;
    self.projectMenu.backgroundDimmingOpacity = 0;
    
    self.taskMenu.dropdownShowsTopRowSeparator = YES;
    self.taskMenu.dropdownShowsBottomRowSeparator = YES;
    self.taskMenu.dropdownShowsBorder = YES;
    self.taskMenu.backgroundDimmingOpacity = 0;
    
    self.forumTypeMenu.dropdownShowsTopRowSeparator = YES;
    self.forumTypeMenu.dropdownShowsBottomRowSeparator = YES;
    self.forumTypeMenu.dropdownShowsBorder = YES;
    self.forumTypeMenu.backgroundDimmingOpacity = 0;
    
    self.subForumTypeMenu.dropdownShowsTopRowSeparator = YES;
    self.subForumTypeMenu.dropdownShowsBottomRowSeparator = YES;
    self.subForumTypeMenu.dropdownShowsBorder = YES;
    self.subForumTypeMenu.backgroundDimmingOpacity = 0;
    //
    [self onProject:nil];
    [self onForumData:nil];
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
            [self onTask:nil];
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
            
            self.taskModel = self.tasksArray.firstObject;
            if (self.taskMenu) {
                [self.labels labelForTag:1].text = self.taskModel.taskName;
            }
        }
    }];
}

- (IBAction)onForumData:(UIButton *)b
{
    //
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dixingType" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    [self.forumArray setArray:[dic allKeys]];
    [self.forumTypeMenu reloadAllComponents];
}

- (IBAction)onSubForumData:(UIButton *)b
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dixingType" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                      error:nil];
    NSArray *subForumArray = dic[self.selectedForum];
    [self.subForumArray setArray:subForumArray];
    [self.subForumTypeMenu reloadAllComponents];
    
    //默认选择第一项
    self.selectedSubForumInfo = self.subForumArray[0];
    [self.labels labelForTag:3].text = self.selectedSubForumInfo[@"name"];
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
    if (self.selectedSubForumInfo == nil) {
        return;
    }
    if (self.onDone) {
        self.onDone(self.projectModel,self.taskModel,self.selectedSubForumInfo[@"id"]);
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
    }
    else if (dropdownMenu == self.forumTypeMenu) {
        return self.forumArray.count;
    }
    else{
        return self.subForumArray.count;
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
    else if (dropdownMenu == self.forumTypeMenu) {
        return self.forumArray[row];
    }
    NSDictionary *subForumInfo = self.subForumArray[row];
    return subForumInfo[@"name"];
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
    else if (dropdownMenu == self.forumTypeMenu) {
        self.selectedForum = self.forumArray[row];
        [self.labels labelForTag:2].text = self.selectedForum;
        
        [self onSubForumData:nil];
    }
    else{
        //color
        self.selectedSubForumInfo = self.subForumArray[row];
        [self.labels labelForTag:3].text = self.selectedSubForumInfo[@"name"];

    }
    [dropdownMenu closeAllComponentsAnimated:YES];
}

@end
