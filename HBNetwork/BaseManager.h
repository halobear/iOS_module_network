//
//  BaseManager.h
//  HaloBear
//
//  Created by 刘继丹 on 16/12/7.
//  Copyright © 2016年 刘～丹. All rights reserved.
//

#import "YTKNetwork.h"

@interface BaseManager : YTKRequest

@property(nonatomic, strong)  NSString *timeString;;

@property(nonatomic, strong) NSMutableDictionary *paramsDic;

@property(nonatomic, strong) NSString*token;

-(NSString *)getTimeString;

+ (BaseManager *)sharedManager;

///初始化headers
+ (void)config:(NSString*)imKey token:(NSString *)token headerSignKey:(NSString *)headerSignKey headerTimeKey:(NSString *)headerTimeKey headersDic:(NSDictionary *)headersDic;

@property (nonatomic, copy) void(^requestFailedBlock)(void);

@end
