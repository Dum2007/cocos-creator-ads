//
//  AdsManager.h
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/23.
//

#import <Foundation/Foundation.h>

@interface AdsManager : NSObject 

/******初始化******/
+ (void)configWithAppID:(NSString*)appID;

/******视频******/
+ (void)showVideo;

+ (bool)isReadyVideo;

+ (void)requestVideoWithPlacement:(NSString*)placement vunglePlacement:(NSString*)vunglePlacement;


/******插屏******/

+ (void)showInterstitial;

+ (bool)isReadyInterstitial;

+ (void)requestInterstitialWithPlacement:(NSString*)placement vunglePlacement:(NSString*)vunglePlacement;

/*
 *设置测试设备
 * deviceID 设备ID
 */
+ (void)setTestDeviceID: (NSString*)deviceID;

@end
