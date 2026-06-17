import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  static InterstitialAd? _ad;

  static void init() {
    MobileAds.instance.initialize();
    loadAd();
  }

  static void loadAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx", // استبدله لاحقًا
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
        },
        onAdFailedToLoad: (error) {
          _ad = null;
        },
      ),
    );
  }

  static void showAd() {
    if (_ad == null) return;

    _ad!.show();
    _ad = null;
    loadAd();
  }
}