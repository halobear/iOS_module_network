//
//  YTKNetconfig.h
//  HaloBear
//
//  Created by 刘继丹 on 16/11/27.
//  Copyright © 2016年 刘～丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKNetconfig : NSObject

///服务器地址
+ (void)config:(NSString *)baseUrl;
+ (NSString*)configOther:(NSString *)baseUrl;

@end
