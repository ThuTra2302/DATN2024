import 'dart:io';

enum Environment { dev, prod }

class BuildConstants {
  static Map<String, dynamic> _config = _Config.devConstants;
  static var currentEnvironment = Environment.dev;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.prod:
        _config = _Config.prodConstants;
        currentEnvironment = Environment.prod;
        break;
      case Environment.dev:
        _config = _Config.devConstants;
        currentEnvironment = Environment.dev;
        break;
    }
  }

  static get serverTYPE {
    return _config[_Config.serverTYPE];
  }

  static get idInterstitialAd {
    return Platform.isAndroid ? _config[_Config.idInterstitialAdAndroidKey] : _config[_Config.idInterstitialAdIosKey];
  }

  static get idBannerAd {
    return Platform.isAndroid ? _config[_Config.idBannerAdAndroidKey] : _config[_Config.idBannerAdIosKey];
  }

  static get idOpenAppAd {
    return Platform.isAndroid ? _config[_Config.idOpenAppAdAndroidKey] : _config[_Config.idOpenAppAdIosKey];
  }

  static get idNativeAppAd {
    return Platform.isAndroid ? _config[_Config.idNativeAppAdAndroidKey] : _config[_Config.idNativeAppAdIosKey];
  }

  static get idRewardAd {
    return Platform.isAndroid ? _config[_Config.idRewardAdAndroidKey] : _config[_Config.idRewardAdIosKey];
  }

  static get idExitNativeAppAd {
    return _config[_Config.idExitNativeAppAdAndroidKey];
  }

  static get idIntroNativeAppAd {
    return _config[_Config.idIntroNativeAppAdAndroidKey];
  }

  static get idResumeAppAdKey {
    return _config[_Config.idResumeAppAdAndroidKey];
  }
}

class _Config {
  static const serverTYPE = "SERVER_TYPE";
  static const idInterstitialAdAndroidKey = "idInterstitialAdAndroid";
  static const idBannerAdAndroidKey = "idBannerAdAndroid";
  static const idOpenAppAdAndroidKey = "idOpenAppAdAndroid";
  static const idResumeAppAdAndroidKey = "idResumeAppAdAndroid";
  static const idInterstitialAdIosKey = "idInterstitialAdIos";
  static const idBannerAdIosKey = "idBannerAdIos";
  static const idOpenAppAdIosKey = "idOpenAppAdIos";
  static const idNativeAppAdAndroidKey = "idNativeAppAdAndroidKey";
  static const idExitNativeAppAdAndroidKey = "idExitNativeAppAdAndroidKey";
  static const idIntroNativeAppAdAndroidKey = "idIntroNativeAppAdAndroidKey";
  static const idNativeAppAdIosKey = "idNativeAppAdIosKey";
  static const idRewardAdAndroidKey = "idRewardAdAndroidKey";
  static const idRewardAdIosKey = "idRewardAdIosKey";

  static Map<String, dynamic> prodConstants = {};

  static Map<String, dynamic> devConstants = {};
}
