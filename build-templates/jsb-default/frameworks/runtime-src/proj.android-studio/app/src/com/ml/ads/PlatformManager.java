package com.ml.ads;

/**
 * Created by anne on 2018/3/1.
 */

import android.app.Activity;
import android.content.Context;

import org.cocos2dx.javascript.AppActivity;
import org.cocos2dx.lib.Cocos2dxJavascriptJavaBridge;

public class PlatformManager {

    static void onReward(Context context, final String ret) {
        AppActivity mainActiviy = (AppActivity)context;
        mainActiviy.runOnGLThread(new Runnable() {
            @Override
            public void run() {
                Cocos2dxJavascriptJavaBridge.evalString("cc.gg.onReward('" + ret + "')");
            }
        });
    }
    static void onError(Context context, final String ret) {
        AppActivity mainActiviy = (AppActivity)context;
        mainActiviy.runOnGLThread(new Runnable() {
            @Override
            public void run() {
                Cocos2dxJavascriptJavaBridge.evalString("cc.gg.onError('" + ret + "')");
            }
        });
    }
    static void onClose(Context context, final String ret) {
        AppActivity mainActiviy = (AppActivity)context;
        mainActiviy.runOnGLThread(new Runnable() {
            @Override
            public void run() {
                Cocos2dxJavascriptJavaBridge.evalString("cc.gg.onClose('" + ret + "')");
            }
        });
    }
}
