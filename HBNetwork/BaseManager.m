//
//  BaseManager.m
//  HaloBear
//
//  Created by 刘继丹 on 16/12/7.
//  Copyright © 2016年 刘～丹. All rights reserved.
//

#import "BaseManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <YTKNetconfig.h>

@interface BaseManager()

@property(nonatomic, strong) NSString*imKey;
@property(nonatomic, strong) NSDictionary*headersDic;
@property(nonatomic, strong) NSString*customAppLabel;
@property(nonatomic, strong) NSString*otherAppLabel;

@end

@implementation BaseManager

- (id)init{
    self = [super init];
    if (self) {
        _timeString = [self getTimeString];
        _paramsDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_timeString,@"time", nil];
    }
    return self;
}

+ (BaseManager *)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)configWithImKey:(NSString*)imKey token:(NSString *)token headersDic:(NSDictionary *)headersDic{
    BaseManager.sharedManager.imKey = imKey;
    BaseManager.sharedManager.token = token;
    BaseManager.sharedManager.headersDic = headersDic;
}

+ (void)configWithImKey:(NSString*)imKey token:(NSString *)token customAppLabel:(NSString*)customAppLabel otherAppLabel:(NSString*)otherAppLabel headersDic:(NSDictionary *)headersDic{
    BaseManager.sharedManager.imKey = imKey;
    BaseManager.sharedManager.token = token;
    BaseManager.sharedManager.headersDic = headersDic;
    BaseManager.sharedManager.customAppLabel = customAppLabel;
    BaseManager.sharedManager.otherAppLabel = otherAppLabel;
}

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    
    NSString *imKey = BaseManager.sharedManager.imKey;
    NSString *header = [NSString stringWithFormat:@"Bearer %@",BaseManager.sharedManager.token];

    NSString *paramsStr;

    paramsStr = [self getParamsValueString];
    
    paramsStr = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)paramsStr, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    NSString *md5Str = [self md5Str:paramsStr];
    md5Str = [NSString stringWithFormat:@"%@%@",md5Str,imKey];
    NSString *hashStr = [self getSha256String:md5Str];
    
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[super requestHeaderFieldValueDictionary]];
    [headers setObject:[NSString stringWithFormat:@"%@",hashStr] forKey:@"Http-Request-Halo-Sign"];
    [headers setObject:[NSString stringWithFormat:@"%@",_timeString] forKey:@"Http-Request-Halo-Time"];
    if (BaseManager.sharedManager.customAppLabel != nil && BaseManager.sharedManager.customAppLabel.length != 0) {
         if ([self.baseUrl isEqualToString:YTKNetconfig.shared.getOtherBaseUrl]) {
             [headers setObject:[NSString stringWithFormat:@"%@",BaseManager.sharedManager.otherAppLabel] forKey:@"X-Halo-App"];
         }else{
             [headers setObject:[NSString stringWithFormat:@"%@",BaseManager.sharedManager.customAppLabel] forKey:@"X-Halo-App"];
         }
    }
    [headers setValuesForKeysWithDictionary:BaseManager.sharedManager.headersDic];
    [headers setObject:header forKey:@"Authorization"];
    
    return headers;
    
}

- (NSString *)md5Str:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSString *)getSha256String:(NSString *)srcString {
    
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

-(NSString *)getParamsValueString {
    //字典排序
    NSArray *keys = [_paramsDic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *valueStr = [_paramsDic objectForKey:sortedArray.firstObject];
    for (int i = 0; i < sortedArray.count; i++) {
        if (i == 0) {
            continue;
        }else{
            NSString *value = [_paramsDic objectForKey:sortedArray[i]];
            valueStr = [valueStr stringByAppendingString:value];
        }
    }
    return valueStr;
}

-(NSString *)getTimeString{
    //时间戳 精确到秒
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.0f", a];//转为字符型
    return time;
}

-(void)requestFailedFilter
{
    NSLog(@"❌❌❌接口报错self.responseStatusCode=%ld\n,URL=%@\n,info=%@\n,paramsDic=%@\n",(long)self.responseStatusCode,self.requestUrl,self.responseJSONObject[@"info"],self.paramsDic);
    if (self.requestFailedBlock) {
        self.requestFailedBlock();
    }
}

@end
