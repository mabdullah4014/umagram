import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid2/paid2_screen_pager_view.dart';
import 'package:umagram/ui/paid3/paid3_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid3Screen extends StatefulWidget {
  @override
  _Paid3ScreenState createState() => new _Paid3ScreenState();
}

class _Paid3ScreenState extends State<Paid3Screen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      UiUtils.mainHeader(S.of(context).paid3_screen_title),
      Expanded(
          child: Paid3ScreenPagerView(progressCallback: (progress) {
        setState(() {
          this.progress = progress;
        });
      }, finalOutput: (outputString) {
        BlocProvider.of<NavDrawerBloc>(context).add(
            NavigateTo(NavItemClass(NavItem.paid3ScreenResult, outputString)));
      })),
      UiUtils.progressBarLayout(progress)
    ])));
  }
}
