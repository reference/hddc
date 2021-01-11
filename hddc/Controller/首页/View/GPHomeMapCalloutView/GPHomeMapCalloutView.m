//
//  GPHomeMapCalloutView.m
//  BDGuPiao
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeMapCalloutView.h"

@interface GPHomeMapCalloutView()
@end

@implementation GPHomeMapCalloutView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.tableViews.firstObject registerNib:[UINib nibWithNibName:@"GPHomeMapCalloutCellView" bundle:nil] forCellReuseIdentifier:@"BDTableViewCell"];
}

- (IBAction)onNew:(UIButton *)b
{
    if (self.didAddNew) {
        AGSPoint *mpPoint = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake(self.forumDataInfoModels.firstObject.lat,self.forumDataInfoModels.firstObject.lon)];

        self.didAddNew(mpPoint);
    }
}

- (void)setForumDataInfoModels:(NSArray<YXForumDataInfoModel *> *)forumDataInfoModels
{
    _forumDataInfoModels = forumDataInfoModels;
    
    if (forumDataInfoModels.count == 1) {
        self.height = 110;
        self.tableViews.firstObject.scrollEnabled = NO;
    }
    else if (forumDataInfoModels.count == 2) {
        self.height = 160;
        self.tableViews.firstObject.scrollEnabled = NO;
    }
    else if (forumDataInfoModels.count == 3) {
        self.height = 210;
        self.tableViews.firstObject.scrollEnabled = NO;
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.forumDataInfoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BDTableViewCell.class)];
    YXForumDataInfoModel *m = self.forumDataInfoModels[indexPath.row];
    cell.labels.firstObject.text = [GPForumType nameOfType:m.type];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YXForumDataInfoModel *m = self.forumDataInfoModels[indexPath.row];

    if (self.didSelectForum) {
        self.didSelectForum(m);
    }
}

@end
