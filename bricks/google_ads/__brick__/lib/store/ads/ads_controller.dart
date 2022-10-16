// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:{{package_name}}/store/ads/ads_helper.dart';
import 'preloaded_ad.dart';

/// Allows showing ads. A facade for `package:google_mobile_ads`.
class AdsController {
  final MobileAds _instance;

  static final bool kBanner = true;
  static final bool kNative = true;
  static final bool kInterstitial = true;

  // PreloadedBannerAd? _preloadedBannerAd;
  PreloadedNativeAd? _preloadedNativeAd;
  // PreloadedInterstitialAd? _preloadedInterstitialAd;

  /// Creates an [AdsController] that wraps around a [MobileAds] [instance].
  ///
  /// Example usage:
  ///
  ///     var controller = AdsController(MobileAds.instance);
  AdsController(MobileAds instance) : _instance = instance;

  void dispose() {
    // if(kBanner) _preloadedBannerAd?.dispose();
    if(kNative) _preloadedNativeAd?.dispose();
  }

  /// Initializes the injected [MobileAds.instance].
  Future<void> initialize({List<String>? testID}) async {
    await _instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: testID));
    await _instance.initialize();
  }

  /// Starts preloading an ad to be used later.
  ///
  /// The work doesn't start immediately so that calling this doesn't have
  /// adverse effects (jank) during start of a new screen.
  void preloadAd() {
    // TODO: When ready, change this to the Ad Unit IDs provided by AdMob.
    //       The current values are AdMob's sample IDs.
    // final bannerUnitId = kDebugMode ?  AdHelperTest.bannerAdUnitId : AdHelper.bannerAdUnitId;
    final nativeUnitId = kDebugMode ? AdHelperTest.nativeAdUnitId : AdHelper.nativeAdUnitId;
    // _preloadedBannerAd =
    //     PreloadedBannerAd(size: AdSize.mediumRectangle, adUnitId: bannerUnitId);
    _preloadedNativeAd =
        PreloadedNativeAd(size: AdSize.mediumRectangle, adUnitId: nativeUnitId);
    
    // _preloadedInterstitialAd =
    //     PreloadedInterstitialAd(size: AdSize.fullBanner, adUnitId: nativeUnitId);

    // Wait a bit so that calling at start of a new screen doesn't have
    // adverse effects on performance.
    if(kBanner){
      Future<void>.delayed(const Duration(seconds: 1)).then((_) {

      //  return _preloadedBannerAd!.load();
    });
    }

    if(kNative){
      Future<void>.delayed(const Duration(seconds: 1)).then((_) {
      return _preloadedNativeAd!.load();
    });
    }

    // if(kInterstitial){
    //   Future<void>.delayed(const Duration(seconds: 1)).then((_) {
    //   return _preloadedInterstitialAd!.load();
    // });
    // }
  }

  /// Allows caller to take ownership of a [PreloadedBannerAd].
  ///
  /// If this method returns a non-null value, then the caller is responsible
  /// for disposing of the loaded ad.
  // PreloadedBannerAd? takePreloadedAd() {
  //   final bannerAd = _preloadedBannerAd;
  //   _preloadedBannerAd = null;
  //   return bannerAd;
  // }

  PreloadedNativeAd? takePreloadedNativeAd() {
    final nativeAd = _preloadedNativeAd;
    _preloadedNativeAd = null;
    return nativeAd;
  }

  //  PreloadedInterstitialAd? takePreloadedInterstitialAd() {
  //   final interstitialAd = _preloadedInterstitialAd;
  //   _preloadedInterstitialAd = null;
  //   return interstitialAd;
  // }
}
