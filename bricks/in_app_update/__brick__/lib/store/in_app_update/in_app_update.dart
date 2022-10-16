import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:{{package_name}}/utils/theme_selection/shared/const/app_data.dart';
import 'package:logging/logging.dart';


class InAppUpdateController extends ChangeNotifier{
  InAppUpdate inAppUpdateInstant;
  InAppUpdateController(this.inAppUpdateInstant);

    static final Logger _log = Logger('InAppUpdate');

    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey(debugLabel: 'scaffoldMessengerKey');



  AppUpdateInfo _updateInfo =new AppUpdateInfo(0,false,false,0,0,AppData.packageName,null,0);

  AppUpdateInfo? get updateInfo => _updateInfo;

  Future<void> checkForUpdate() async {
    AppUpdateInfo uInfo = await InAppUpdate.checkForUpdate().catchError((e) {
      _reportError(e.toString());
    });
    notifyListeners();
    _updateInfo = uInfo;
    if (_updateInfo.updateAvailability !=
            UpdateAvailability.updateAvailable) {
          return;
          // InAppUpdate.startFlexibleUpdate()
          //     .catchError((e) => showSnack(e.toString()));
        }
    try{
      await InAppUpdate.performImmediateUpdate();
    }catch (e){
      _reportError('Could not update: $e');
    }

    print(_updateInfo.toString());
  }

  void _reportError(String message) {
    _log.severe(message);
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(content: Text(message)),
    );
    notifyListeners();
  }
}