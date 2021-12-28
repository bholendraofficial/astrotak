import 'package:astrotak/app/app_logger.dart';
import 'package:astrotak/routes/routes.dart';
import 'package:astrotak/screens/activity/dashboard_screen.dart';
import 'package:astrotak/screens/activity/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case Routes.splashScreen:
        {
          return pageRouteBuilder(const SplashScreen());
        }
      case Routes.dashboardScreen:
        {
          return pageRouteBuilder(const DashboardScreen());
        }
      default:
        {
          return pageRouteBuilder(const SplashScreen());
        }
    }
  }

  static PageRouteBuilder pageRouteBuilder(Widget pageWidget) {
    AppLogger(pageWidget);
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          pageWidget,
      transitionDuration: Duration.zero,
    );
  }
}
