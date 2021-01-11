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
#import "YXTable.h"

#define SeporaterOne @"_?https://scottban.live?_"
#define SeporaterTwo @"?_https://scottban.live_?"

@implementation YXTable

//深拷贝 用于数据库关闭以后页面缓存需要
- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    YXTable *copy = [[[self class] alloc] init];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i++ ) {
        objc_property_t thisProperty = propertyList[i];
        const char* propertyCName = property_getName(thisProperty);
        NSString *propertyName = [NSString stringWithCString:propertyCName encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:propertyName];
        [copy setValue:value forKey:propertyName];
    }
    return copy;
}

// 注意此处需要实现这个函数，因为在通过Runtime获取属性列表时，会获取到一个名字为hash的属性名，这个是系统帮你生成的一个属性
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSString *)encodeToStringWithModel:(id)model
{
    if (model) {
        NSDictionary *dic = [model yy_modelToJSONObject];
        NSMutableString *str = [NSMutableString string];
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            [str appendFormat:@"%@%@%@%@",key,SeporaterOne,dic[key],SeporaterTwo];
        }
        return str;
    }return nil;
}

+ (NSDictionary *)decodeFromString:(NSString *)str
{
    if (str) {
        NSArray *keyValues = [str componentsSeparatedByString:SeporaterTwo];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *keyValue in keyValues) {
            NSArray *keyValueArr = [keyValue componentsSeparatedByString:SeporaterOne];
            NSString *key = keyValueArr.firstObject;
            NSString *value = keyValueArr.lastObject;
            if (key.length>0) {
                [dic setObject:value forKey:key];
            }
        }
        return dic;
    }
    return nil;
}

+ (NSString *)tableNameOfType:(NSInteger)type
{
    return [NSString stringWithFormat:@"YX%@Model",[GPForumType enNameOfType:type]];;
}

+ (id)decodeDataInTable:(YXTable *)tb
{
    //get class
    Class cls = NSClassFromString(tb.tableName);
    //decode data
    NSDictionary *decodedData = [NSJSONSerialization JSONObjectWithData:[tb.encodedData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];;
    
    //使用一个模型代替所有，每个模型都不会被强转
    return [cls yy_modelWithDictionary:decodedData];
}

+ (NSArray <YXTable *> *)findTablesByName:(NSString *)tName taskId:(NSString *)tId projectId:(NSString *)pId type:(NSInteger)type userId:(nonnull NSString *)uId
{
    NSString* where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ and %@=%@ and %@=%@ and %@=%@ "
                       ,bg_sqlKey(@"userId"),bg_sqlValue(uId)
                       ,bg_sqlKey(@"taskId"),bg_sqlValue(tId)
                       ,bg_sqlKey(@"projectId"),bg_sqlValue(pId)
                       ,bg_sqlKey(@"type"),bg_sqlValue(@(type))
                       ,bg_sqlKey(@"tableName"),bg_sqlValue(tName)];
    return [YXTable bg_find:NSStringFromClass(YXTable.class) where:where];
}

+ (NSArray <YXTable *> *)findTablesWithoutBelongByUserId:(NSString *)uId forumType:(NSInteger)type
{
    NSString* where = [NSString stringWithFormat:@"where %@=%@ and %@ is null and %@ is null and %@=%@"
                       ,bg_sqlKey(@"userId"),bg_sqlValue(uId)
                       ,bg_sqlKey(@"taskId")
                       ,bg_sqlKey(@"projectId")
                       ,bg_sqlKey(@"type"),bg_sqlValue(@(type))];
    return [YXTable bg_find:NSStringFromClass(YXTable.class) where:where];
}

/// @param rowId rowid
+ (BOOL)deleteRowById:(NSString *)rowId
{
    return [YXTable bg_delete:NSStringFromClass(YXTable.class) where:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"rowid"),bg_sqlValue(rowId)]];
}
@end
