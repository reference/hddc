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
#import "BDArcGISUtil.h"

#define color_line [UIColor colorNamed:@"color_light_blue"]
//#define color_line [UIColor redColor]

@implementation BDArcGISUtil

- (id)init
{
    if (self = [super init]) {
        _graphicsOverlay = [[AGSGraphicsOverlay alloc] init];
        _graphicsOverlay.selectionColor = [AGSColor orangeColor];
    }return self;;
}

+ (BDArcGISUtil *)ins
{
    static BDArcGISUtil *o;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        o = [[self alloc] init];
    });
    return o;
}

#pragma mark - Draw utils

- (AGSGraphic *)drawPointWithLatitude:(CLLocationDegrees )latitude longitude:(CLLocationDegrees )longitude
{
    AGSSpatialReference *ref = [AGSSpatialReference WGS84];

    /// Add a point graphic 点
    // Create a point geometry.
    AGSPoint *point = [[AGSPoint alloc] initWithX:longitude y:latitude spatialReference:ref];
    // Create point symbol with outline.
    AGSSimpleMarkerSymbol *symbol = [[AGSSimpleMarkerSymbol alloc] initWithStyle:AGSSimpleMarkerSymbolStyleCircle color:[UIColor blueColor] size:3];
    symbol.outline = [[AGSSimpleLineSymbol alloc] initWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:2.0];
    // Create point graphic with geometry & symbol.
    AGSGraphic *pointGraphic = [[AGSGraphic alloc] initWithGeometry:point symbol:symbol attributes:nil];
    // Add point graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:pointGraphic];

    return pointGraphic;
}

- (AGSGraphic *)drawPointWithCoordinate2D:(CLLocationCoordinate2D )coordinate
{
    AGSSpatialReference *ref = [AGSSpatialReference WGS84];

    /// Add a point graphic 点
    // Create a point geometry.
    AGSPoint *point = [[AGSPoint alloc] initWithX:coordinate.longitude y:coordinate.latitude spatialReference:ref];
    // Create point symbol with outline.
    AGSSimpleMarkerSymbol *symbol = [[AGSSimpleMarkerSymbol alloc] initWithStyle:AGSSimpleMarkerSymbolStyleCircle color:[UIColor blueColor] size:3];
    symbol.outline = [[AGSSimpleLineSymbol alloc] initWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:2.0];
    // Create point graphic with geometry & symbol.
    AGSGraphic *pointGraphic = [[AGSGraphic alloc] initWithGeometry:point symbol:symbol attributes:nil];
    // Add point graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:pointGraphic];
    return pointGraphic;
}

- (AGSGraphic *)drawPoint:(AGSPoint *)point
{
    /// Add a point graphic 点
    // Create point symbol with outline.
    AGSSimpleMarkerSymbol *symbol = [AGSSimpleMarkerSymbol simpleMarkerSymbolWithStyle:AGSSimpleMarkerSymbolStyleCircle color:color_line size:3];
    symbol.outline = [AGSSimpleLineSymbol simpleLineSymbolWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:2.0];
    // Create point graphic with geometry & symbol.
    AGSGraphic *pointGraphic = [[AGSGraphic alloc] initWithGeometry:point symbol:symbol attributes:nil];
    // Add point graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:pointGraphic];
    return pointGraphic;
}

- (void)drawLineWithStartPoint:(AGSPoint *)startPoint endPoint:(AGSPoint *)endPoint
{
//    AGSSpatialReference *ref = [AGSSpatialReference WGS84];
    AGSPolyline *polyline = [AGSPolyline polylineWithPoints:@[startPoint,endPoint]];
    // Create symbol for polyline.
    AGSSimpleLineSymbol *lineSymbol = [[AGSSimpleLineSymbol alloc] initWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:3.0];
    // Create a polyline graphic with geometry and symbol.
    AGSGraphic *polylineGraphic = [[AGSGraphic alloc] initWithGeometry:polyline symbol:lineSymbol attributes:nil];
    // Add polyline to graphics overlay.
    [self.graphicsOverlay.graphics addObject:polylineGraphic];
}

- (void)drawPoints:(NSArray <AGSPoint *> *)points
{
    for (AGSPoint *point in points) {
        [self drawPoint:point];
    }
}

