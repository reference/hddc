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
        id model = self.forumDataInfoModels.firstObject;
        AGSPoint *mpPoint = nil;
        if ([model isKindOfClass:YXForumDataInfoModel.class]) {
            YXForumDataInfoModel *m = model;
            mpPoint = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake(m.lat,m.lon)];
        }
        else{
            YXTable *tb = model;
            id datamodel = [YXTable decodeDataInTable:tb];
            NSDictionary *mInfo = [datamodel yy_modelToJSONObject];
            mpPoint = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([mInfo[@"lat"] doubleValue],[mInfo[@"lon"] doubleValue])];
        }

        self.didAddNew(mpPoint);
    }
}

- (void)setForumDataInfoModels:(NSArray *)forumDataInfoModels
{
    _forumDataInfoModels = forumDataInfoModels;
    
    if (forumDataInfoModels.count == 1) {
        self.tableViews.firstObject.heightLayoutConstraint.constant = 50;
        self.tableViews.firstObject.scrollEnabled = NO;
    }
    else if (forumDataInfoModels.count == 2) {
        self.tableViews.firstObject.heightLayoutConstraint.constant = 100;
        self.tableViews.firstObject.scrollEnabled = NO;
    }
    else if (forumDataInfoModels.count == 3) {
        self.tableViews.firstObject.heightLayoutConstraint.constant = 150;
        self.tableViews.firstObject.scrollEnabled = NO;
    }else{
        self.tableViews.firstObject.heightLayoutConstraint.constant = 200;
        self.tableViews.firstObject.scrollEnabled = YES;
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
    id model = self.forumDataInfoModels[indexPath.row];
    if ([model isKindOfClass:YXForumDataInfoModel.class]) {
        YXForumDataInfoModel *m = model;
        cell.labels.firstObject.text = [GPForumType nameOfType:m.type];
    }
    else{
        YXTable *tb = model;
        id datamodel = [YXTable decodeDataInTable:tb];
        NSDictionary *mInfo = [datamodel yy_modelToJSONObject];
        cell.labels.firstObject.text = [GPForumType nameOfType:[mInfo[@"type"] integerValue]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id m = self.forumDataInfoModels[indexPath.row];

    if (self.didSelectForum) {
        self.didSelectForum(m);
    }
}

@end
