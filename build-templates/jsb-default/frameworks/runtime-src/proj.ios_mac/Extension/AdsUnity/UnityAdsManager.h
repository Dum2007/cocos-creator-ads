//
//  UnityAdsManager.h
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/22.
//

#import <Foundation/Foundation.h>

@interface UnityAdsManager : NSObject

+ (void)Start:(NSString*)gameID;

+ (bool)isReady;

+ (void)show;

@end
