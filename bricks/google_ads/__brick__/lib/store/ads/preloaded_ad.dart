// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logging/logging.dart';

class PreloadedBannerAd {
  static final _log = Logger('PreloadedBannerAd');

  /// Something like [AdSize.mediumRectangle].
  final AdSize size;

  final AdRequest _adRequest;

  BannerAd? _bannerAd;

  final String adUnitId;

  final _adCompleter = Completer<BannerAd>();

  PreloadedBannerAd({
    required this.size,
    required this.adUnitId,
    AdRequest? adRequest,
  }) : _adRequest = adRequest ?? const AdRequest();

  Future<BannerAd> get ready => _adCompleter.future;

  Future<void> load() {
    assert(Platform.isAndroid || Platform.isIOS,
        'AdMob currently does not support ${Platform.operatingSystem}');

    _bannerAd = BannerAd(
      // This is a test ad unit ID from
      // https://developers.google.com/admob/android/test-ads. When ready,
      // you replace this with your own, production ad unit ID,
      // created in https://apps.admob.com/.
      adUnitId: adUnitId,
      size: size,
      request: _adRequest,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _log.info(() => 'Ad loaded: ${_bannerAd.hashCode}');
          _adCompleter.complete(_bannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          _log.warning('Banner failedToLoad: $error');
          _adCompleter.completeError(error);
          ad.dispose();
        },
        onAdImpression: (ad) {
          _log.info('Ad impression registered');
        },
        onAdClicked: (ad) {
          _log.info('Ad click registered');
        },
      ),
    );

    return _bannerAd!.load();
  }

  void dispose() {
    _log.info('preloaded banner ad being disposed');
    _bannerAd?.dispose();
  }
}


class PreloadedNativeAd {
  static final _log = Logger('PreloadedBannerAd');

  /// Something like [AdSize.mediumRectangle].
  final AdSize size;

  final AdRequest _adRequest;

  NativeAd? _bannerAd;

  final String adUnitId;

  final _adCompleter = Completer<NativeAd>();

  PreloadedNativeAd({
    required this.size,
    required this.adUnitId,
    AdRequest? adRequest,
  }) : _adRequest = adRequest ?? const AdRequest();

  Future<NativeAd> get ready => _adCompleter.future;

  Future<void> load() {
    assert(Platform.isAndroid || Platform.isIOS,
        'AdMob currently does not support ${Platform.operatingSystem}');

    _bannerAd = NativeAd(
      factoryId: 'listTile',
      // This is a test ad unit ID from
      // https://developers.google.com/admob/android/test-ads. When ready,
      // you replace this with your own, production ad unit ID,
      // created in https://apps.admob.com/.
      adUnitId: adUnitId,
      request: _adRequest,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _log.info(() => 'Ad loaded: ${_bannerAd.hashCode}');
          _adCompleter.complete(_bannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          _log.warning('Banner failedToLoad: $error');
          _adCompleter.completeError(error);
          ad.dispose();
        },
        onAdImpression: (ad) {
          _log.info('Ad impression registered');
        },
        onAdClicked: (ad) {
          _log.info('Ad click registered');
        },
      ),
    );

    return _bannerAd!.load();
  }

  void dispose() {
    _log.info('preloaded banner ad being disposed');
    _bannerAd?.dispose();
  }
}

// class PreloadedInterstitialAd {
//   static final _log = Logger('PreloadedInterstitialAd');

//   /// Something like [AdSize.mediumRectangle].
//   final AdSize size;

//   final AdRequest _adRequest;

//   InterstitialAd? _interstitialAd;

//   final String adUnitId;

//   final _adCompleter = Completer<InterstitialAd>();

//   PreloadedInterstitialAd({
//     required this.size,
//     required this.adUnitId,
//     AdRequest? adRequest,
//   }) : _adRequest = adRequest ?? const AdRequest();

//   Future<InterstitialAd> get ready => _adCompleter.future;

//   Future<void> load() {
//     assert(Platform.isAndroid || Platform.isIOS,
//         'AdMob currently does not support ${Platform.operatingSystem}');

//     return InterstitialAd.load(
//       // factoryId: 'listTile',
//       // This is a test ad unit ID from
//       // https://developers.google.com/admob/android/test-ads. When ready,
//       // you replace this with your own, production ad unit ID,
//       // created in https://apps.admob.com/.
//       adUnitId: adUnitId,
//       request: _adRequest,
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (ad) {
//           _log.info(() => 'Ad loaded: ${_interstitialAd.hashCode}');
//           _adCompleter.complete(_interstitialAd);
//         },
//         onAdFailedToLoad: ( error) {
//           _log.warning('Banner failedToLoad: $error');
//           // _adCompleter.completeError(error);
//           // ad.dispose();
//         },
//         // onAdImpression: (ad) {
//         //   _log.info('Ad impression registered');
//         // },
//         // onAdClicked: (ad) {
//         //   _log.info('Ad click registered');
//         // },
//       ),
//     );

//     // return _bannerAd!.load();
//   }

//   void dispose() {
//     _log.info('preloaded banner ad being disposed');
//     _interstitialAd?.dispose();
//   }
// }