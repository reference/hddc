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
#import "BDArcGISGraphic.h"
#import "BDArcGISUtil.h"

@implementation BDArcGISGraphic

- (NSString *)encode
{
    NSArray *points = [BDArcGISUtil pointsInGraphic:self.graphic];
    NSMutableString *string = [NSMutableString string];
    for (AGSPoint *point in points) {
        CLLocationCoordinate2D coordinate = [point toCLLocationCoordinate2D];
        NSNumber *longitude = [NSNumber numberWithDouble:coordinate.longitude];
        NSNumber *latitude = [NSNumber numberWithDouble:coordinate.latitude];
        [string appendFormat:@"%@,%@;",longitude,latitude];
    }
    return string;
}

+ (NSString *)multiEncodeByGraphics:(NSArray <BDArcGISGraphic *> *)graphics
{
    if (graphics && graphics.count) {
        NSMutableString *string = [NSMutableString string];
        for (BDArcGISGraphic *graphic in graphics) {
            NSString *encodeStr = [graphic encode];
            switch (graphic.type) {
                case GraphicType_Point:
                {
                    [string appendFormat:@"type||point:%@",encodeStr];
                }
                    break;
                case GraphicType_Line:
                {
                    [string appendFormat:@"type||line:%@",encodeStr];
                }
                    break;
                case GraphicType_Polygon:
                {
                    [string appendFormat:@"type||polygon:%@",encodeStr];
                }
                    break;
                default:
                    break;
            }
        }
        return string;
    }return nil;
}

+ (NSArray <BDArcGISGraphic *> *)decodeMapInfo:(NSString *)mapInfo
{
    if (mapInfo.length) {
        NSMutableArray *bdArcGisGraphics = [NSMutableArray array];
        NSArray *types = [mapInfo componentsSeparatedByString:@"type||"];
        for (NSString *type in types) {
            if (type.length == 0) {
                continue;
            }
            BDArcGISGraphic *bdGraphic = [BDArcGISGraphic new];

            if ([type hasPrefix:@"line:"]) {
                //线条
                bdGraphic.type = GraphicType_Line;
                
                NSString *pointsStr = [type substringFromIndex:@"line:".length];
                NSArray *points = [pointsStr componentsSeparatedByString:@";"];
                NSMutableArray *agsPoints = [NSMutableArray array];
                for (NSString *pointStr in points) {
                    if (pointStr.length) {
                        NSArray *pointArr = [pointStr componentsSeparatedByString:@","];
                        NSNumber *longtitude = pointArr.firstObject;
                        NSNumber *latitude = pointArr.lastObject;
                        
                        AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([latitude doubleValue], [longtitude doubleValue])];
                        [agsPoints addObject:point];
                    }
                }
                AGSGraphic *graphic = [BDArcGISUtil buildMultiLinesByPoints:agsPoints];
                bdGraphic.graphic = graphic;
            }else if ([type hasPrefix:@"polygon:"]) {
                //面
                bdGraphic.type = GraphicType_Polygon;
                
                NSString *pointsStr = [type substringFromIndex:@"polygon:".length];
                NSArray *points = [pointsStr componentsSeparatedByString:@";"];
                NSMutableArray *agsPoints = [NSMutableArray array];
                for (NSString *pointStr in points) {
                    if (pointStr.length) {
                        NSArray *pointArr = [pointStr componentsSeparatedByString:@","];
                        NSNumber *longtitude = pointArr.firstObject;
                        NSNumber *latitude = pointArr.lastObject;
                        
                        AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([latitude doubleValue], [longtitude doubleValue])];
                        [agsPoints addObject:point];
                    }
                }
                AGSGraphic *graphic = [BDArcGISUtil buildPolygonWithPoints:agsPoints];
                bdGraphic.graphic = graphic;
                
            }else{
                //点
            }
            //
            if (type.length) {
                [bdArcGisGraphics addObject:bdGraphic];
            }
        }
        return bdArcGisGraphics;
    }
    return nil;
}