//line

- (AGSGraphic *)drawMultiLinesByPoints:(NSArray <AGSPoint *> *)points
{
    AGSPolyline *polyline = [AGSPolyline polylineWithPoints:points];
    // Create symbol for polyline.
    AGSSimpleLineSymbol *lineSymbol = [AGSSimpleLineSymbol simpleLineSymbolWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:3.0];
    // Create a polyline graphic with geometry and symbol.
    AGSGraphic *polylineGraphic = [AGSGraphic graphicWithGeometry:polyline symbol:lineSymbol attributes:nil];
    // Add polyline to graphics overlay.
    [self.graphicsOverlay.graphics addObject:polylineGraphic];
    return polylineGraphic;
}

+ (AGSGraphic *)buildMultiLinesByPoints:(NSArray <AGSPoint *> *)points
{
    AGSPolyline *polyline = [AGSPolyline polylineWithPoints:points];
    // Create symbol for polyline.
    AGSSimpleLineSymbol *lineSymbol = [AGSSimpleLineSymbol simpleLineSymbolWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:3.0];
    // Create a polyline graphic with geometry and symbol.
    AGSGraphic *polylineGraphic = [AGSGraphic graphicWithGeometry:polyline symbol:lineSymbol attributes:nil];
    return polylineGraphic;
}

//polygon
- (AGSGraphic *)drawPolygonWithPoints:(NSArray <AGSPoint *> *)points
{
    ///Add a polygon graphic 多边形
    AGSPolygon *polygon = [AGSPolygon polygonWithPoints:points];
    // Create symbol for polygon with outline.
    AGSSimpleLineSymbol *outline = [AGSSimpleLineSymbol simpleLineSymbolWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:2.0];
    AGSSimpleFillSymbol *fillSybole = [AGSSimpleFillSymbol simpleFillSymbolWithStyle:AGSSimpleFillSymbolStyleSolid color:[UIColor colorWithString:@"5EB8FC" alpha:0.3] outline:outline];
    // Create polygon graphic with geometry and symbol.
    AGSGraphic *polygonGraphic = [AGSGraphic graphicWithGeometry:polygon symbol:fillSybole attributes:nil];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:polygonGraphic];
    return polygonGraphic;
}

+ (AGSGraphic *)buildPolygonWithPoints:(NSArray <AGSPoint *> *)points
{
    ///Add a polygon graphic 多边形
    AGSPolygon *polygon = [AGSPolygon polygonWithPoints:points];
    // Create symbol for polygon with outline.
    AGSSimpleLineSymbol *outline = [AGSSimpleLineSymbol simpleLineSymbolWithStyle:AGSSimpleLineSymbolStyleSolid color:color_line width:2.0];
    AGSSimpleFillSymbol *fillSybole = [AGSSimpleFillSymbol simpleFillSymbolWithStyle:AGSSimpleFillSymbolStyleSolid color:[UIColor colorWithString:@"5EB8FC" alpha:0.3] outline:outline];
    // Create polygon graphic with geometry and symbol.
    AGSGraphic *polygonGraphic = [AGSGraphic graphicWithGeometry:polygon symbol:fillSybole attributes:nil];
    return polygonGraphic;
}

- (void)romovePolygonGraphic:(AGSGraphic *)graphic
{
    [self.graphicsOverlay.graphics removeObject:graphic];
}

- (void)drawMultiPolygonWithPointsGroup:(NSArray <NSArray <AGSPoint *> *> *)group
{
    for (NSArray *points in group) {
        [self drawPolygonWithPoints:points];
    }
}

#pragma mark - draw overlay

- (void)drawGraphics:(NSArray <BDArcGISGraphic *> *)graphics
{
    for (BDArcGISGraphic *graphic in graphics) {
        switch (graphic.type) {
            case GraphicType_Point:
                
                break;
            case GraphicType_Line:
                [self drawMultiLinesByPoints:[BDArcGISUtil pointsInGraphic:graphic.graphic]];
                break;
            case GraphicType_Polygon:
                [self drawPolygonWithPoints:[BDArcGISUtil pointsInGraphic:graphic.graphic]];
                break;
            default:
                break;
        }
    }
}

