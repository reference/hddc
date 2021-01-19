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
#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>
#import "BDArcGISGraphic.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDArcGISUtil : NSObject
//
@property (nonatomic, strong, readonly) AGSGraphicsOverlay *graphicsOverlay;

+ (BDArcGISUtil *)ins;

#pragma mark - overlay * draw graphic

//point 点
- (AGSGraphic *)drawPoint:(AGSPoint *)point;
- (AGSGraphic *)drawPointWithCoordinate2D:(CLLocationCoordinate2D )coordinate;
- (AGSGraphic *)drawPointWithLatitude:(CLLocationDegrees )latitude longitude:(CLLocationDegrees )longitude;
- (void)drawPoints:(NSArray <AGSPoint *> *)points;

//simple line 单线条
- (void)drawLineWithStartPoint:(AGSPoint *)startPoint endPoint:(AGSPoint *)endPoint;
- (AGSGraphic *)drawMultiLinesByPoints:(NSArray <AGSPoint *> *)points;
+ (AGSGraphic *)buildMultiLinesByPoints:(NSArray <AGSPoint *> *)points;

//Polygon 多边形
- (AGSGraphic *)drawPolygonWithPoints:(NSArray <AGSPoint *> *)points;
- (void)romovePolygonGraphic:(AGSGraphic *)graphic;
- (void)drawMultiPolygonWithPointsGroup:(NSArray <NSArray <AGSPoint *> *> *)group;
+ (AGSGraphic *)buildPolygonWithPoints:(NSArray <AGSPoint *> *)points;

//画图
- (void)drawGraphics:(NSArray <BDArcGISGraphic *> *)graphics;

//pin
- (AGSGraphic *)pinAtPoint:(AGSPoint *)point;
- (AGSGraphic *)pinAtPoint:(AGSPoint *)point identifier:(NSString *)identifier;
- (AGSGraphic *)pinAtPoint:(AGSPoint *)point info:(NSDictionary *)info;
- (AGSGraphic *)pinAtPoint:(AGSPoint *)point info:(NSDictionary *)info icon:(UIImage *)icon;
- (AGSGraphic *)pinAtPoint:(AGSPoint *)point info:(NSDictionary *)info image:(UIImage *)img;
- (void)removePinAtByInfo:(NSDictionary *)info;
- (void)removePinByIdentifier:(NSString *)identifier;
- (void)clearAllOverlaies;
- (AGSGraphic *)addMultiPinsAtPoints:(NSArray <AGSPoint *> *)points;

// 获得graphic里的所有点
+ (NSArray <AGSPoint *> *)pointsInGraphic:(AGSGraphic *)graphic;

//选择
- (void)selectGraphic:(AGSGraphic *)graphic;
- (void)unSelectGraphic:(AGSGraphic *)graphic;

// 地址
- (void)reverseGeocodeInPoint:(AGSPoint *)point completion:(void(^)(NSString *province,NSString *city,NSString *zone,NSString *address,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
