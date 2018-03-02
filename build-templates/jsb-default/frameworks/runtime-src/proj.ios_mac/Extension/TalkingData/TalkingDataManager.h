//
//  TalkingDataManager.h
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/11.
//

#import <Foundation/Foundation.h>

#import "TalkingDataGA.h"

@interface TalkingDataManager : NSObject
/*
 * App ID: 在TalkingData Game Analytics创建应用后会得到App ID.
 * 渠道 ID: 是渠道标识符，可通过不同渠道单独追踪数据。
 */
+(void)onStart:(NSString*)appId channelId:(NSString*)channelId;

/*
 *设置帐户
 */
+(void)setAccount:(NSString*)accountId;

/*************充值统计************/
/*
 * 充值请求
 * orderId 订单 ID，最多 64 个字符
 * iapId 充值包 ID，最多 32 个字符。如100元礼包
 * currencyAmount 现金金额或现金等价物的额度
 * currencyType 国际标准组织货币类型CNY USD EUR
 * virtualCurrencyAmount 虚拟币金额
 * paymentType 支付途径，如支付宝
 */
+(void)onChargeRequest:(NSString *)orderId iapId:(NSString *)iapId currencyAmount:(double)currencyAmount currencyType:(NSString *)currencyType virtualCurrencyAmount:(double)virtualCurrencyAmount paymentType:(NSString *)paymentType;

/*
 *充值成功
 */

+ (void)onChargeSuccess:(NSString *)orderId;

/*********虚拟货币的获取***********/

/*
 * 赠予虚拟币
 * virtualCurrencyAmount 虚拟币金额
 * reason 赠送虚拟币原因/类型 32 个字符
 */
+ (void)onReward:(double)virtualCurrencyAmount reason:(NSString *)reason;

/***************追踪游戏消费****************/
/*
 * 记录付费点
 * item 某个消费点的编号，最多 32 个字符
 * number 消费数量
 * price 道具单价
 */
+ (void)onPurchase:(NSString *)item itemNumber:(int) number priceInVirtualCurrency:(double) price;

/*
 * 消耗物品或服务等
 */
+ (void) onUse:(NSString *)item itemNumber:(int)number;


/*************基础-任务、关卡或副本**************/

/*
 * 接到任务
 * missionId 任务、关卡或副本的编号，最多 32 个字符
 * cause 失败原因
 */
+ (void)onTaskBegin:(NSString *)missionId;
 /*
  * 完成任务
 */
+ (void)onTaskCompleted:(NSString *)missionId;
 /*
  * 任务失败
  */
+ (void)onTaskFailed:(NSString *)missionId failedCause:(NSString *)cause;

@end