+ (void)loadGeoJsonFileAtPath:(NSURL *)path
{
    if (path != nil) {
        NSMutableArray *bdArcGisGraphics = [NSMutableArray array];
        NSData *jsonData = [NSData dataWithContentsOfFile:path.absoluteString];
        if (jsonData == nil) {
            NSLog(@"json data is nil");
            return;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if (dic) {
            ///@see https://geojson.org/
            // 解析 GeometryCollection
            if ([dic[@"type"] isEqualToString:@"GeometryCollection"]) {
                NSArray *geometries = dic[@"geometries"];
                for (int i=0;i<geometries.count;i++) {
                    // too big will crash
                    if (i == 100000) {
                        break;
                    }
                    NSDictionary *geometrie = geometries[i];
                    NSString *type = geometrie[@"type"];
                    //Point, LineString, Polygon, MultiPoint, MultiLineString,MultiPolygon
                    if ([type isEqualToString:@"Point"]) {
                        NSArray *pt = geometrie[@"coordinates"];
                        
                        AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([pt.lastObject doubleValue], [pt.firstObject doubleValue])];
                        
                        [[BDArcGISUtil ins] drawPoint:point];
                        NSLog(@"lat:%.6f lon:%.6f",[pt.lastObject doubleValue],[pt.firstObject doubleValue]);
                    }
                    else if ([type isEqualToString:@"LineString"]) {
                        NSMutableArray *linePoints = [NSMutableArray array];
                        NSArray <NSArray *> *pts = geometrie[@"coordinates"];
                        for (NSArray *latLonPts in pts) {
                            AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([latLonPts.lastObject doubleValue], [latLonPts.firstObject doubleValue])];
                            [linePoints addObject:point];
                        }
                        //draw line
                        [[BDArcGISUtil ins] drawMultiLinesByPoints:linePoints];
                    }
                    else if ([type isEqualToString:@"Polygon"]) {
                        NSMutableArray *polyPoints = [NSMutableArray array];
                        NSArray <NSArray *> *pts = geometrie[@"coordinates"];
                        for (NSArray *allPoints in pts) {
                            for (NSArray *latLonPts in allPoints) {
                                AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([latLonPts.lastObject doubleValue], [latLonPts.firstObject doubleValue])];
                                [polyPoints addObject:point];
                            }
                        }
                        //draw polygon
                        [[BDArcGISUtil ins] drawPolygonWithPoints:polyPoints];
                    }
                    else if ([type isEqualToString:@"MultiPoint"]) {
                        
                    }
                    else if ([type isEqualToString:@"MultiLineString"]) {
                        
                    }
                    else if ([type isEqualToString:@"MultiPolygon"]) {
                        
                    }
                }
            }
            // 解析 FeatureCollection
            if ([dic[@"type"] isEqualToString:@"FeatureCollection"]) {
                NSArray *features = dic[@"features"];
                for (int i=0;i<features.count;i++) {
                    NSDictionary *feature = features[i];
                    NSString *type = feature[@"type"];
                    if ([type isEqualToString:@"Feature"]) {
                        NSDictionary *geometry = feature[@"geometry"];
                        type = geometry[@"type"];
                        //Point, LineString, Polygon, MultiPoint, MultiLineString,MultiPolygon
                        if ([type isEqualToString:@"Point"]) {
                            NSArray *pt = geometry[@"coordinates"];
                            
                            AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([pt.lastObject doubleValue], [pt.firstObject doubleValue])];
                            
                            [[BDArcGISUtil ins] drawPoint:point];
                            NSLog(@"lat:%.6f lon:%.6f",[pt.lastObject doubleValue],[pt.firstObject doubleValue]);
                        }
                        else if ([type isEqualToString:@"LineString"]) {
                            NSMutableArray *linePoints = [NSMutableArray array];
                            NSArray <NSArray *> *pts = geometry[@"coordinates"];
                            for (NSArray *latLonPts in pts) {
                                AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([latLonPts.lastObject doubleValue], [latLonPts.firstObject doubleValue])];
                                [linePoints addObject:point];
                            }
                            //draw line
                            [[BDArcGISUtil ins] drawMultiLinesByPoints:linePoints];
                        }
                        else if ([type isEqualToString:@"Polygon"]) {
                            NSMutableArray *polyPoints = [NSMutableArray array];
                            NSArray <NSArray *> *pts = geometry[@"coordinates"];
                            for (NSArray *allPoints in pts) {
                                for (NSArray *latLonPts in allPoints) {
                                    AGSPoint *point = [AGSPoint pointWithCLLocationCoordinate2D:CLLocationCoordinate2DMake([latLonPts.lastObject doubleValue], [latLonPts.firstObject doubleValue])];
                                    [polyPoints addObject:point];
                                }
                            }
                            //draw polygon
                            [[BDArcGISUtil ins] drawPolygonWithPoints:polyPoints];
                        }
                        else if ([type isEqualToString:@"MultiPoint"]) {
                            
                        }
                        else if ([type isEqualToString:@"MultiLineString"]) {
                            
                        }
                        else if ([type isEqualToString:@"MultiPolygon"]) {
                            
                        }
                    }
                }
            }
        }
    }
}
@end
