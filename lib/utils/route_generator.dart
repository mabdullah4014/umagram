import 'package:flutter/material.dart';
import 'package:umagram/ui/free/free_result_screen.dart';
import 'package:umagram/ui/free/free_screen.dart';
import 'package:umagram/ui/free/free_screen_pager_view.dart';
import 'package:umagram/ui/intro_screen.dart';
import 'package:umagram/ui/landing_screen.dart';
import 'package:umagram/ui/splash_screen.dart';

class RouteGenerator {
  static const String SPLASH = '/SPLASH';
  static const String LANDING = '/LANDING';
  static const String FREE_RESULT = '/FREE_RESULT';

  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LANDING:
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case FREE_RESULT:
        return MaterialPageRoute(
            builder: (_) => FreeResultScreen(
                freeQuestionnaireOutput: args as FreeQuestionnaireOutput));
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
