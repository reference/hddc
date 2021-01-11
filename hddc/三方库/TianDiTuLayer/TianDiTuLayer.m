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
#import "TianDiTuLayer.h"
#import "TianDiTuLayerInfo.h"

@implementation TianDiTuLayer

-(instancetype)initWithTianDiTuLayerInfo: (TianDiTuLayerInfo *)tdtInfo{
    
    self = [super initWithTileInfo:tdtInfo.tileInfo fullExtent:tdtInfo.fullExtent];
    
    __weak TianDiTuLayer *weakLtl = self;
    
    [self setTileRequestHandler:^(AGSTileKey *tileKey) {
        
        // get an image – probably from a network request…
        NSString *mainURL = [tdtInfo getTianDiTuServiceURL];
        
        NSString *requestUrl1= [mainURL stringByAppendingString:@"&tilecol=%ld&tilerow=%ld&tilematrix=%ld"];
        
        NSString *requestUrl = [NSString stringWithFormat:requestUrl1,tileKey.column,tileKey.row, (tileKey.level + 1)];
        
//        NSLog(@"%@",requestUrl);
        
        NSURL* aURL = [NSURL URLWithString:requestUrl];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:aURL];
        
        UIImage *img = [UIImage imageWithData:imageData];
        
        // once we have the tile image here is where we give the tiled layer the image for the requested tile...
        [weakLtl respondWithTileKey:tileKey data:UIImagePNGRepresentation(img) error:nil];
    }];

    return self;
}

+ (void)load2DTianDiMapLayerInMap:(AGSMap *)map
{
    [map.basemap.baseLayers removeAllObjects];
    //天地图
    TianDiTuLayerInfo *tdtInfo = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_VECTOR SpatialReferenceWKID:TDT_MERCATOR];
    TianDiTuLayerInfo *tdtannoInfo = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_VECTOR LanguageType:TDT_CN SpatialReferenceWKID:TDT_MERCATOR];
    
    TianDiTuLayer *ltl1 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtInfo];
    TianDiTuLayer *ltl2 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtannoInfo];
    
    [map.basemap.baseLayers addObject:ltl1];
    [map.basemap.baseLayers addObject:ltl2];
}

+ (void)loadSatelliteTianDiMapLayerInMap:(AGSMap *)map
{
    [map.basemap.baseLayers removeAllObjects];
    //天地图
    TianDiTuLayerInfo *tdtInfo = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_IMAGE SpatialReferenceWKID:TDT_MERCATOR];
    TianDiTuLayerInfo *tdtannoInfo = [[TianDiTuLayerInfo alloc] initwithlayerType:TDT_IMAGE LanguageType:TDT_CN SpatialReferenceWKID:TDT_MERCATOR];
    
    TianDiTuLayer *ltl1 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtInfo];
    TianDiTuLayer *ltl2 = [[TianDiTuLayer alloc] initWithTianDiTuLayerInfo:tdtannoInfo];
    
    [map.basemap.baseLayers addObject:ltl1];
    [map.basemap.baseLayers addObject:ltl2];
}
@end
