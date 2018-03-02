//
//  AdsManager.m
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/23.
//

#import "AdsManager.h"
#import "PlatformManager.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

#import <VungleAdapter/VungleAdapter.h>
#import <VungleSDK/VungleSDK.h>

static AdsManager *sharedInstance = nil;
static NSString *testDeviceID = nil;

@interface AdsManager()<GADRewardBasedVideoAdDelegate, GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic, assign) NSTimeInterval preTime;

@end

@implementation AdsManager

+ (AdsManager *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[AdsManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)initialize:(NSString*)appID {
    self.preTime = 0;
    [GADMobileAds configureWithApplicationID:appID];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
}


#pragma mark static method

+ (void)setTestDeviceID: (NSString*)deviceID {
    testDeviceID = deviceID;
}


+ (void)configWithAppID:(NSString*)appID {
    [[AdsManager sharedInstance] initialize:appID];
}

+ (bool)isReadyVideo {
    return [[GADRewardBasedVideoAd sharedInstance] isReady];
}

+ (void)showVideo {
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        UIViewController* controller = [UIApplication  sharedApplication].keyWindow.rootViewController;
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:controller];
    }
}

+ (void)requestVideoWithPlacement:(NSString*)placement vunglePlacement:(NSString*)vunglePlacement {
    [[AdsManager sharedInstance] loadRequestVedio:placement vunglePlacement:vunglePlacement];
}

+ (void)showInterstitial {
    [[AdsManager sharedInstance] playInterstital];
}

+ (bool)isReadyInterstitial {
    return [[AdsManager sharedInstance] readyInterstitial];
}

+ (void)requestInterstitialWithPlacement:(NSString*)placement vunglePlacement:(NSString*)vunglePlacement {
    [[AdsManager sharedInstance] loadRequestInterstitial:placement vunglePlacement:vunglePlacement];
}

#pragma mark GADRewardBasedVideoAdDelegate implementation

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    //发放奖励
//    NSLog(@"-----Rewarded video adapter class name----: %@", rewardBasedVideoAd.adNetworkClassName);
    [PlatformManager onReward:@"101"];
    
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    //视频加载失败
    [PlatformManager onError:@"101"];
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
//    NSLog(@"-----Rewarded video adapter class name----: %@", rewardBasedVideoAd.adNetworkClassName);
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {

}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {

}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {

}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    [PlatformManager onClose:@"101"];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    //插屏广告请求失败
    [PlatformManager onError:@"102"];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
//     self.interstitial = nil;
    //插屏广告已经消失
    [PlatformManager onReward:@"102"];
    [PlatformManager onClose:@"102"];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
//    NSLog(@"-----Interstitial adapter class name----: %@", ad.adNetworkClassName);
}


#pragma mark Method implementation

- (void)playInterstital {
    if (self.interstitial && self.interstitial.isReady) {
        UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        [self.interstitial presentFromRootViewController:controller];
    }
}

- (bool)readyInterstitial {
    return self.interstitial && self.interstitial.isReady;
}

- (void)loadRequestInterstitial:(NSString*)pcID vunglePlacement:(NSString*)vunglePlacement {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:pcID];
    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    if (testDeviceID) {
        request.testDevices = @[testDeviceID];
    }
    VungleAdNetworkExtras *extras = [[VungleAdNetworkExtras alloc] init];
    
    NSMutableArray *placements = [[NSMutableArray
                                   alloc]initWithObjects:vunglePlacement, nil];
    extras.allPlacements = placements;
    [request registerAdNetworkExtras:extras];
    [self.interstitial loadRequest:request];
}

- (void)loadRequestVedio:(NSString*)placement vunglePlacement:(NSString*)vunglePlacement {
    if (![[GADRewardBasedVideoAd sharedInstance] isReady]) {
        GADRequest *request = [GADRequest request];
        if (testDeviceID) {
            request.testDevices = @[testDeviceID];
        }
        VungleAdNetworkExtras *extras = [[VungleAdNetworkExtras alloc] init];
        
        NSMutableArray *placements = [[NSMutableArray alloc]initWithObjects:vunglePlacement, nil];
        extras.allPlacements = placements;
        [request registerAdNetworkExtras:extras];
        [[GADRewardBasedVideoAd sharedInstance] loadRequest:request withAdUnitID:placement];
    }
}



@end
