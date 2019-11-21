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

+ (void)config:(NSString *)baseUrl{
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = baseUrl;
         
}

+ (void)configOther:(NSString *)baseUrl{
    YTKNetconfig.sharedConfig.getOtherService = baseUrl
}

@end
