//
//  ChartboostManager.h
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/26.
//

#import <Foundation/Foundation.h>

@interface ChartboostManager : NSObject
/*
 *appID
 *signature
 */
+ (void)config:(NSString*)appID signature:(NSString*)signature;

+ (void)showVedio;

+ (bool)isReadyVedio;

+ (void)showInterstitial;

+ (bool)isReadyInterstitial;

@end
