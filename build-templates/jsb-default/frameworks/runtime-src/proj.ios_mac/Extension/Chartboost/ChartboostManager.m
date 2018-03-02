//
//  ChartboostManager.m
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/26.
//

#import "ChartboostManager.h"

#import <Chartboost/Chartboost.h>

static ChartboostManager *sharedInstance = nil;

@interface ChartboostManager() <ChartboostDelegate>

@end

@implementation ChartboostManager


+ (ChartboostManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[ChartboostManager alloc] init];
    });
    
    return sharedInstance;
}

+ (void)config:(NSString*)appID signature:(NSString*)signature {
    [[ChartboostManager sharedInstance] init:appID signature:signature];
}

- (void)init:(NSString*)appID signature:(NSString*)signature {
    [Chartboost startWithAppId:appID
                  appSignature:signature
                      delegate:self];
}

#pragma mark ChartboostDelegate implementation
- (void)didInitialize:(BOOL)status {
    NSLog(@"---chartboost init----%d", status);
    if (status) {
        [ChartboostManager loadRequestInterstitial];
        [ChartboostManager loadRequestVedio];
    }
}

- (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward {
    
}



+ (void)showVedio {
    [Chartboost showRewardedVideo:CBLocationMainMenu];
}

+ (bool)isReadyVedio {
    if ([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
        return true;
    }
    else {
        [ChartboostManager loadRequestVedio];
        return false;
    }
}

+ (void)showInterstitial {
   [Chartboost showInterstitial:CBLocationHomeScreen];
}

+ (bool)isReadyInterstitial {
    if ([Chartboost hasRewardedVideo:CBLocationHomeScreen]) {
        return true;
    }
    else {
        [ChartboostManager loadRequestInterstitial];
        return false;
    }
}

+ (void) loadRequestVedio{
    [Chartboost cacheRewardedVideo:CBLocationMainMenu];
}

+ (void) loadRequestInterstitial{
    [Chartboost cacheRewardedVideo:CBLocationHomeScreen];
}

@end
