import 'package:citracker/global.dart';
import 'package:citracker/pages/application/application.dart';
import 'package:citracker/pages/sign_in/sign_in.dart';
import 'package:citracker/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';

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
