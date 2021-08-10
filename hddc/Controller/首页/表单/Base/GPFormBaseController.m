//
//  GPFormBaseController.m
//  BDGuPiao
//
//  Created by admin on 2020/11/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPFormBaseController.h"

@interface GPFormBaseController ()

@end

@implementation GPFormBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.imageEntities = [NSMutableArray array];
    //
    @weakify(self)
    self.window.touchedBackgroundBlock = ^{
        @strongify(self)
        [self.window dismissViewAnimated:YES completion:nil];
    };
    
    //register cell
    [self.tableViews.firstObject registerNib:[UINib nibWithNibName:NSStringFromClass(GPTaskImagesCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(GPTaskImagesCell.class)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButtonBlack];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if (self.interfaceStatus == InterfaceStatus_Show) {
        //禁用所有输入
        for (UITextField *tf in self.textFields) {
            tf.enabled = NO;
        }
        //禁用所有按钮
        for (UIButton *b in self.buttons) {
            b.enabled = NO;
        }
        //禁用textView
        for (UITextView *tv in self.textViews) {
            tv.editable = NO;
        }
        //隐藏右上角菜单保存按钮
        self.navigationItem.rightBarButtonItem = nil;
        
        //查询
        [self api_loadDetail];
    }
    
    //界面状态
    switch (self.interfaceStatus) {
        case InterfaceStatus_New:
            
            break;
        case InterfaceStatus_Edit:
            
            break;
        case InterfaceStatus_Show:
        {
            //覆盖保存按钮
            self.tableViews.firstObject.bottomLayoutConstraint.constant = -50;
        }
            break;
        default:
            break;
    }
    
    //加载本地缓存
    switch (self.interfaceStatus) {
        case InterfaceStatus_Edit:
            [self setUpUIByModel:[YXTable decodeDataInTable:self.table]];
            break;
        case InterfaceStatus_New:
            [self setUpAddress];
            break;
        default:
            break;
    }
    
    //
    if (self.isOffLineMode) {
        //覆盖保存按钮
        self.tableViews.firstObject.bottomLayoutConstraint.constant = -50;
    }
}

- (void)setupTitleLabels
{
    //loop title labels
    for (UILabel *lb in self.titleLabels) {
        if ([lb.text containsString:@"*"]) {
            //hilight star *
            [lb setTextColor:UIColor.redColor range:NSMakeRange(0, 1)];
        }
    }
}

- (void)setUpAddress
{
    if (self.provinceStr.length) {
        self.provinceLabel.text = self.provinceStr;
        self.province = [GPAdministrativeDivisionsModel new];
        self.province.divisionName = self.provinceStr;
    }
    if (self.cityStr.length) {
        self.cityLabel.text = self.cityStr;
        self.city = [GPAdministrativeDivisionsModel new];
        self.city.divisionName = self.cityStr;
    }
    if (self.zoneStr.length) {
        self.zoneLabel.text = self.zoneStr;
        self.zone = [GPAdministrativeDivisionsModel new];
        self.zone.divisionName = self.zoneStr;
    }
}

- (void)api_loadDetail
{
    //need override
}

- (void)setUpUIByModel:(id)model
{
    //need override
}

- (void)setImageEntities:(NSMutableArray<GPImageEntity *> *)imageEntities
{
    _imageEntities = imageEntities;
    if (self.interfaceStatus == InterfaceStatus_Show) {
        [self.tableViews.firstObject reloadData];
    }
}

+ (NSArray <GPImageEntity *>*)imageEntitiesWithUrl:(NSString *)url
{
    if (url.length) {
        NSArray *urls = [url componentsSeparatedByString:@","];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *ur in urls) {
            if ([ur trim].length == 0) {
                continue;
            }
            //判断是否本地路径
            GPImageEntity *m = [GPImageEntity new];
            if ([ur hasPrefix:@"http"]) {
                m.url = ur;
            }
            else{
                m.localPath = ur;
                m.identifier = ur;
            }
            [arr addObject:m];
        }
        return arr;
    }
    return nil;
}

+ (NSString *)localPathsOfImageEntities:(NSArray <GPImageEntity *> *)entities
{
    if (entities) {
        NSMutableString *paths = [NSMutableString string];
        for (GPImageEntity *en in entities) {
            [paths appendString:en.localPath];
            [paths appendString:@","];
        }
        //delete ,
        if (paths.length) {
            [paths deleteCharactersInRange:NSMakeRange(paths.length-1, 1)];
        }
        return paths;
    }return nil;
}

- (void)judgeBaseDataWhenFinished:(void(^)(BOOL pass))completion
{
    BOOL pass = YES;
    //判定
    if (self.zone == nil) {
        [BDToastView showText:@"当前地区不能为空"];
        pass = NO;
    }
    //经纬度
    if ([[self.textFields textFieldForTag:0].text trim].length == 0) {
        [BDToastView showText:@"经度不能为空"];
        pass = NO;

    }
    if ([[self.textFields textFieldForTag:1].text trim].length == 0) {
        [BDToastView showText:@"纬度不能为空"];
        pass = NO;

    }
    //详细地址不能为空
    if ([self.textViews.firstObject.text trim].length == 0) {
        [BDToastView showText:@"详细地址不能为空"];
        pass = NO;

    }
    //编号
    if ([[self.textFields textFieldForTag:2].text trim].length == 0) {
        [BDToastView showText:@"编号不能为空"];
        [[self.textFields textFieldForTag:2] becomeFirstResponder];
        pass = NO;

    }
    
    if (completion) {
        completion(pass);
    }
}

