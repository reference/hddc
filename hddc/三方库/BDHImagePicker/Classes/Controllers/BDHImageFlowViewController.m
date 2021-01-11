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
#import "BDHImageFlowViewController.h"
#import "BDHImagePickerController.h"
#import "BDHPhotoBrowser.h"
#import "UIViewController+BDHImagePicker.h"
#import "UIView+BDHImagePicker.h"
#import "UIColor+Hex.h"
#import "BDHAssetsViewCell.h"
#import "BDHSendButton.h"
#import "BDHImagePickerHelper.h"
#import "BDHAlbum.h"
#import "BDHAsset.h"

static NSUInteger const kBDHImageFlowMaxSeletedNumber = 9;

@interface BDHImageFlowViewController () <UICollectionViewDataSource, UICollectionViewDelegate, BDHAssetsViewCellDelegate, BDHPhotoBrowserDelegate>

@property (nonatomic, strong) BDHAlbum *album;
@property (nonatomic, copy) NSString *albumIdentifier;

@property (nonatomic, strong) UICollectionView *imageFlowCollectionView;
@property (nonatomic, strong) BDHSendButton *sendButton;

@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) BOOL isFullImage;
@end

static NSString* const BDHAssetsViewCellReuseIdentifier = @"BDHAssetsViewCell";

@implementation BDHImageFlowViewController

- (instancetype)initWithAlbumIdentifier:(NSString *)albumIdentifier {
    self = [super init];
    if (self) {
        _assetsArray = [NSMutableArray array];
        _selectedAssetsArray = [NSMutableArray array];
        _albumIdentifier = albumIdentifier;
    }
    return self;
}

- (instancetype)initWithAblum:(BDHAlbum *)album {
    self = [super init];
    if (self) {
        _assetsArray = [NSMutableArray array];
        _selectedAssetsArray = [NSMutableArray array];
        _album = album;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:BDHImagePickerPhotoLibraryChangedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupData {
    
    if (!self.album && self.albumIdentifier.length > 0) {
        __weak typeof(self) wSelf = self;
        [BDHImagePickerHelper requestCurrentAblumWithCompleteHandler:^(BDHAlbum *album) {
            __strong typeof(wSelf) sSelf = wSelf;
            sSelf.album = album;
            sSelf.title = sSelf.album.albumTitle;
            [sSelf loadData];
        }];
    } else {
        self.title = self.album.albumTitle;
        [self loadData];
    }
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBarButtonItemAtPosition:BDHImagePickerNavigationBarPositionLeft
                      statusNormalImage:[UIImage imageNamed:@"navi_back_black"]
                   statusHighlightImage:[UIImage imageNamed:@"back_highlight"]
                                 action:@selector(backButtonAction)];
    [self createBarButtonItemAtPosition:BDHImagePickerNavigationBarPositionRight
                                   text:NSLocalizedStringFromTable(@"cancel", @"BDHImagePicker", @"取消")
                                 action:@selector(cancelAction)];
    
    [self imageFlowCollectionView];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"preview", @"BDHImagePicker", @"预览")
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(previewAction)];
    [item1 setTintColor:[UIColor blackColor]];
    item1.enabled = NO;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = -10;
    
    [self setToolbarItems:@[item1,item2,item3,item4] animated:NO];
}

- (void)loadData {
    if (!self.assetsArray.count) {
        [self.indicatorView startAnimating];
    }
    __weak typeof(self) wSelf = self;
    [BDHImagePickerHelper fetchImageAssetsInAlbum:self.album completeHandler:^(NSArray<BDHAsset *> * imageArray) {
        __strong typeof(wSelf) sSelf = wSelf;
        [sSelf.indicatorView stopAnimating];
        [sSelf.assetsArray removeAllObjects];
        [sSelf.assetsArray addObjectsFromArray:imageArray];
        [self.imageFlowCollectionView reloadData];
        [self scrollerToBottom:NO];
    }];
}

#pragma mark - helpmethods
- (void)scrollerToBottom:(BOOL)animated {
    NSInteger rows = [self.imageFlowCollectionView numberOfItemsInSection:0] - 1;
    [self.imageFlowCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:rows inSection:0]
                                         atScrollPosition:UICollectionViewScrollPositionBottom
                                                 animated:animated];
}

- (BDHImagePickerController *)BDHImagePickerController {
    if (!self.navigationController
        ||
        ![self.navigationController isKindOfClass:[BDHImagePickerController class]])
    {
        NSAssert(false, @"check the navigation controller");
    }
    return (BDHImagePickerController *)self.navigationController;
}

- (void)removeAssetsObject:(BDHAsset *)asset {
    if ([self.selectedAssetsArray containsObject:asset]) {
        [self.selectedAssetsArray removeObject:asset];
    }
}

- (void)addAssetsObject:(BDHAsset *)asset {
    [self.selectedAssetsArray addObject:asset];
}

#pragma mark - priviate methods
- (void)sendImages {
    [BDHImagePickerHelper saveAblumIdentifier:self.album.identifier];
    
    BDHImagePickerController *imagePicker = [self BDHImagePickerController];
    if (imagePicker && [imagePicker.imagePickerDelegate respondsToSelector:@selector(BDHImagePickerController:sendImages:isFullImage:)]) {
        [imagePicker.imagePickerDelegate BDHImagePickerController:imagePicker
                                                      sendImages:self.selectedAssetsArray
                                                     isFullImage:self.isFullImage];
    }
    if (imagePicker.pickImagesFinished) {
        imagePicker.pickImagesFinished(imagePicker,self.selectedAssetsArray,self.isFullImage);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];}

