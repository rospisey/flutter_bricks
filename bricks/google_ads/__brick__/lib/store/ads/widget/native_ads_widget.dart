// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:{{package_name}}/store/ads/ads_helper.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../ads_controller.dart';
import '../preloaded_ad.dart';

/// Displays a banner ad that conforms to the widget's size in the layout,
/// and reloads the ad when the user changes orientation.
///
/// Do not use this widget on platforms that AdMob currently doesn't support.
/// For example:
///
/// ```dart
/// if (kIsWeb) {
///   return Text('No ads here! (Yet.)');
/// } else {
///   return MyBannerAd();
/// }
/// ```
///
/// This widget is adapted from pkg:google_mobile_ads's example code,
/// namely the `anchored_adaptive_example.dart` file:
/// https://github.com/googleads/googleads-mobile-flutter/blob/main/packages/google_mobile_ads/example/lib/anchored_adaptive_example.dart
// class BannerAdWidget extends StatefulWidget {
//   const BannerAdWidget({super.key});

//   @override
//   State<BannerAdWidget> createState() => _BannerAdWidgetState();
// }

// class _BannerAdWidgetState extends State<BannerAdWidget> {
//   static final _log = Logger('BannerAdWidget');

//   static const useAnchoredAdaptiveSize = false;
//   BannerAd? _bannerAd;
//   _LoadingState _adLoadingState = _LoadingState.initial;

//   late Orientation _currentOrientation;

//   @override
//   Widget build(BuildContext context) {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (_currentOrientation == orientation &&
//             _bannerAd != null &&
//             _adLoadingState == _LoadingState.loaded) {
//           _log.info(() => 'We have everything we need. Showing the ad '
//               '${_bannerAd.hashCode} now.');
//           return SizedBox(
//             width: _bannerAd!.size.width.toDouble(),
//             height: _bannerAd!.size.height.toDouble(),
//             child: AdWidget(ad: _bannerAd!),
//           );
//         }
//         // Reload the ad if the orientation changes.
//         if (_currentOrientation != orientation) {
//           _log.info('Orientation changed');
//           _currentOrientation = orientation;
//           _loadAd();
//         }
//         return const SizedBox();
//       },
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _currentOrientation = MediaQuery.of(context).orientation;
//   }

//   @override
//   void dispose() {
//     _log.info('disposing ad');
//     _bannerAd?.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     final adsController = context.read<AdsController>();
//     final ad = adsController.takePreloadedAd();
//     if (ad != null) {
//       _log.info("A preloaded banner was supplied. Using it.");
//       _showPreloadedAd(ad);
//     } else {
//       _loadAd();
//     }
//   }

//   /// Load (another) ad, disposing of the current ad if there is one.
//   Future<void> _loadAd() async {
//     if (!mounted) return;
//     _log.info('_loadAd() called.');
//     if (_adLoadingState == _LoadingState.loading ||
//         _adLoadingState == _LoadingState.disposing) {
//       _log.info('An ad is already being loaded or disposed. Aborting.');
//       return;
//     }
//     _adLoadingState = _LoadingState.disposing;
//     await _bannerAd?.dispose();
//     _log.fine('_bannerAd disposed');
//     if (!mounted) return;

//     setState(() {
//       _bannerAd = null;
//       _adLoadingState = _LoadingState.loading;
//     });

//     AdSize size;

//     if (useAnchoredAdaptiveSize) {
//       final AnchoredAdaptiveBannerAdSize? adaptiveSize =
//           await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
//               MediaQuery.of(context).size.width.truncate());

//       if (adaptiveSize == null) {
//         _log.warning('Unable to get height of anchored banner.');
//         size = AdSize.banner;
//       } else {
//         size = adaptiveSize;
//       }
//     } else {
//       size = AdSize.mediumRectangle;
//     }

//     if (!mounted) return;

//     assert(Platform.isAndroid || Platform.isIOS,
//         'AdMob currently does not support ${Platform.operatingSystem}');
//     _bannerAd = BannerAd(
//       // This is a test ad unit ID from
//       // https://developers.google.com/admob/android/test-ads. When ready,
//       // you replace this with your own, production ad unit ID,
//       // created in https://apps.admob.com/.
//       adUnitId: kDebugMode ?  AdHelperTest.bannerAdUnitId : AdHelper.bannerAdUnitId,
//       size: size,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           _log.info(() => 'Ad loaded: ${ad.responseInfo}');
//           setState(() {
//             // When the ad is loaded, get the ad size and use it to set
//             // the height of the ad container.
//             _bannerAd = ad as BannerAd;
//             _adLoadingState = _LoadingState.loaded;
//           });
//         },
//         onAdFailedToLoad: (ad, error) {
//           _log.warning('Banner failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdImpression: (ad) {
//           _log.info('Ad impression registered');
//         },
//         onAdClicked: (ad) {
//           _log.info('Ad click registered');
//         },
//       ),
//     );
//     return _bannerAd!.load();
//   }

