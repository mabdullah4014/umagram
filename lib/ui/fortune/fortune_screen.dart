import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/dto/fortune/dto_fortune_entity.dart';
import 'package:umagram/dto/paid5/dto_paid5_entity.dart';
import 'package:umagram/generated/json/dto_fortune_entity_helper.dart';
import 'package:umagram/generated/json/dto_paid5_entity_helper.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid5/paid5_screen_questionnaire.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

import 'fortune_screen_questionnaire.dart';

class FortuneScreen extends StatefulWidget {
  @override
  _FortuneScreenState createState() => new _FortuneScreenState();
}

class _FortuneScreenState extends State<FortuneScreen> {
  Future<String> jsonData;
  DtoFortuneEntity dtoFortuneEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoFortuneEntity = DtoFortuneEntity();
    jsonData = Utils.loadFromAsset('fortune.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoFortuneEntityFromJson(dtoFortuneEntity, json);
            return Scaffold(
                body: SafeArea(
                    child: Column(children: <Widget>[
              UiUtils.mainHeader(S.of(context).fortune_screen_title),
              Expanded(
                  child: FortuneScreenQuestionnaire(
                      dtoFortuneEntity: dtoFortuneEntity,
                      callback: (outputResult) {
                        BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(
                            NavItemClass(
                                NavItem.fortuneScreenResult, outputResult)));
                      }))
            ])));
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        });
  }
}
