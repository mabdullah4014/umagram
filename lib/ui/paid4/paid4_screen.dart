import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid4/paid4_screen_pager_view.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid4Screen extends StatefulWidget {
  @override
  _Paid4ScreenState createState() => new _Paid4ScreenState();
}

class _Paid4ScreenState extends State<Paid4Screen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      UiUtils.mainHeader(S.of(context).paid4_screen_title),
      Expanded(
          child: Paid4ScreenPagerView(progressCallback: (progress) {
        setState(() {
          this.progress = progress;
        });
      }, finalOutput: (outputString) {
        BlocProvider.of<NavDrawerBloc>(context).add(
            NavigateTo(NavItemClass(NavItem.paid4ScreenResult, outputString)));
      })),
      UiUtils.progressBarLayout(progress)
    ])));
  }
}
