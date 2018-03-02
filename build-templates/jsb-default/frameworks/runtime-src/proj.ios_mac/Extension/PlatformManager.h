//
//  PlatformManager.h
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/27.
//

#import <Foundation/Foundation.h>

@interface PlatformManager : NSObject

+ (void)evalString:(NSString*)script;

/*
 * 奖励通知
 */

+ (void)onReward:(NSString*)param;

/*
 * 加载错误通知
 */
+ (void)onError: (NSString*)param;

/*
 * 关闭通知
 */
+ (void)onClose: (NSString*)param;

@end
