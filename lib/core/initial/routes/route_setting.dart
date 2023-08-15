import 'package:flutter/material.dart';

import '../../../global.dart';
import '../../../views/application/application.dart';
import '../../../views/sign_in/sign_in.dart';
import '../../../views/welcome/welcome.dart';

class RouteSetting {
  static generateRouteSettings(RouteSettings settings) {
    bool deviceFirstOpen = Global.storageService.getDeviceFirstTime();
    if (deviceFirstOpen) {
      bool isLoggedIn = Global.storageService.getIsLoggedIn();
      if (isLoggedIn) {
        return MaterialPageRoute(
            builder: (context) => const Application(), settings: settings);
      } else {}
      return MaterialPageRoute(
          builder: (_) => const SignIn(), settings: settings);
    } else {
      return MaterialPageRoute(
          builder: (_) => const Welcome(), settings: settings);
    }
  }
}
