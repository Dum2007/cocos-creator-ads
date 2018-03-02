//
//  PlatformManager.m
//  CocosExtension-mobile
//
//  Created by Anne on 2018/2/27.
//

#import "PlatformManager.h"

#if GAME_PLATFORM_COCOS_CREATOR
#include "cocos2d.h"
#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"
using namespace cocos2d;
using namespace se;
#endif


#if GAME_PLATFORM_UNITY3D

#endif

/*
 * 101 video        视频
 * 102 initialize   插屏
 */

@implementation PlatformManager

#if GAME_PLATFORM_COCOS_CREATOR
+ (void)evalString:(NSString*)script {
    
    if (std::this_thread::get_id() == Director::getInstance()->getCocos2dThreadId())
    {
        se::ScriptEngine::getInstance()->evalString([script UTF8String]);
    }
    else
    {
        Director::getInstance()->getScheduler()->performFunctionInCocosThread([=](){
            se::ScriptEngine::getInstance()->evalString([script UTF8String]);
        });
    }
}
#endif

+ (void)onReward:(NSString*)param {
#if GAME_PLATFORM_COCOS_CREATOR
    NSString *scriptStr = [NSString stringWithFormat:@"cc.gg.onReward(%@)", param];
    [PlatformManager evalString:scriptStr];
#endif
   
}

+ (void)onError: (NSString*)param {
#if GAME_PLATFORM_COCOS_CREATOR
    NSString *scriptStr = [NSString stringWithFormat:@"cc.gg.onError(%@)", param];
    [PlatformManager evalString:scriptStr];
#endif
}

+ (void)onClose: (NSString*)param {
#if GAME_PLATFORM_COCOS_CREATOR
    NSString *scriptStr = [NSString stringWithFormat:@"cc.gg.onClose(%@)", param];
    [PlatformManager evalString:scriptStr];
#endif
}

@end
