import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/dto/paid5/dto_paid5_entity.dart';
import 'package:umagram/generated/json/dto_paid5_entity_helper.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid5/paid5_screen_questionnaire.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class Paid5Screen extends StatefulWidget {
  @override
  _Paid5ScreenState createState() => new _Paid5ScreenState();
}

class _Paid5ScreenState extends State<Paid5Screen> {
  Future<String> jsonData;
  DtoPaid5Entity dtoPaid5Entity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoPaid5Entity = DtoPaid5Entity();
    jsonData = Utils.loadFromAsset('paid5.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoPaid5EntityFromJson(dtoPaid5Entity, json);
            return Scaffold(
                body: SafeArea(
                    child: Column(children: <Widget>[
              UiUtils.mainHeader(S.of(context).paid5_screen_title),
              Expanded(
                  child: Paid5ScreenQuestionnaire(
                    dtoPaid5Entity: dtoPaid5Entity,
                      callback: (outputResult) {
                BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(
                    NavItemClass(NavItem.paid5ScreenResult, outputResult)));
              }))
            ])));
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        });
  }
}
