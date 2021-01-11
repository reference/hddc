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
#import "AGSGoogleMapLayer.h"

//加载Google遥感图
//http://mt0.google.cn/vt/lyrs=s@92?&v=w2.114&hl=zh-CN&gl=cn&x=0&y=0&z=0&s=Galil
//
////加载Google地形图
//http://mt0.google.cn/vt/lyrs=t@128?&v=w2.114&hl=zh-CN&gl=cn&x=0&y=0&z=0&s=Galil
//
////加载Google街道图
//http://mt0.google.cn/vt/lyrs=m@161000000?&v=w2.114&hl=zh-CN&gl=cn&x=0&y=0&z=0&s=Galil

#define kURLGetTile @"http://mt0.google.cn/vt/lyrs=%@?v=w2.114&hl=zh-CN&gl=cn&x=%ld&y=%ld&z=%ld&s=G"

#define X_MIN_MERCATOR -20037508.3427892
#define Y_MIN_MERCATOR -20037508.3427892
#define X_MAX_MERCATOR 20037508.3427892
#define Y_MAX_MERCATOR 20037508.3427892

#define X_MIN_2000 -180.0
#define Y_MIN_2000 -90.0
#define X_MAX_2000 180.0
#define Y_MAX_2000 90.0

#define _minZoomLevel 0
#define _maxZoomLevel 16
#define _tileWidth 256
#define _tileHeight 256
#define _dpi 96

#define _WebMercator 102100
#define _GCS2000 2000

@interface AGSGoogleMapLayerInfo()
@property(nonatomic,strong)NSString *layername;
@property(nonatomic,strong)NSString *tilematrixset;
@property(nonatomic,strong)AGSSpatialReference *sp;
@property(nonatomic,strong)AGSPoint *origin;
@property(nonatomic,strong)NSMutableArray *lods;
@end

@implementation AGSGoogleMapLayerInfo

-(instancetype)initWithLayerType:(AGSGoogleMapLayerType)type
{
    if (self = [super init]) {
        switch (type) {
            case GoogleMap_VECTOR:
                self.layername = @"s";
                break;
            case GoogleMap_IMAGE:
                self.layername = @"m@158000000";
                break;
            case GoogleMap_TERRAIN:
                self.layername = @"t@131,r@227000000";
                break;
            case GoogleMap_ANNOTATION:
                self.layername = @"h@169000000";
                break;
            default:
                break;
        }
        
        [self setSpatialReference];
        self.tileInfo = [self getAGSGoogleMapLayerInfo];
    }
    
    return self;
    
}

-(void)setSpatialReference{
    self.lods = [[NSMutableArray alloc] init];
    
    double _baseScale = 2.958293554545656E8;
    double _baseRelu = 78271.51696402048;
    
    self.sp = [AGSSpatialReference spatialReferenceWithWKID:_WebMercator];
    self.origin = [AGSPoint pointWithX:X_MIN_MERCATOR y:Y_MAX_MERCATOR spatialReference:self.sp];
    self.fullExtent = [AGSEnvelope envelopeWithXMin:X_MIN_MERCATOR yMin:Y_MIN_MERCATOR xMax:X_MAX_MERCATOR yMax:Y_MAX_MERCATOR spatialReference:self.sp];
    _baseRelu = 78271.51696402048;
    
    //build lods for loop from 0 to 17 level
    for(int i= 0; i<=17 ;i++){
        AGSLevelOfDetail *level = [AGSLevelOfDetail levelOfDetailWithLevel:i resolution:_baseRelu scale:_baseScale];
        [self.lods addObject:level];
        
        _baseRelu = _baseRelu / 2;
        _baseScale = _baseScale /2;
    }
}

-(AGSTileInfo*)getAGSGoogleMapLayerInfo
{
    AGSTileInfo *tileInfo = [AGSTileInfo tileInfoWithDPI:_dpi
                                                  format:AGSTileImageFormatPNG32
                                          levelsOfDetail:self.lods
                                                  origin:self.origin
                                        spatialReference:self.sp
                                              tileHeight:_tileHeight
                                               tileWidth:_tileWidth];
    return tileInfo;
}

-(NSString *)getGoogleMapServiceURLWithX:(NSInteger)x Y:(NSInteger)y Z:(NSInteger)z{
    return [NSString stringWithFormat:kURLGetTile,self.layername,x,y,z];
}

@end

#pragma mark - google map layer

@implementation AGSGoogleMapLayer

-(instancetype)initWithAGSGoogleMapLayerInfo:(AGSGoogleMapLayerInfo *)info{
    
    self = [super initWithTileInfo:info.tileInfo fullExtent:info.fullExtent];
    
    __weak AGSGoogleMapLayer *weakLtl = self;
    
    [self setTileRequestHandler:^(AGSTileKey *tileKey) {
        
        // get an image – probably from a network request…
        NSString *requestUrl = [info getGoogleMapServiceURLWithX:tileKey.column Y:tileKey.row Z:(tileKey.level + 1)];
        
//        NSLog(@"%@",requestUrl);
        
        NSURL* aURL = [NSURL URLWithString:requestUrl];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:aURL];
        
        UIImage *img = [UIImage imageWithData:imageData];
        
        // once we have the tile image here is where we give the tiled layer the image for the requested tile...
        [weakLtl respondWithTileKey:tileKey data:UIImagePNGRepresentation(img) error:nil];
    }];

    return self;
}

+ (void)loadAGSGoogleMapLayer:(AGSMap *)map type:(AGSGoogleMapLayerType)type
{
    [map.basemap.baseLayers removeAllObjects];
    
//    AGSGoogleMapLayerInfo *info = [[AGSGoogleMapLayerInfo alloc] initWithLayerType:type];
    AGSGoogleMapLayerInfo *aInfo = [[AGSGoogleMapLayerInfo alloc] initWithLayerType:type];
    
//    AGSGoogleMapLayer *ltl1 = [[AGSGoogleMapLayer alloc] initWithAGSGoogleMapLayerInfo:info];
    AGSGoogleMapLayer *ltl2 = [[AGSGoogleMapLayer alloc] initWithAGSGoogleMapLayerInfo:aInfo];
    
//    [map.basemap.baseLayers addObject:ltl1];
    [map.basemap.baseLayers addObject:ltl2];
}

@end
