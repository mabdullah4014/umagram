import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      children: [_mainHeader(context), _content(context)],
    ))));
  }

  Widget _mainHeader(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        color: HexColor.fromHex(Constants.COLOR_APP_RED),
        child: Column(
          children: [
            Text(S.of(context).intro_title_1,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32)),
            SizedBox(height: 20),
            InkWell(
                onTap: () {
                  BlocProvider.of<NavDrawerBloc>(context)
                      .add(NavigateTo(NavItemClass(NavItem.freeScreen, null)));
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                        color: HexColor.fromHex(Constants.COLOR_APP_LIGHT_RED),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0))),
                    child: new Center(
                      child: new Text(S.of(context).intro_title_2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor.fromHex(
                                  Constants.COLOR_APP_LIGHT_GREY),
                              fontSize: 24)),
                    )))
          ],
        ));
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        S.of(context).desc,
        style: TextStyle(
            fontSize: 14,
            color: HexColor.fromHex(Constants.COLOR_APP_INTRO_TEXT_COLOR)),
      ),
    );
  }
}
