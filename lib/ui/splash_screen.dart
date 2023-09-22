import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umagram/utils/pref_util.dart';
import 'package:umagram/utils/route_generator.dart';
import 'package:umagram/utils/ui_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(RouteGenerator.LANDING);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
          UiUtils.getAppName(fontSize: 30),
          SizedBox(height: 10),
          UiUtils.getAppMainTitle(fontSize: 30),
          SizedBox(height: 10),
          UiUtils.getAppDesc(),
          UiUtils.getSubtitle()
        ]))));
  }
}
