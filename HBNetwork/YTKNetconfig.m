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

+ (YTKNetconfig *)shared{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)config:(NSString *)baseUrl{
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = baseUrl;
         
}

+ (void)configOther:(NSString *)baseUrl{
    YTKNetconfig.shared.getOtherService = baseUrl;
}

@end
