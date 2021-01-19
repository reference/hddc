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
//  表单数据库存储对象
/**
只要在自己的类中导入了BGFMDB.h这个头文件,本类就具有了存储功能.
*/
#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXTable : NSObject <NSMutableCopying>

/// rowid
@property (nonatomic, strong) NSString *rowid;

/// 所属的用户
@property (nonatomic, strong) NSString *userId;

/// 数据库表的名称 24个forum
@property (nonatomic, strong) NSString *tableName;

/// task id
@property (nonatomic, strong) NSString *taskId;

/// project id
@property (nonatomic, strong) NSString *projectId;

/// type 从1到24 表单类型
@property (nonatomic, assign) NSInteger type;

/// 转换成jsonstring以后的数据 参考`encodeToStringWithModel`和`decodeFromString`进行编解码
@property (nonatomic, strong) NSString *encodedData;

/// 把模型转换成字符串
/// @param model 任意模型
//+ (NSString *)encodeToStringWithModel:(id)model;

/// 把字符串转换成字典
/// @param str 字符串
//+ (NSDictionary *)decodeFromString:(NSString *)str;

/// 根据24个表单类型获取他们在本地数据库中存的名字
/// @param type type
+ (NSString *)tableNameOfType:(NSInteger)type;

/// 解析出表里的数据 成为表单模型类
/// @param tb table
+ (id)decodeDataInTable:(YXTable *)tb;

/// 查询所有相关的数据
/// @param tName 表名称
/// @param tId task id
/// @param pId project id
/// @param type type 1~24
+ (NSArray <YXTable *> *)findTablesByName:(NSString *)tName taskId:(NSString *)tId projectId:(NSString *)pId type:(NSInteger)type userId:(NSString *)uId;

/// 查询所有没有指定项目和任务的表
/// @param uId userid
/// @param type 1到24
+ (NSArray <YXTable *> *)findTablesWithoutBelongByUserId:(NSString *)uId forumType:(NSInteger)type;

/// <#Description#>
/// @param tName <#tName description#>
/// @param uId <#uId description#>
+ (NSArray <YXTable *> *)findTablesByName:(NSString *)tName userId:(NSString *)uId;
+ (NSArray <YXTable *> *)findTablesByName:(NSString *)tName taskId:(NSString *)tid userId:(NSString *)uId;

/// 查询某个用户所有本地表单
/// @param uId userid
+ (NSArray <YXTable *> *)findAllLocalForumWithUserId:(NSString *)uId;

/// 根据row id删除
/// @param rowId rowid
+ (BOOL)deleteRowById:(NSString *)rowId;

@end

NS_ASSUME_NONNULL_END
