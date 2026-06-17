import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {

  static InterstitialAd? _interstitialAd;
  static RewardedAd? _rewardedAd;

  /// تحميل الإعلان البيني
  static void loadInterstitialAd() {

    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-8995513369904529/6724997502',

      request: const AdRequest(),

      adLoadCallback:
          InterstitialAdLoadCallback(

        onAdLoaded: (ad) {

          _interstitialAd = ad;
        },

        onAdFailedToLoad: (error) {

          _interstitialAd = null;
        },
      ),
    );
  }

  /// عرض الإعلان البيني
  static void showInterstitialAd() {

    if (_interstitialAd != null) {

      _interstitialAd!.show();

      _interstitialAd = null;

      loadInterstitialAd();
    }
  }

  /// تحميل إعلان المكافأة
  static void loadRewardedAd() {

    RewardedAd.load(

      adUnitId:
          'ca-app-pub-8995513369904529/2729912174',

      request: const AdRequest(),

      rewardedAdLoadCallback:
          RewardedAdLoadCallback(

        onAdLoaded: (ad) {

          _rewardedAd = ad;
        },

        onAdFailedToLoad: (error) {

          _rewardedAd = null;
        },
      ),
    );
  }

  /// عرض إعلان المكافأة
  static void showRewardedAd(
    Function onRewardEarned,
  ) {

    if (_rewardedAd != null) {

      _rewardedAd!.show(

        onUserEarnedReward:
            (ad, reward) {

          onRewardEarned();
        },
      );

      _rewardedAd = null;

      loadRewardedAd();
    }
  }
}