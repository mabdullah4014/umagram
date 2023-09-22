import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/free/free_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/route_generator.dart';
import 'package:umagram/utils/ui_utils.dart';

class FreeScreen extends StatefulWidget {
  @override
  _FreeScreenState createState() => new _FreeScreenState();
}

class _FreeScreenState extends State<FreeScreen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      UiUtils.mainHeader(S.of(context).free_screen_title),
      Expanded(
          child: FreeScreenPagerView(progressCallback: (progress) {
        setState(() {
          this.progress = progress;
        });
      }, finalOutput: (freeQuestionnaireOutput) {
        BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(
            NavItemClass(NavItem.freeScreenResult, freeQuestionnaireOutput)));
      })),
      UiUtils.progressBarLayout(progress)
    ])));
  }
}
