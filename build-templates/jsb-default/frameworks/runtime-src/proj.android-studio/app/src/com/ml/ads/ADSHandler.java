package com.ml.ads;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;

import com.chartboost.sdk.Chartboost;
import com.google.ads.mediation.chartboost.ChartboostAdapter;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.InterstitialAd;
import com.google.android.gms.ads.MobileAds;
import com.google.android.gms.ads.reward.RewardItem;
import com.google.android.gms.ads.reward.RewardedVideoAd;
import com.google.android.gms.ads.reward.RewardedVideoAdListener;
import com.vungle.mediation.VungleAdapter;
import com.vungle.mediation.VungleExtrasBuilder;

import org.cocos2dx.javascript.AppActivity;
public class ADSHandler {
    private static ADSHandler mInstace = null;
    private static String testDeviceID = null;
    //单例模式
    private static boolean isVedio = false;
    private static boolean isIntersitial = false;
    public static ADSHandler getInstance() {
        if (null == mInstace) {
            mInstace = new ADSHandler();
        }
        return mInstace;
    }

    public static boolean isReadyVedio = false;

    private AppActivity mContext = null;
    private InterstitialAd mInterstitialAd = null;             //插屏广告
    private RewardedVideoAd mRewardedVideoAd = null;           //视频广告

    public final static int ADS_INTERSTITIAL        = 0x01;                 //插屏广告
    public final static int ADS_REWARDEDVIDEO       = 0x02;                 //视频广告

    /*
    初始化admob
    context:上下文
    appid:admob的appid
    */
    public void initialize(AppActivity context) {
        mContext = context;
    }

    /*
    * 配置广告
    * */
    public void config(String appId) {
        MobileAds.initialize(mContext, appId);
    }

    /*
    * 设置测试
    * */
    public void setTestDeviceID(String deviceID) {
        testDeviceID = deviceID;
    }
    /*
    * 加载视频广告
    * */
    public void requestVideoWithPlacement(final String placementId, String vunglePlacement) {
//        android.util.Log.d("--ADSHandler---", "---requestVideoWithPlacement---"+vunglePlacement);
        String[] placements = new String[1];
        placements[0] = vunglePlacement;
        Bundle VungleBundle = new VungleExtrasBuilder(placements).build();

        Bundle ChartboostBundle = new ChartboostAdapter.ChartboostExtrasBundleBuilder()
                .setFramework(Chartboost.CBFramework.CBFrameworkOther, "7.0.1")
                .build();

        final AdRequest request;
        if (null == testDeviceID) {
            request =  new AdRequest.Builder()
                    .addNetworkExtrasBundle(VungleAdapter.class, VungleBundle)
                    .addNetworkExtrasBundle(ChartboostAdapter.class, ChartboostBundle)
                    .build();
        }
        else {
            request =  new AdRequest.Builder()
                    .addTestDevice(testDeviceID)
                    .addNetworkExtrasBundle(VungleAdapter.class, VungleBundle)
                    .addNetworkExtrasBundle(ChartboostAdapter.class, ChartboostBundle)
                    .build();
        }

        synchronized(this) {
            mRewardedVideoAd = MobileAds.getRewardedVideoAdInstance(mContext);
            mContext.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    mRewardedVideoAd.loadAd(placementId, request);
                    mRewardedVideoAd.setRewardedVideoAdListener(new AdRewardedVideoListener(){
                        @Override
                        public void onRewardedVideoAdLoaded() {
                            isVedio = true;
                        }

                        @Override
                        public void onRewardedVideoAdClosed() {
                            PlatformManager.onClose(mContext,"101");
                        }

                        @Override
                        public void onRewarded(RewardItem rewardItem) {
                            PlatformManager.onReward(mContext,"101");
                        }

                        @Override
                        public void onRewardedVideoAdFailedToLoad(int i) {
                            PlatformManager.onError(mContext,"101");
                        }
                    });
                }
            });

        }
    }
    /*
   * 加载插屏广告
   * */
    public void requestInterstitialWithPlacement(final String placementId, String vunglePlacement) {
//        android.util.Log.d("--ADSHandler---", "---requestInterstitialWithPlacement---"+vunglePlacement);
        String[] placements = new String[1];
        placements[0] = vunglePlacement;
        Bundle mVungleBundle = new VungleExtrasBuilder(placements).build();

        Bundle mChartboostBundle = new ChartboostAdapter.ChartboostExtrasBundleBuilder()
                .setFramework(Chartboost.CBFramework.CBFrameworkOther, "7.0.1")
                .build();

        final AdRequest request;
        if (null == testDeviceID) {
            request =  new AdRequest.Builder()
                    .addNetworkExtrasBundle(VungleAdapter.class, mVungleBundle)
                    .addNetworkExtrasBundle(ChartboostAdapter.class, mChartboostBundle)
                    .build();
        }
        else {
            request =  new AdRequest.Builder()
                    .addTestDevice(testDeviceID)
                    .addNetworkExtrasBundle(VungleAdapter.class, mVungleBundle)
                    .addNetworkExtrasBundle(ChartboostAdapter.class, mChartboostBundle)
                    .build();
        }
        synchronized(this) {
            mInterstitialAd = new InterstitialAd(mContext);
            mContext.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    mInterstitialAd.setAdUnitId(placementId);
                    mInterstitialAd.loadAd(request);
                    mInterstitialAd.setAdListener(new AdListener() {
                        public void onAdLoaded() {
                            isIntersitial = true;
                        }
                        public void onAdClosed() {
                            PlatformManager.onClose(mContext, "102");
                            PlatformManager.onReward(mContext, "102");
                        }

                        public void onAdFailedToLoad(int var1) {
                            PlatformManager.onError(mContext, "102");
                        }
                    });
                }
            });
        }
    }

    /*
    * 播放视频
    * */
    public void showVideo() {
        mContext.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if(mRewardedVideoAd != null && mRewardedVideoAd.isLoaded()){
                    isVedio = false;
                    mRewardedVideoAd.show();
                }
            }
        });
    }
    /*
    * 播放插屏
    * */
    public void showInterstitial() {
        mContext.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (mInterstitialAd != null && mInterstitialAd.isLoaded()) {
                    isIntersitial = false;
                    mInterstitialAd.show();
                }
            }
        });
    }

    /*
   * 是否显示视频
   * */
    public boolean isReadyVideo() {
        return isVedio;
//        return mRewardedVideoAd != null && mRewardedVideoAd.isLoaded();
    }
    /*
    * 是否显示插屏
    * */
    public boolean isReadyInterstitial() {
        return isIntersitial;
//        return mInterstitialAd != null && mInterstitialAd.isLoaded();
    }

    public void onStart(Activity context) {
        Chartboost.onStart(context);
    }

    public void onResume(Activity context) {
        if(mRewardedVideoAd != null) {
            mRewardedVideoAd.resume(context);
        }

        Chartboost.onResume(context);
    }

    public void onPause(Activity context) {
        if(mRewardedVideoAd != null) {
            mRewardedVideoAd.pause(context);
        }
        Chartboost.onPause(context);
    }

    public void onDestroy(Activity context) {
        if(mRewardedVideoAd != null) {
            mRewardedVideoAd.destroy(context);
        }
        Chartboost.onDestroy(context);
    }
    public void onStop(Activity context) {
        Chartboost.onStop(context);
    }

    public boolean onBackPressed(Activity context) {
        if (Chartboost.onBackPressed()) {
            return false;
        }
        return true;
    }
}
