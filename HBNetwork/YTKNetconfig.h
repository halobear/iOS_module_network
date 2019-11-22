//
//  YTKNetconfig.h
//  HaloBear
//
//  Created by 刘继丹 on 16/11/27.
//  Copyright © 2016年 刘～丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKNetconfig : NSObject

+ (YTKNetconfig *)shared;

///服务器地址
+ (void)configBaseUrl:(NSString *)baseUrl;
+ (void)configOtherBaseUrl:(NSString*)otherBaseUrl;

@property (nonatomic, strong) NSString *getOtherBaseUrl;

@end
