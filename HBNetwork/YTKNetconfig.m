//
//  YTKNetconfig.m
//  HaloBear
//
//  Created by 刘继丹 on 16/11/27.
//  Copyright © 2016年 刘～丹. All rights reserved.
//

#import "YTKNetconfig.h"
#import "YTKNetwork.h"

@implementation YTKNetconfig

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSString *)config:(YTKServiceType)sever{
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    NSString *msg = @"";
    switch (sever) {
        case YTKServiceTypeDev:     // 开发服务器地址
            config.baseUrl = @"https://college2019.halobear.com/";
            msg = [NSString stringWithFormat:@"开发网%@",config.baseUrl];
            break;
        case YTKServiceTypeTest:     //测试服务器地址
            config.baseUrl = @"https://college.weddingee.com/";
            msg = [NSString stringWithFormat:@"测试网%@",config.baseUrl];
            break;
        default:
            break;
    }
    NSLog(@"\n\n%@\n\n",msg);
    return msg;
    
}

@end
