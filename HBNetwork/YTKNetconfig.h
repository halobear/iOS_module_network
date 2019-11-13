//
//  YTKNetconfig.h
//  HaloBear
//
//  Created by 刘继丹 on 16/11/27.
//  Copyright © 2016年 刘～丹. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, YTKServiceType) {
    
    YTKServiceTypeTest = 0,
    YTKServiceTypeDev ,
};

@interface YTKNetconfig : NSObject

+ (NSString *)config:(YTKServiceType)sever;

@end
