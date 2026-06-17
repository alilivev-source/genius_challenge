import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase_options.dart';
import 'app/app.dart';

import 'features/ads/ad_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// تهيئة AdMob
  await MobileAds.instance.initialize();

  /// تحميل الإعلانات مسبقاً
  AdService.loadInterstitialAd();
  AdService.loadRewardedAd();

  runApp(
    const GeniusChallengeApp(),
  );
}