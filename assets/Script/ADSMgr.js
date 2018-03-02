
var appID ;
var videoID ;
var interstitalID ;
var vungleVedioPlacement ;
var vungleInterstitalPlacement ;

var testDeviceID = '';

// const testDeviceID = '0bfd2d91f25d3a6631f5fb0a12276510';



exports.initADSKey = function () {
    if (cc.sys.os === cc.sys.OS_ANDROID) {
         appID = 'ca-app-pub-8542086879268484~6047701477';
         videoID = 'ca-app-pub-8542086879268484/3594650727';
         interstitalID = 'ca-app-pub-8542086879268484/5482447463';
         vungleVedioPlacement = 'DEFAULT2-8814810';
         vungleInterstitalPlacement = 'DEFAULT-8670157';
         testDeviceID = 'CD7D17AF8A7A4FC94550B30DB4FEB636';
    }
    else {
         appID = 'ca-app-pub-8542086879268484~6613063285';
         videoID = 'ca-app-pub-8542086879268484/2099103208';
         interstitalID = 'ca-app-pub-8542086879268484/8264168259';
         vungleVedioPlacement = '__-5338529';
         vungleInterstitalPlacement = 'DEFAULT-4929529';
         // testDeviceID = '0bfd2d91f25d3a6631f5fb0a12276510';
    }
}

/*
* 配置admob广告,聚合admob官网后台设置
* appId         appID
* vedioId       视频ID
* interstialId  插屏ID
* */
exports.config =  function () {
    if (testDeviceID && testDeviceID != '') {
        exports.setTestDevice(testDeviceID);
    }
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'configWithAppID', '(Ljava/lang/String;)V', appID);
    }
    else {
        jsb.reflection.callStaticMethod("AdsManager", "configWithAppID:", appID);
    }
    exports.loadVedio();
    exports.loadInterstital();

    if (!cc.gg) {
        cc.gg = {};
    }
    cc.gg.onError = function (ret) {
        console.log('---ads onError----', ret);
        if (ret == 101) {
            // exports.loadVedio();
        }
        else {
            // exports.loadInterstital();
        }
    }
    cc.gg.onClose = function (ret) {
        console.log('---ads onClose----', ret);
        if (ret == 101) {
            exports.loadVedio();
        }
        else {
            exports.loadInterstital();
        }
    }
}
/*
* 加载视频
* */
exports.loadVedio = function () {
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'requestVideoWithPlacement', '(Ljava/lang/String;Ljava/lang/String;)V', videoID, vungleVedioPlacement);
    }
    else {
        jsb.reflection.callStaticMethod("AdsManager", "requestVideoWithPlacement:vunglePlacement:", videoID, vungleVedioPlacement);
    }

}

/*
* 加载插屏
* */
exports.loadInterstital = function () {
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'requestInterstitialWithPlacement', '(Ljava/lang/String;Ljava/lang/String;)V', videoID, vungleVedioPlacement);
    }
    else {
        jsb.reflection.callStaticMethod("AdsManager", "requestInterstitialWithPlacement:vunglePlacement:", interstitalID, vungleInterstitalPlacement);
    }
}

/*
* 是否可以播放视频
* */
exports.isReadyVedio = function () {
    var ret;
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        console.log('---isReadyVedio34435345435435345---');
        ret = jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'isReadyVideo', '()Z');
    }
    else {
        ret = jsb.reflection.callStaticMethod("AdsManager", "isReadyVideo");
    }

    return ret;
}
/*
* 显示视频
* */
exports.showVedio = function () {
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'showVideo', '()V');
    }
    else {
        jsb.reflection.callStaticMethod("AdsManager", "showVideo");
    }

}
/*
* 是否可以播放插屏
* */
exports.isReadyInterstitial = function () {
    var ret;
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        console.log('---isReadyInterstitial56465476456756---');
        ret = jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'isReadyInterstitial', '()Z');
    }
    else {
        ret = jsb.reflection.callStaticMethod("AdsManager", "isReadyInterstitial");
    }
    return ret;
}
/*
* 显示插屏
* */
exports.showInterstitial = function () {
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'showInterstitial', '()V');
    }
    else {
        jsb.reflection.callStaticMethod("AdsManager", "showInterstitial");
    }
}

/*
* 设置测试设备
* */
exports.setTestDevice = function (deviceID) {
    if (cc.sys.os === cc.sys.OS_ANDROID) {
        jsb.reflection.callStaticMethod('com/ml/ads/AdsManager', 'setTestDeviceID', '(Ljava/lang/String;Ljava/lang/String;)V', deviceID);
    }
    else {
        jsb.reflection.callStaticMethod("AdsManager", "setTestDeviceID:", deviceID);
    }
}

/*
 * 奖励回调cc.hh.onReward();在相应ui表现界面自定义使用
 * 加载错误回调cc.hh.onError();
 * 关闭回调cc.hh.onClose();
 */