#pragma mark - pin

- (AGSGraphic *)pinAtPoint:(AGSPoint *)point
{
    //要展示的图片
    UIImage *image = __IMG(@"icon-pin");
    AGSPictureMarkerSymbol *pictureMarkerSymbol  = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:image];
    pictureMarkerSymbol.width =
    pictureMarkerSymbol.height = 30;
    //设置属性值  用于传参  在代理方法中可以获取到
    AGSGraphic *graphic = [AGSGraphic graphicWithGeometry:point symbol:pictureMarkerSymbol attributes:nil];
    // add render
    self.graphicsOverlay.renderer = [AGSSimpleRenderer simpleRendererWithSymbol:pictureMarkerSymbol];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:graphic];
    return graphic;
}

- (AGSGraphic *)pinAtPoint:(AGSPoint *)point identifier:(NSString *)identifier
{
    //要展示的图片
    UIImage *image = __IMG(@"icon-pin-mini");
    AGSPictureMarkerSymbol *pictureMarkerSymbol  = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:image];
    pictureMarkerSymbol.width =
    pictureMarkerSymbol.height = 20;
    //设置属性值  用于传参  在代理方法中可以获取到
    AGSGraphic *graphic = [AGSGraphic graphicWithGeometry:point symbol:pictureMarkerSymbol attributes:@{@"id":identifier}];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:graphic];
    return graphic;
}

- (AGSGraphic *)pinAtPoint:(AGSPoint *)point info:(NSDictionary *)info
{
    //要展示的图片
    UIImage *image = __IMG(@"icon-forum");
    AGSPictureMarkerSymbol *pictureMarkerSymbol  = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:image];
    pictureMarkerSymbol.width =
    pictureMarkerSymbol.height = 20;
    //设置属性值  用于传参  在代理方法中可以获取到
    AGSGraphic *graphic = [AGSGraphic graphicWithGeometry:point symbol:pictureMarkerSymbol attributes:info];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:graphic];
    return graphic;
}

- (AGSGraphic *)pinAtPoint:(AGSPoint *)point info:(NSDictionary *)info icon:(UIImage *)icon
{
    AGSPictureMarkerSymbol *pictureMarkerSymbol  = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:icon];
    pictureMarkerSymbol.width =
    pictureMarkerSymbol.height = 20;
    //设置属性值  用于传参  在代理方法中可以获取到
    AGSGraphic *graphic = [AGSGraphic graphicWithGeometry:point symbol:pictureMarkerSymbol attributes:info];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:graphic];
    return graphic;
}

- (AGSGraphic *)pinAtPoint:(AGSPoint *)point info:(NSDictionary *)info image:(UIImage *)image
{
    AGSPictureMarkerSymbol *pictureMarkerSymbol  = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:image];
    pictureMarkerSymbol.width =
    pictureMarkerSymbol.height = 20;
    //设置属性值  用于传参  在代理方法中可以获取到
    AGSGraphic *graphic = [AGSGraphic graphicWithGeometry:point symbol:pictureMarkerSymbol attributes:info];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:graphic];
    return graphic;
}

- (void)removePinAtByInfo:(NSDictionary *)info
{
    [self removePinByIdentifier:info[@"id"]];
}

- (void)removePinByIdentifier:(NSString *)identifier
{
    for (AGSGraphic *graphic in self.graphicsOverlay.graphics) {
        NSDictionary *attri = graphic.attributes;
        if (attri && [attri[@"id"] isEqual:identifier]) {
            [self.graphicsOverlay.graphics removeObject:graphic];
            break;
        }
    }
}

- (void)clearAllOverlaies
{
    [self.graphicsOverlay.graphics removeAllObjects];
}

+ (NSArray <AGSPoint *> *)pointsInGraphic:(AGSGraphic *)graphic
{
    AGSMultipart *multiPart = (AGSMultipart *)graphic.geometry;
    AGSPolyline *pline = nil;
    if ([multiPart isKindOfClass:AGSPolygon.class]) {
        AGSPolygon *polygonR = (AGSPolygon *)multiPart;
        pline = [polygonR toPolyline];
    }else{
        pline = (AGSPolyline *)multiPart;
    }
    AGSPartCollection *partsC = pline.parts;
    NSArray *parts = [partsC array];
    AGSPart *firstPart = parts.firstObject;
    AGSPointCollection *pointC = firstPart.points;
    return pointC.array;
}

