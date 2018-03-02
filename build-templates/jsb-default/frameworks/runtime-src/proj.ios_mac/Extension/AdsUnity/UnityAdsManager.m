//
//  UnityAdsManager.m
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/22.
//

#import "UnityAdsManager.h"
#import "PlatformManager.h"
#import <UnityAds/UnityAds.h>

static UnityAdsManager *sharedInstance = nil;

@interface UnityAdsManager()<UnityAdsDelegate>



@end

@implementation UnityAdsManager

+ (void)Start:(NSString*)unityAdsId {
    if (!sharedInstance) {
        sharedInstance = [[UnityAdsManager alloc] init];
        [sharedInstance initialize:unityAdsId];
    }
}

- (void)initialize:(NSString*)unityAdsId {
    [UnityAds initialize:unityAdsId delegate:self testMode:NO];
}

+ (bool)isReady {
    return [UnityAds isReady:@"rewardedVideo"];
}

- (void)unityAdsReady:(NSString *)placementId {

}

#pragma mark UnityAdsDelegate implementation

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(NSString *)message {
    [PlatformManager evalString:@"cc.hh.vedioError()"];
}

- (void)unityAdsDidStart:(NSString *)placementId {
    
}

- (void)unityAdsDidFinish:(NSString *)placementId withFinishState:(UnityAdsFinishState)state {
    switch (state) {
        case kUnityAdsFinishStateError:
            [PlatformManager evalString:@"cc.hh.playVedio(\"error\")"];
            break;
        case kUnityAdsFinishStateSkipped:
            [PlatformManager evalString:@"cc.hh.playVedio(\"skipped\")"];
            break;
        case kUnityAdsFinishStateCompleted:
            [PlatformManager evalString:@"cc.hh.playVedio(\"completed\")"];
            break;
    }
}


+ (void)show {
    if ([UnityAds isReady:@"rewardedVideo"]) {
        UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        [UnityAds show:controller placementId:@"rewardedVideo"];
    }
}

@end
