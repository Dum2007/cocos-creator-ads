//
//  TalkingDataManager.m
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/11.
//

#import "TalkingDataManager.h"

@implementation TalkingDataManager

+(void)onStart:(NSString*)appId channelId:(NSString*)channelId {
    [TalkingDataGA onStart:appId withChannelId:channelId];
}

+(void)setAccount:(NSString*)accountId {
    [TDGAAccount setAccount:accountId];
}

+(void)onChargeRequest:(NSString *)orderId iapId:(NSString *)iapId currencyAmount:(double)currencyAmount currencyType:(NSString *)currencyType virtualCurrencyAmount:(double)virtualCurrencyAmount paymentType:(NSString *)paymentType {
    [TDGAVirtualCurrency onChargeRequst:orderId iapId:iapId currencyAmount:currencyAmount currencyType:currencyType virtualCurrencyAmount:virtualCurrencyAmount paymentType:paymentType];
}

+ (void)onChargeSuccess:(NSString *)orderId {
    [TDGAVirtualCurrency onChargeSuccess:orderId];
}

+ (void)onReward:(double)virtualCurrencyAmount reason:(NSString *)reason {
    [TDGAVirtualCurrency onReward:virtualCurrencyAmount reason:reason];
}

+ (void)onPurchase:(NSString *)item itemNumber:(int)number priceInVirtualCurrency:(double)price {
    [TDGAItem onPurchase:item itemNumber:number priceInVirtualCurrency:price];
}

+ (void) onUse:(NSString *)item itemNumber:(int)number {
    [TDGAItem onUse:item itemNumber:number];
}

+ (void)onTaskBegin:(NSString *)missionId {
    [TDGAMission onBegin:missionId];
}

+ (void)onTaskCompleted:(NSString *)missionId {
    [TDGAMission onCompleted:missionId];
}

+ (void)onTaskFailed:(NSString *)missionId failedCause:(NSString *)cause {
    [TDGAMission onFailed:missionId failedCause:cause];
}
@end
