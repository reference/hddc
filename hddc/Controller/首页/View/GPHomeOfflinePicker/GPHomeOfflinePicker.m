//
//  GPHomeOfflinePicker.m
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeOfflinePicker.h"

@interface GPHomeOfflinePicker()<MKDropdownMenuDataSource,MKDropdownMenuDelegate>
@property (nonatomic, strong) NSMutableArray *forumArray;
@property (nonatomic, strong) NSMutableArray *subForumArray;

@property (nonatomic, strong) NSString *selectedForum;
@property (nonatomic, strong) NSDictionary *selectedSubForumInfo;

@property (nonatomic, strong) IBOutlet MKDropdownMenu *forumTypeMenu;
@property (nonatomic, strong) IBOutlet MKDropdownMenu *subForumTypeMenu;
@end
@implementation GPHomeOfflinePicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.forumArray = [NSMutableArray array];
    self.subForumArray = [NSMutableArray array];
    
    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"icon-arrow-down"];
    //
    self.forumTypeMenu.disclosureIndicatorImage = indicator;
    self.subForumTypeMenu.disclosureIndicatorImage = indicator;

    //
    self.forumTypeMenu.presentingView = self;
    self.subForumTypeMenu.presentingView = self;

    // Prevent the arrow image from stretching
    self.forumTypeMenu.contentMode = UIViewContentModeCenter;
    self.subForumTypeMenu.contentMode = UIViewContentModeCenter;

    // Set up dropdown menu loaded from storyboard
    // Note that `dataSource` and `delegate` outlets are connected in storyboard
    self.forumTypeMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.subForumTypeMenu.selectedComponentBackgroundColor = [UIColor clearColor];

    
    self.forumTypeMenu.dropdownBackgroundColor = [UIColor whiteColor];
    self.subForumTypeMenu.dropdownBackgroundColor = [UIColor whiteColor];

    //
    
    self.forumTypeMenu.dropdownShowsTopRowSeparator = YES;
    self.forumTypeMenu.dropdownShowsBottomRowSeparator = YES;
    self.forumTypeMenu.dropdownShowsBorder = YES;
    self.forumTypeMenu.backgroundDimmingOpacity = 0;
    
    self.subForumTypeMenu.dropdownShowsTopRowSeparator = YES;
    self.subForumTypeMenu.dropdownShowsBottomRowSeparator = YES;
    self.subForumTypeMenu.dropdownShowsBorder = YES;
    self.subForumTypeMenu.backgroundDimmingOpacity = 0;
    //
    [self onForumData:nil];
}

#pragma mark - action

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
}

- (IBAction)onCancelled:(UIButton *)b
{
    if (self.onCancel) {
        self.onCancel();
    }
}

- (IBAction)onDone:(UIButton *)b
{
    if (self.selectedSubForumInfo == nil) {
        return;
    }
    if (self.onDone) {
        self.onDone(self.selectedSubForumInfo[@"id"]);
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
    if (dropdownMenu == self.forumTypeMenu) {
        return self.forumArray.count;
    }
    else{
        return self.subForumArray.count;
    }
}

#pragma mark - delegate

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (dropdownMenu == self.forumTypeMenu) {
        return self.forumArray[row];
    }
    NSDictionary *subForumInfo = self.subForumArray[row];
    return subForumInfo[@"name"];
}

/// Called when a row was tapped. If selection needs to be handled, use `-(de)selectRow:inComponent:` as appropriate.
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (dropdownMenu == self.forumTypeMenu) {
        self.selectedForum = self.forumArray[row];
        [self.labels labelForTag:0].text = self.selectedForum;
        
        [self onSubForumData:nil];
    }
    else{
        //color
        self.selectedSubForumInfo = self.subForumArray[row];
        [self.labels labelForTag:1].text = self.selectedSubForumInfo[@"name"];

    }
    [dropdownMenu closeAllComponentsAnimated:YES];
}
@end
