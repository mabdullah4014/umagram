import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/dto/paid5/dto_paid5_entity.dart';
import 'package:umagram/dto/paid6/dto_paid6_entity.dart';
import 'package:umagram/generated/json/dto_paid5_entity_helper.dart';
import 'package:umagram/generated/json/dto_paid6_entity_helper.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid5/paid5_screen_questionnaire.dart';
import 'package:umagram/ui/paid6/paid6_screen_questionnaire.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class Paid6Screen extends StatefulWidget {
  @override
  _Paid6ScreenState createState() => new _Paid6ScreenState();
}

class _Paid6ScreenState extends State<Paid6Screen> {
  Future<String> jsonData;
  DtoPaid6Entity dtoPaid6Entity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoPaid6Entity = DtoPaid6Entity();
    jsonData = Utils.loadFromAsset('paid6.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoPaid6EntityFromJson(dtoPaid6Entity, json);
            return Scaffold(
                body: SafeArea(
                    child: Column(children: <Widget>[
              UiUtils.mainHeader(S.of(context).paid6_screen_title),
              Expanded(
                  child: Paid6ScreenQuestionnaire(
                      dtoPaid6Entity: dtoPaid6Entity,
                      callback: (outputResult) {
                        BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(
                            NavItemClass(
                                NavItem.paid6ScreenResult, outputResult)));
                      }))
            ])));
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        });
  }
}