- (void)browserPhotoAsstes:(NSArray *)assets pageIndex:(NSInteger)page {
    BDHPhotoBrowser *browser = [[BDHPhotoBrowser alloc] initWithPhotos:assets
                                                        currentIndex:page
                                                           fullImage:self.isFullImage];
    browser.delegate = self;
    browser.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:browser animated:YES];
}

- (BOOL)seletedAssets:(BDHAsset *)asset {
    if ([self.selectedAssetsArray containsObject:asset]) {
        return NO;
    }
    UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
    firstItem.enabled = YES;
    if (self.selectedAssetsArray.count >= kBDHImageFlowMaxSeletedNumber) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"alertTitle", @"BDHImagePicker", nil)
                                                        message:NSLocalizedStringFromTable(@"alertContent", @"BDHImagePicker", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedStringFromTable(@"alertButton", @"BDHImagePicker", nil)
                                              otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else {
        [self addAssetsObject:asset];
        self.sendButton.badgeValue = [NSString stringWithFormat:@"%@",@(self.selectedAssetsArray.count)];
        return YES;
    }
}

- (void)deseletedAssets:(BDHAsset *)asset {
    [self removeAssetsObject:asset];
    self.sendButton.badgeValue = [NSString stringWithFormat:@"%@",@(self.selectedAssetsArray.count)];
    if (self.selectedAssetsArray.count < 1) {
        UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
        firstItem.enabled = NO;
    }
}

#pragma mark - getter/setter

- (UICollectionView *)imageFlowCollectionView {
    if (!_imageFlowCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0;
        layout.minimumInteritemSpacing = 2.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _imageFlowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _imageFlowCollectionView.backgroundColor = [UIColor clearColor];
        [_imageFlowCollectionView registerClass:[BDHAssetsViewCell class] forCellWithReuseIdentifier:BDHAssetsViewCellReuseIdentifier];
        _imageFlowCollectionView.alwaysBounceVertical = YES;
        _imageFlowCollectionView.delegate = self;
        _imageFlowCollectionView.dataSource = self;
        _imageFlowCollectionView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:_imageFlowCollectionView];
    }
    
    return _imageFlowCollectionView;
}

- (BDHSendButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [[BDHSendButton alloc] initWithFrame:CGRectZero];
        [_sendButton addTaget:self action:@selector(sendButtonAction:)];
    }
    return  _sendButton;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.centerX = CGRectGetWidth(self.view.bounds)/2;
        _indicatorView.centerY = CGRectGetHeight(self.view.bounds)/2;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}

#pragma mark - ui action
- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendButtonAction:(id)sender {
    if (self.selectedAssetsArray.count > 0) {
        [self sendImages];
    }
}

- (void)previewAction {
    [self browserPhotoAsstes:self.selectedAssetsArray pageIndex:0];
}

- (void)cancelAction {
    BDHImagePickerController *navController = [self BDHImagePickerController];
    if (navController && [navController.imagePickerDelegate respondsToSelector:@selector(BDHImagePickerControllerDidCancel:)]) {
        [navController.imagePickerDelegate BDHImagePickerControllerDidCancel:navController];
    }
    if (navController.pickImagesCancel) {
        navController.pickImagesCancel(navController);
    }
}

#pragma mark - BDHAssetsViewCellDelegate
- (void)didSelectItemAssetsViewCell:(BDHAssetsViewCell *)assetsCell {
    assetsCell.isSelected = [self seletedAssets:assetsCell.asset];
}

- (void)didDeselectItemAssetsViewCell:(BDHAssetsViewCell *)assetsCell {
    assetsCell.isSelected = NO;
    [self deseletedAssets:assetsCell.asset];
}

#pragma mark - UICollectionView delegate and Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDHAssetsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BDHAssetsViewCellReuseIdentifier forIndexPath:indexPath];
    BDHAsset *asset = self.assetsArray[indexPath.row];
    cell.delegate = self;
    [cell fillWithAsset:asset isSelected:[self.selectedAssetsArray containsObject:asset]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self browserPhotoAsstes:self.assetsArray pageIndex:indexPath.row];
}

#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - BDHPhotoBrowserDelegate
- (void)sendImagesFromPhotobrowser:(BDHPhotoBrowser *)photoBrowser currentAsset:(BDHAsset *)asset {
    if (self.selectedAssetsArray.count <= 0) {
        [self seletedAssets:asset];
        [self.imageFlowCollectionView reloadData];
    }
    [self sendImages];
}

- (NSUInteger)seletedPhotosNumberInPhotoBrowser:(BDHPhotoBrowser *)photoBrowser {
    return self.selectedAssetsArray.count;
}

- (BOOL)photoBrowser:(BDHPhotoBrowser *)photoBrowser currentPhotoAssetIsSeleted:(BDHAsset *)asset{
    return [self.selectedAssetsArray containsObject:asset];
}

- (BOOL)photoBrowser:(BDHPhotoBrowser *)photoBrowser seletedAsset:(BDHAsset *)asset {
    BOOL seleted = [self seletedAssets:asset];
    [self.imageFlowCollectionView reloadData];
    return seleted;
}

- (void)photoBrowser:(BDHPhotoBrowser *)photoBrowser deseletedAsset:(BDHAsset *)asset {
    [self deseletedAssets:asset];
    [self.imageFlowCollectionView reloadData];
}

- (void)photoBrowser:(BDHPhotoBrowser *)photoBrowser seleteFullImage:(BOOL)fullImage {
    self.isFullImage = fullImage;
}

@end
