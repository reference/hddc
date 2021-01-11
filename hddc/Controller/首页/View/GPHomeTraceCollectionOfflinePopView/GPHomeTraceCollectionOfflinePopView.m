//
//  GPHomeTraceCollectionOfflinePopView.m
//  BDGuPiao
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeTraceCollectionOfflinePopView.h"

@interface GPHomeTraceCollectionOfflinePopView()<MKDropdownMenuDataSource,MKDropdownMenuDelegate>
@property (nonatomic, strong) NSMutableArray *colorsArray;
@property (nonatomic, strong) NSString *color;

@property (nonatomic, strong) IBOutlet MKDropdownMenu *colorMenu;
@end
@implementation GPHomeTraceCollectionOfflinePopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colorsArray = [NSMutableArray array];

    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"icon-arrow-down"];
    //
    self.colorMenu.disclosureIndicatorImage = indicator;
    
    //
    self.colorMenu.presentingView = self;

    // Prevent the arrow image from stretching
    self.colorMenu.contentMode = UIViewContentModeCenter;
    
    // Set up dropdown menu loaded from storyboard
    // Note that `dataSource` and `delegate` outlets are connected in storyboard
    self.colorMenu.selectedComponentBackgroundColor = [UIColor clearColor];
    self.colorMenu.dropdownBackgroundColor = [UIColor whiteColor];
    
    self.colorMenu.dropdownShowsTopRowSeparator = YES;
    self.colorMenu.dropdownShowsBottomRowSeparator = YES;
    self.colorMenu.dropdownShowsBorder = YES;
    self.colorMenu.backgroundDimmingOpacity = 0;
    
    //
    [self onTraceColor:nil];
}

#pragma mark - action

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
    if (self.textFields.firstObject.text.length == 0) {
        [self.textFields.firstObject shake];
        [BDAudioPlayer playSoundWithType:BDSoundType_ThreeTimes];
        return;
    }
    if (self.color.length == 0) {
        return;
    }
    if (self.onStartCollection) {
        self.onStartCollection([self.textFields.firstObject.text trim],self.color);
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
    return self.colorsArray.count;
}

#pragma mark - delegate

- (nullable NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return self.colorsArray[row];
}

/// Called when a row was tapped. If selection needs to be handled, use `-(de)selectRow:inComponent:` as appropriate.
- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //color
    self.color = self.colorsArray[row];
    [self.labels labelForTag:2].text = self.color;
    [dropdownMenu closeAllComponentsAnimated:YES];
}

@end
