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
//  定义了点 线 面的存储模式
#import <Foundation/Foundation.h>
#import <ArcGIS/ArcGIS.h>

typedef enum {
    GraphicType_None = 0,
    GraphicType_Point,//点
    GraphicType_Line,//线
    GraphicType_Polygon //面
}GraphicType;

NS_ASSUME_NONNULL_BEGIN

@interface BDArcGISGraphic : NSObject

/// 绘画的类型
@property (nonatomic, assign) GraphicType type;

/// graphic
@property (nonatomic, strong, readwrite) AGSGraphic *graphic;

/**
 规则：
 点与点之间的分隔用分号

 点：type||point:经度+逗号+分号+经度+逗号+分号...
 例如：...

 线：type||line:经度+逗号+分号+经度+逗号+分号...
 例如：type||line:116.381538242149,39.98519742796076;116.3818673141602,39.9808192477578;116.3868333099661,39.98108286340378;...

 面：type||polygon:经度+逗号+分号+经度+逗号+分号...
 例如：ype||polygon:116.383288306936,39.98479629747063;116.3831686443865,39.98569024219583;...
 
 */
- (NSString *)encode;

/// 多graphic编码，编码格式参考本类- (NSString *)encode;
/// @param graphics 数组
+ (NSString *)multiEncodeByGraphics:(NSArray <BDArcGISGraphic *> *)graphics;

/**
 *type||polygon:116.383288306936,39.98479629747063;116.3831686443865,39.98569024219583;116.3856366844707,39.98546102671475;116.386205081581,39.98340951391617;116.3863845754054,39.98205708631433;116.383288306936,39.98479629747063;type||line:116.381538242149,39.98519742796076;116.3818673141602,39.9808192477578;116.3868333099661,39.98108286340378;
 */
+ (NSArray <BDArcGISGraphic *> *)decodeMapInfo:(NSString *)mapInfo;
@end

NS_ASSUME_NONNULL_END
