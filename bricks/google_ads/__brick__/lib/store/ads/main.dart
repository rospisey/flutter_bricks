// Future<void> main() async {
//   // setupLocator();
//   WidgetsFlutterBinding.ensureInitialized();
//   Provider.debugCheckInvalidValueType = null;
//   await StorageManager.init();
//   service.SystemChrome.setPreferredOrientations([
//     service.DeviceOrientation.portraitUp,
//     service.DeviceOrientation.portraitDown,
//     service.DeviceOrientation.landscapeLeft,
//     service.DeviceOrientation.landscapeRight,
//   ]).then((_) {
//     // runApp(DevicePreview(builder: (context) => MyApp()));
//     guardMain();
//   });
//   // runApp(MyApp());

//   // runApp(Phoenix(child: MyApp()));
// }

// Future<void> guardMain() async {
//   // AdsController? adsController;
//   final ThemeService themeService = ThemeServicePrefs();
//   await themeService.init();
//   final ThemeController themeController = ThemeController(themeService);
//   await themeController.loadAll();

//   AdsController? adsController;
//   if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
//     /// Prepare the google_mobile_ads plugin so that the first ad loads
//     /// faster. This can be done later or with a delay if startup
//     /// experience suffers.
//     adsController = AdsController(MobileAds.instance);
//     adsController.initialize(testID: ['9E023E9F4BD853E3A631ECDE98DB9782']);
//   }

//   InAppPurchaseController? inAppPurchaseController;
//   if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
//     inAppPurchaseController = InAppPurchaseController(InAppPurchase.instance)
//       // Subscribing to [InAppPurchase.instance.purchaseStream] as soon
//       // as possible in order not to miss any updates.
//       ..subscribe();
//     // Ask the store what the player has bought already.
//     inAppPurchaseController.restorePurchases();
//   }
//   InAppUpdateController? inAppUpdateController;
//   if (Platform.isAndroid) {
//     inAppUpdateController = InAppUpdateController(InAppUpdate());
//     inAppUpdateController.checkForUpdate();
//   }

//   runApp(MyApp(
//     themeController: themeController,
//     adsController: adsController,
//     inAppPurchaseController: inAppPurchaseController,
//     inAppUpdateController: inAppUpdateController,
//   ));
// }