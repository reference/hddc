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
//  @see https://blog.csdn.net/qq_16064871/article/details/78869326
//  @see https://blog.csdn.net/wanm9/article/details/52318837

#import <ArcGIS/ArcGIS.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    GoogleMap_VECTOR = 0, ///<矢量>
    GoogleMap_IMAGE, ///<影像>
    GoogleMap_TERRAIN, ///<地形>
    GoogleMap_ANNOTATION ///
}AGSGoogleMapLayerType;

// Google Map Layer Info
@interface AGSGoogleMapLayerInfo : NSObject
@property(nonatomic,strong,readwrite)AGSEnvelope *fullExtent;
@property(nonatomic,strong)AGSTileInfo *tileInfo;

/// init
/// @param type type
-(instancetype)initWithLayerType:(AGSGoogleMapLayerType)type;

/// get url
/// @param x x
/// @param y y
/// @param z level
-(NSString *)getGoogleMapServiceURLWithX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z;
@end

// Google map layer
@interface AGSGoogleMapLayer : AGSImageTiledLayer

/// init
/// @param info info
-(instancetype)initWithAGSGoogleMapLayerInfo:(AGSGoogleMapLayerInfo *)info;

/// 加载谷歌地图
/// @param map map
+ (void)loadAGSGoogleMapLayer:(AGSMap *)map type:(AGSGoogleMapLayerType)type;

@end

NS_ASSUME_NONNULL_END