//   Future<void> _showPreloadedAd(PreloadedBannerAd ad) async {
//     // It's possible that the banner is still loading (even though it started
//     // preloading at the start of the previous screen).
//     _adLoadingState = _LoadingState.loading;
//     try {
//       _bannerAd = await ad.ready;
//     } on LoadAdError catch (error) {
//       _log.severe('Error when loading preloaded banner: $error');
//       unawaited(_loadAd());
//       return;
//     }
//     if (!mounted) return;

//     setState(() {
//       _adLoadingState = _LoadingState.loaded;
//     });
//   }
// }

// enum _LoadingState {
//   /// The state before we even start loading anything.
//   initial,

//   /// The ad is being loaded at this point.
//   loading,

//   /// The previous ad is being disposed of. After that is done, the next
//   /// ad will be loaded.
//   disposing,

//   /// An ad has been loaded already.
//   loaded,
// }


class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({super.key});

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  static final _log = Logger('NativeAdWidget');

  static const useAnchoredAdaptiveSize = false;
  NativeAd? _nativeAd;
  _LoadingNativeState _adLoadingState = _LoadingNativeState.initial;

  late Orientation _currentOrientation;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _nativeAd != null &&
            _adLoadingState == _LoadingNativeState.loaded) {
          _log.info(() => 'We have everything we need. Showing the ad '
              '${_nativeAd.hashCode} now.');
          return Container(
            height: AdSize.banner.height.toDouble(),
            child: AdWidget(ad: _nativeAd!),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _log.info('Orientation changed');
          _currentOrientation = orientation;
          _loadAd();
        }
        return const SizedBox();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
  }

  @override
  void dispose() {
    _log.info('disposing ad');
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final adsController = context.read<AdsController>();
    final ad = adsController.takePreloadedNativeAd();
    if (ad != null) {
      _log.info("A preloaded banner was supplied. Using it.");
      _showPreloadedAd(ad);
    } else {
      _loadAd();
    }
  }

  /// Load (another) ad, disposing of the current ad if there is one.
  Future<void> _loadAd() async {
    if (!mounted) return;
    _log.info('_loadAd() called.');
    if (_adLoadingState == _LoadingNativeState.loading ||
        _adLoadingState == _LoadingNativeState.disposing) {
      _log.info('An ad is already being loaded or disposed. Aborting.');
      return;
    }
    _adLoadingState = _LoadingNativeState.disposing;
    await _nativeAd?.dispose();
    _log.fine('_bannerAd disposed');
    if (!mounted) return;

    setState(() {
      _nativeAd = null;
      _adLoadingState = _LoadingNativeState.loading;
    });

    AdSize size;

    if (useAnchoredAdaptiveSize) {
      final AnchoredAdaptiveBannerAdSize? adaptiveSize =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
              MediaQuery.of(context).size.width.truncate());

      if (adaptiveSize == null) {
        _log.warning('Unable to get height of anchored banner.');
        size = AdSize.banner;
      } else {
        size = adaptiveSize;
      }
    } else {
      size = AdSize.mediumRectangle;
    }

    if (!mounted) return;

    assert(Platform.isAndroid || Platform.isIOS,
        'AdMob currently does not support ${Platform.operatingSystem}');
    _nativeAd = NativeAd(
      factoryId: 'listTile',
      // This is a test ad unit ID from
      // https://developers.google.com/admob/android/test-ads. When ready,
      // you replace this with your own, production ad unit ID,
      // created in https://apps.admob.com/.
      adUnitId: kDebugMode ?  AdHelperTest.nativeAdUnitId : AdHelper.nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _log.info(() => 'Ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _nativeAd = ad as NativeAd;
            _adLoadingState = _LoadingNativeState.loaded;
          });
        },
        onAdFailedToLoad: (ad, error) {
          _log.warning('Banner failedToLoad: $error');
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
    return _nativeAd!.load();
  }

  Future<void> _showPreloadedAd(PreloadedNativeAd ad) async {
    // It's possible that the banner is still loading (even though it started
    // preloading at the start of the previous screen).
    _adLoadingState = _LoadingNativeState.loading;
    try {
      _nativeAd = await ad.ready;
    } on LoadAdError catch (error) {
      _log.severe('Error when loading preloaded banner: $error');
      unawaited(_loadAd());
      return;
    }
    if (!mounted) return;

    setState(() {
      _adLoadingState = _LoadingNativeState.loaded;
    });
  }
}

enum _LoadingNativeState {
  /// The state before we even start loading anything.
  initial,

  /// The ad is being loaded at this point.
  loading,

  /// The previous ad is being disposed of. After that is done, the next
  /// ad will be loaded.
  disposing,

  /// An ad has been loaded already.
  loaded,
}
