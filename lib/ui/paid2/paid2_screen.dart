import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid2/paid2_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid2Screen extends StatefulWidget {
  @override
  _Paid2ScreenState createState() => new _Paid2ScreenState();
}

class _Paid2ScreenState extends State<Paid2Screen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      UiUtils.mainHeader(S.of(context).paid2_screen_title),
      Expanded(
          child: Paid2ScreenPagerView(progressCallback: (progress) {
        setState(() {
          this.progress = progress;
        });
      }, finalOutput: (paid2QuestionnaireOutput) {
        BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(
            NavItemClass(NavItem.paid2ScreenResult, paid2QuestionnaireOutput)));
      })),
      UiUtils.progressBarLayout(progress)
    ])));
  }
}
