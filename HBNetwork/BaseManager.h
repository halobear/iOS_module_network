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
+ (void)configWithImKey:(NSString*)imKey token:(NSString *)token headersDic:(NSDictionary *)headersDic;
///初始化headers带有两个域名的以及APP标识不同
+ (void)configWithImKey:(NSString*)imKey token:(NSString *)token customAppLabel:(NSString*)customAppLabel otherAppLabel:(NSString*)otherAppLabel headersDic:(NSDictionary *)headersDic;

@property (nonatomic, copy) void(^requestFailedBlock)(void);

@end
