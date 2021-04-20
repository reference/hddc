//
//  GPTaskImagesCell.m
//  BDGuPiao
//
//  Created by admin on 2020/11/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTaskImagesCell.h"

#define Cellheight 100
@interface GPTaskImagesCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) IBOutlet UICollectionView *collectionView;

@end

@implementation GPTaskImagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GPTaskImagesCollectionCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(BDCollectionViewCell.class)];
}

+ (CGFloat)heightForCellWithImageEntities:(NSArray *)imageEntities
{
    CGFloat height = Cellheight;
    if (imageEntities.count >= 4 && imageEntities.count < 8) {
        height = Cellheight * 2;
    }else if (imageEntities.count >= 8) {
        height = Cellheight * 3;
    }
    return height;
}

- (void)setImageEntities:(NSMutableArray<GPImageEntity *> *)imageEntities
{
    _imageEntities = imageEntities;
    if (self.interfaceStatus == InterfaceStatus_Show) {
        [self.collectionView reloadData];
    }
}

#pragma mark datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return _imageEntities.count;
    }
    
    return self.imageEntities.count + (self.imageEntities.count == 10 ? 0 : 1);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(BDCollectionViewCell.class) forIndexPath:indexPath];
    if (self.interfaceStatus == InterfaceStatus_Show) {
        GPImageEntity *entity = _imageEntities[indexPath.row];
        if (entity.url == nil) {
            NSString *filePath = [NSFileManager documentFile:entity.localPath];
            cell.imageViews.firstObject.image = [UIImage imageWithContentsOfFile:filePath];
        }else{
            NSString *url = [entity.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [cell.imageViews.firstObject sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        //隐藏删除按钮
        cell.buttons.firstObject.hidden = YES;
    }else{
        if (indexPath.row < self.imageEntities.count) {
            GPImageEntity *entity = self.imageEntities[indexPath.row];
            if (entity.url == nil) {
                NSString *filePath = [NSFileManager documentFile:entity.localPath];
                cell.imageViews.firstObject.image = [UIImage imageWithContentsOfFile:filePath];
            }else{
                NSString *url = [entity.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [cell.imageViews.firstObject sd_setImageWithURL:[NSURL URLWithString:url]];
            }
            cell.buttons.firstObject.hidden = NO;

        }else{
            cell.buttons.firstObject.hidden = YES;

            //加号
            cell.imageViews.firstObject.image = [UIImage imageNamed:@"icon_plus"];
        }
    }
    
    @weakify(cell)
    @weakify(self)
    cell.onClickedButtons = ^(NSInteger tag) {
        @strongify(self)
        @strongify(cell)
        
//        if (indexPath.row < self.imageEntities.count) {
//            return;
//        }
        //
        [self.inViewController alertText:@"是否确定删除？" sureTitle:@"删除" sureAction:^{
            //delete
            GPImageEntity *entity = self.imageEntities[[collectionView indexPathForCell:cell].row];
            //删除本地图片
            if (entity.localPath.length > 0) {
                NSString *filePath = [NSFileManager documentFile:entity.localPath];
                [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:filePath] error:nil];
            }
            //
            [self.imageEntities removeObject:entity];
            [collectionView reloadData];
        }];
    };
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = collectionView.bounds.size;
    size.width = collectionView.width / 4.f;
    size.height = Cellheight;
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        //展示图片
        if (_imageEntities.count) {
            NSMutableArray *photos = [NSMutableArray array];
            for (GPImageEntity *m in _imageEntities) {
                NSString *url = [m.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:url]];
                [photos addObject:photo];
            }
            IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
            [self.inViewController presentViewController:browser animated:YES completion:nil];
        }
        
        
    }else{
        if (indexPath.row < self.imageEntities.count) {
            return;
        }
        
//        [BDHImagePickerHelper requestAlbumListWithCompleteHandler:^(NSArray<BDHAlbum *> * _Nonnull anblumList) {
//            BDHImagePickerController *imagePicker = [[BDHImagePickerController alloc] init];
//            imagePicker.pickImagesFinished = ^(BDHImagePickerController *picker, NSArray *imageAssets, BOOL fullImage) {
////                NSLog(@"%@",imageAssets);
//                for (BDHAsset *asset in imageAssets) {
//                    //upload
//                    GPImageEntity *entity = [GPImageEntity new];
//                    entity.identifier = [NSString stringWithFormat:@"%@.png",[NSString randomKey]];
//                    entity.localPath = [self.inViewController pathForFileInSandboxWithName:entity.identifier];
//                    //保存到本地
//                    NSData *imgData = [asset.cacheImage compressToData:1024 * 1024];
//                    [FileManager asyncSaveData:imgData withPath:entity.localPath callback:^(BOOL succeed) {
//                        if (succeed) {
//                            //
//                            [self.imageEntities addObject:entity];
//                            [collectionView reloadData];
//
//                            //
//                            if (self.onImageSelected) {
//                                self.onImageSelected();
//                            }
//
//                            NSLog(@"图片保存本地成功，路径:%@",entity.localPath);
//                        }else{
//                            [BDToastView showText:@"保存图片失败"];
//                        }
//                    }];
////                    BOOL suc = [imgData writeToFile:entity.localPath atomically:YES];
////                    if (suc) {
////                        //
////                        [self.imageEntities addObject:entity];
////                        [collectionView reloadData];
////
////                        //
////                        if (self.onImageSelected) {
////                            self.onImageSelected();
////                        }
////                    }else{
////                        [BDToastView showText:@"保存图片失败,请确认相机权限开启再重试。"];
////                    }
//                }
//            };
//            imagePicker.pickImagesCancel = ^(BDHImagePickerController *picker) {
//                [imagePicker dismissViewControllerAnimated:YES completion:nil];
//            };
//            [self.inViewController presentViewController:imagePicker animated:YES completion:nil];
//        }];
        ///var/mobile/Containers/Data/Application/3E19EF93-6B03-436B-9E5B-96049E061B38/Documents/7eba4e7c0a5fa9715e2cbe5ea6690029.png
        __block BOOL clicked = YES;
        
        //延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            clicked = NO;
        });
        if (clicked == YES) {
            clicked = NO;
        }
        
        if (clicked == YES) {
            return;
        }
        [self.inViewController pickImageFromAlbumWithCanEditImage:NO block:^(UIImage *image) {

            //upload
            GPImageEntity *entity = [GPImageEntity new];
            entity.identifier = [NSString stringWithFormat:@"%@.png",[NSString randomKey]];
            entity.localPath = entity.identifier;
            NSString *filePath = [NSFileManager documentFile:entity.identifier];
            //保存到本地
            NSData *imgData = [image compressToData:1024 * 1024];
//            BOOL suc = [imgData writeToFile:entity.localPath atomically:YES];
            BOOL suc = [[NSFileManager defaultManager] createFileAtPath:filePath contents:imgData attributes:nil];
            if (suc) {
                //
                [self.imageEntities addObject:entity];
                [collectionView reloadData];

                //
                if (self.onImageSelected) {
                    self.onImageSelected();
                }
                NSLog(@"保存成功，地址：%@",entity.localPath);

            }else{
                [BDToastView showText:@"保存图片失败,请确认相机权限开启再重试。"];
            }
        }];
    }
}
@end
