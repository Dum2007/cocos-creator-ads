//
//  VungleAdsManager.h
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/24.
//

#import <Foundation/Foundation.h>

@interface VungleAdsManager : NSObject

+ (void)config:(NSString*)appID;

+ (void)showVedio;

+ (bool)isReadyVedio;

@end
