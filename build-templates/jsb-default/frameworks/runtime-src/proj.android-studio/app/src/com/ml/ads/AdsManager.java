package com.ml.ads;


import android.util.Log;

import com.ml.ads.ADSHandler;

public class AdsManager {
    static void setTestDeviceID(String deviceID) {
        ADSHandler.getInstance().setTestDeviceID(deviceID);
    }
    static void configWithAppID(String appId) {
//        android.util.Log.d("--AdsManager---", "---configWithAppID---"+appId);
        ADSHandler.getInstance().config(appId);
    }
    static void requestVideoWithPlacement(String placementId, String vunglePlacement) {
//        android.util.Log.d("--AdsManager---", "---requestVideo---"+placementId+vunglePlacement);
        ADSHandler.getInstance().requestVideoWithPlacement(placementId, vunglePlacement);
    }
    static void requestInterstitialWithPlacement(String placementId, String vunglePlacement) {
//        android.util.Log.d("--AdsManager---", "---requestIn--"+placementId+"-"+vunglePlacement);
        ADSHandler.getInstance().requestInterstitialWithPlacement(placementId, vunglePlacement);
    }
    static void showVideo() {
//        android.util.Log.d("--AdsManager---", "---showVideo22222---");
        ADSHandler.getInstance().showVideo();
    }
    static void showInterstitial() {
//        android.util.Log.d("--AdsManager---", "---showInterstitial---");
        ADSHandler.getInstance().showVideo();
    }
    static boolean isReadyVideo() {
//        android.util.Log.d("--AdsManager---", "---isReadyVideo-111--");
        return ADSHandler.getInstance().isReadyVideo();
    }
    static boolean isReadyInterstitial() {
//        android.util.Log.d("--AdsManager---", "---isReadyInterstitial---");
        return  ADSHandler.getInstance().isReadyInterstitial();
    }
}
