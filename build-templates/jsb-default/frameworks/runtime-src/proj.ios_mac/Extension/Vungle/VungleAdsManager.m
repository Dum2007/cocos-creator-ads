//
//  VungleAdsManager.m
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/24.
//

#import "VungleAdsManager.h"
#import <VungleSDK/VungleSDK.h>

static VungleAdsManager *sharedInstance = nil;

@interface VungleAdsManager() <VungleSDKDelegate>

@property(nonatomic, assign) BOOL isReady;


@end

@implementation VungleAdsManager

+ (VungleAdsManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[VungleAdsManager alloc] init];
    });
    
    return sharedInstance;
}

+ (void)config:(NSString*)appID {
    [[VungleAdsManager sharedInstance] init:appID];
}

+ (void)showVedio {
    [[VungleAdsManager sharedInstance] playVedio];
}

+ (bool)isReadyVedio {
    return [[VungleAdsManager sharedInstance] readyVeido];
}
- (bool)readyVeido {
    if (self.isReady) {
        return true;
    }
    else {
        [self loadRequestVedio];
        return false;
    }
}

- (void)init:(NSString*)appID {
    NSError* error;
    NSArray* placementIDsArray = @[@"__-5338529"];
    VungleSDK* sdk = [VungleSDK sharedSDK];
    [sdk setDelegate:self];
    [sdk startWithAppId:appID placements:placementIDsArray error:&error];
}

- (void)playVedio {
    if (self.isReady) {
        self.isReady = NO;
        VungleSDK* sdk = [VungleSDK sharedSDK];
        NSError *error;
        UIViewController* controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        [sdk playAd:controller options:nil placementID:@"__-5338529" error:&error];
        if (error) {
            NSLog(@"Error encountered playing ad: %@", error);
        }
    }
    else {
        [self loadRequestVedio];
    }
}

- (void)loadRequestVedio {
    if (!self.isReady) {
        NSError* error;
        VungleSDK* sdk = [VungleSDK sharedSDK];
        [sdk loadPlacementWithID:@"__-5338529" error:&error];
    }
}

#pragma mark VungleSDKDelegate implementation
- (void)vungleSDKDidInitialize {
    //vungle初始化成功
    NSLog(@"--vungle初始化成功----");
    [self loadRequestVedio];
}

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(nullable NSString *)placementID {
    self.isReady = YES;
}

- (void)vungleWillCloseAdWithViewInfo:(VungleViewInfo *)info placementID:(NSString *)placementID {
    NSLog(@"---vungleWillCloseAdWithViewInfo:%@---", info.completedView);
}

@end