- (void)judgeBaseDataWithoutIdWhenFinished:(void(^)(BOOL pass))completion
{
    BOOL pass = YES;
    //判定
    if (self.zone == nil) {
        [BDToastView showText:@"当前地区不能为空"];
        pass = NO;
    }
    //经纬度
    if ([[self.textFields textFieldForTag:0].text trim].length == 0) {
        [BDToastView showText:@"经度不能为空"];
        pass = NO;

    }
    if ([[self.textFields textFieldForTag:1].text trim].length == 0) {
        [BDToastView showText:@"纬度不能为空"];
        pass = NO;

    }
    //详细地址不能为空
    if ([self.textViews.firstObject.text trim].length == 0) {
        [BDToastView showText:@"详细地址不能为空"];
        pass = NO;

    }
    
    if (completion) {
        completion(pass);
    }
}
#pragma mark - setter

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.textFields textFieldForTag:0].text = [NSString stringWithFormat:@"%.8f",coordinate.longitude];
    [self.textFields textFieldForTag:1].text = [NSString stringWithFormat:@"%.8f",coordinate.latitude];
}

- (void)setAddress:(NSString *)address
{
    _address = address;
    self.textViews.firstObject.text = _address;
}

#pragma mark action

- (IBAction)onChooseProvice:(UIButton *)b
{
    GPCityPicker *selector = [GPCityPicker popUpInController:self rootId:nil];
    selector.width = self.view.width;
    selector.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.onDone = ^(GPAdministrativeDivisionsModel * _Nonnull model) {
        [self.window dismissViewAnimated:YES completion:^{
            self.province = model;
            //
            self.provinceLabel.text = model.divisionName;
            
            //
            self.city = self.zone = nil;
            
            //禁用第二级联动选项
            if ([model.divisionType isEqualToString:@"Municipality"]) {
                [self.buttons buttonForTag:1].enabled = NO;
                self.cityLabel.text = model.divisionName;
            }else{
                [self.buttons buttonForTag:1].enabled = YES;
                self.cityLabel.text = @"选择市";

            }
            //zone
            self.zoneLabel.text = @"选择区";
        }];
    };
}

- (IBAction)onChooseCity:(UIButton *)b
{
    if (self.province == nil) {
        return;
    }
    GPCityPicker *selector = [GPCityPicker popUpInController:self rootId:self.province.divisionId];
    selector.width = self.view.width;
    selector.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.onDone = ^(GPAdministrativeDivisionsModel * _Nonnull model) {
        [self.window dismissViewAnimated:YES completion:^{
            self.city = model;
            self.cityLabel.text = model.divisionName;
            
            //
            self.zone = nil;
            //zone
            self.zoneLabel.text = @"选择区";
        }];
    };
}

- (IBAction)onChooseZone:(UIButton *)b
{
    if (self.province == nil) {
        return;
    }
    if (![self.province.divisionType isEqualToString:@"Municipality"] && self.city == nil) {
        return;
    }
    NSString *useDivisionId = [self.buttons buttonForTag:1].enabled ? self.city.divisionId : self.province.divisionId;
    GPCityPicker *selector = [GPCityPicker popUpInController:self rootId:useDivisionId];
    selector.width = self.view.width;
    selector.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.onDone = ^(GPAdministrativeDivisionsModel * _Nonnull model) {
        [self.window dismissViewAnimated:YES completion:^{
            self.zone = model;
            self.zoneLabel.text = model.divisionName;
        }];
    };
}

//提交
- (IBAction)onSubmit:(UIButton *)b
{
    
}
#pragma mark - action

/// 显示/影藏更多
- (IBAction)onMoreButton:(UIButton *)b
{
    b.selected = !b.selected;
    [self.tableViews.firstObject reloadData];
}

/// id sho
- (IBAction)onIDInfo:(UIButton *)b
{
    BDView *v = [UINib viewForNib:@"GPInfoView"];
    v.textViews.firstObject.text = @"长度17位，前9位，行政区划代码6位+3位专题号，后8位自定义编码，字母数字均可，不足8位#补齐3位专题号，用户自己设置。一般就是100，101，102...,201,202";
    [self popView:v position:Position_Middle];
    v.onClickedButtonsCallback = ^(UIButton *btn) {
        [self.window dismissViewAnimated:YES completion:nil];
    };
}

#pragma mark - UITableViewDataSource

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.tableHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GPTaskImagesCell heightForCellWithImageEntities:_imageEntities];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPTaskImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GPTaskImagesCell.class)];
    cell.interfaceStatus = self.interfaceStatus;
    cell.imageEntities = _imageEntities;
    cell.inViewController = self;
    cell.onImageSelected = ^{
        [tableView reloadData];
    };
    return cell;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat baseHeight = _tableViewHeaderHeight;
    if (self.moreButton.isSelected == NO) {
        //影藏
        baseHeight = self.moreButton.y + self.moreButton.height;
    }
    return baseHeight;
}

@end
