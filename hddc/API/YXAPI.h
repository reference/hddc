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

#if DEBUG
//#define YX_HOST @"http://10.19.7.231:8086/hdc"
#define YX_HOST @"http://10.19.41.110:8086/hdc"
//#define YX_HOST @"http://113.200.69.213/hddc"
#else
#define YX_HOST @"http://10.19.41.110:8086/hdc"
#endif

#define HOST @"192.168.1.128"

#import "YXHTTP.h"

//存储对象 存储到数据库的对象
#import "YXTable.h"

//获取基础数据
#import "GPAdministrativeDivisionsModel.h"

//用户
#import "YXUserModel.h"
#import "YXUserLoginModel.h"
#import "YXUserUpdatePasswordModel.h"

//表单
#import "YXSlectionDictModel.h"
#import "YXTrenchModel.h"
#import "YXGeologicalSvyPlanningLineModel.h"
#import "YXGeologicalSvyPlanningPtModel.h"
#import "YXFaultSvyPointModel.h"
#import "YXGeoGeomorphySvyPointModel.h"
#import "YXGeologicalSvyLineModel.h"
#import "YXGeologicalSvyPointModel.h"
#import "YXStratigraphySvyPointModel.h"
#import "YXGeomorphySvyLineModel.h"
#import "YXGeomorphySvyPointModel.h"
#import "YXGeomorphySvyRegionModel.h"
#import "YXGeomorphySvyReProfModel.h"
#import "YXGeomorphySvySamplePointModel.h"
#import "YXGeomorStationModel.h"
#import "YXDrillHoleModel.h"
#import "YXSamplePointModel.h"
#import "YXGeophySvyLineModel.h"
#import "YXGeophySvyPointModel.h"
#import "YXGeochemicalSvyLineModel.h"
#import "YXGeochemicalSvyPointModel.h"
#import "YXCraterModel.h"
#import "YXLavaModel.h"
#import "YXVolcanicSamplePointModel.h"
#import "YXVolcanicSvyPointModel.h"
#import "YXForumSaver.h"
#import "YXForumDataInfoModel.h"

//轨迹采集
#import "YXTracePointModel.h"


//项目
#import "YXProjectModel.h"

//任务
#import "YXTaskModel.h"

//表单列表
#import "YXFormListModel.h"

// 上传图片
#import "YXUpdateImagesModel.h"

