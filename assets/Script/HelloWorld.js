var ADSMgr = require('./ADSMgr');

cc.Class({
    extends: cc.Component,

    properties: {
        inLabel: cc.Label,
        vLabel: cc.Label
    },

    onLoad: function () {
        this.vLabel.string = '';
        this.inLabel.string = '';
        ADSMgr.initADSKey();
        if (!cc.gg) {
            cc.gg = {};
        }
        cc.gg.onReward = function (ret) {
            console.log('---ads onReward---', ret);
        }
        ADSMgr.config();
    },

    onReadyVedio: function () {
        if (ADSMgr.isReadyVedio()) {
            this.vLabel.string = '视频已经准备完成';
            console.log('---onReadyVedio---', true);
        }
        else {
            this.vLabel.string = '视频正在加载...';
            console.log('---onReadyVedio---', false);
        }
    },
    onShowVedio: function () {
        this.vLabel.string = '播放视频...';
        ADSMgr.showVedio();
    },

    onReadyInterstitial: function () {
        if (ADSMgr.isReadyInterstitial()) {
            this.inLabel.string = '插屏已经准备完成';
            console.log('---onReadyInterstitial---', true);
        }
        else {
            this.inLabel.string = '插屏正在加载...';
            console.log('---onReadyInterstitial---', false);
        }
    },
    onShowInterstitial: function () {
        this.inLabel.string = '播放插屏...';
        ADSMgr.showInterstitial();
    }
});