- (AGSGraphic *)addMultiPinsAtPoints:(NSArray <AGSPoint *> *)points
{
    //创建点状符号
//        AGSSimpleMarkerSymbol *myMarkerSymbol =     [AGSSimpleMarkerSymbol simpleMarkerSymbol];
//        myMarkerSymbol.color = [UIColor blueColor];
//        multiPoint = [[AGSMutableMultipoint alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
//        //创建点形状
//        AGSPoint* point  = [AGSPoint pointWithX:112.29 y:34.94 spatialReference:nil];
//        //    [ performSelector:@selector(setst:) withObject:point afterDelay:0.1];
//        [multiPoint addPoint: point];
//        [multiPoint addPoint: [AGSPoint pointWithX:114.29 y:34.94 spatialReference:nil]];
//        [multiPoint addPoint: [AGSPoint pointWithX:116.29 y:34.94 spatialReference:nil]];
//
//
//        //组装点要素
//        myGraphic = [AGSGraphic graphicWithGeometry:multiPoint
//                                                  symbol:myMarkerSymbol          attributes:nil   infoTemplateDelegate:self];
    
    //要展示的图片
    UIImage *image = __IMG(@"icon-pin");
    AGSPictureMarkerSymbol *pictureMarkerSymbol  = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:image];
    pictureMarkerSymbol.width =
    pictureMarkerSymbol.height = 30;
    //multi points
    AGSPictureFillSymbol *fill = [AGSPictureFillSymbol pictureFillSymbolWithImage:image];

    //设置属性值  用于传参  在代理方法中可以获取到
    AGSGraphic *graphic = [[AGSGraphic alloc] initWithGeometry:points symbol:pictureMarkerSymbol attributes:nil];

    // add render
    self.graphicsOverlay.renderer = [AGSSimpleRenderer simpleRendererWithSymbol:pictureMarkerSymbol];
    // Add polygon graphic to graphics overlay.
    [self.graphicsOverlay.graphics addObject:graphic];
    return graphic;
}

#pragma mark - 选择

- (void)selectGraphic:(AGSGraphic *)graphic
{
    graphic.selected = YES;
}

- (void)unSelectGraphic:(AGSGraphic *)graphic
{
    graphic.selected = NO;
}


- (void)reverseGeocodeInPoint:(AGSPoint *)point completion:(void(^)(NSString *province,NSString *city,NSString *zone,NSString *address,NSError *error))completion
{
    //22.540681,=114.061324
    CLLocation *newLocation=[[CLLocation alloc]initWithLatitude:point.toCLLocationCoordinate2D.latitude longitude: point.toCLLocationCoordinate2D.longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks,
                                       NSError *error)
     {
         CLPlacemark *placemark=[placemarks objectAtIndex:0];
         NSLog(@"地址:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@ \n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",
               placemark.name,
               placemark.country,
               placemark.postalCode,
               placemark.ISOcountryCode,
               placemark.ocean,
               placemark.inlandWater,
               placemark.administrativeArea,
               placemark.subAdministrativeArea,
               placemark.locality,
               placemark.subLocality,
               placemark.thoroughfare,
               placemark.subThoroughfare);
        if (completion) {
            NSString *a = [NSString stringWithFormat:@"%@",placemark.thoroughfare?placemark.thoroughfare:placemark.name];
//            NSString *p = [NSString stringWithFormat:@"%@",placemark.locality];
//            NSString *c = [NSString stringWithFormat:@"%@",placemark.administrativeArea];
//            NSString *z = [NSString stringWithFormat:@"%@",placemark.subAdministrativeArea];
            NSDictionary *dic = placemark.addressDictionary;
            NSString *p = dic[@"State"];
            NSString *c = dic[@"City"];
            NSString *z = dic[@"SubLocality"];
            completion((p.length > 0 ? p : c),c,z,a,error);
        }
     }];
}
#pragma mark - test


@end
