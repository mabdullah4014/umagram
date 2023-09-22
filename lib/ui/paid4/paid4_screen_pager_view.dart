import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/dto/paid2/dto_paid2_entity.dart';
import 'package:umagram/dto/paid4/dto_paid4_entity.dart';
import 'package:umagram/generated/json/dto_free_entity_helper.dart';
import 'package:umagram/generated/json/dto_paid2_entity_helper.dart';
import 'package:umagram/generated/json/dto_paid4_entity_helper.dart';
import 'package:umagram/ui/free/free_screen_questionnaire.dart';
import 'package:umagram/ui/paid2/paid2_screen_questionnaire.dart';
import 'package:umagram/ui/paid4/paid4_screen_questionnaire.dart';
import 'package:umagram/utils/utils.dart';

class Paid4ScreenPagerView extends StatefulWidget {
  final Function(double) progressCallback;
  final Function(List<String>) finalOutput;

  const Paid4ScreenPagerView({Key key, this.progressCallback, this.finalOutput})
      : super(key: key);

  @override
  _Paid4ScreenPagerViewState createState() => new _Paid4ScreenPagerViewState();
}

class _Paid4ScreenPagerViewState extends State<Paid4ScreenPagerView> {
  Future<String> jsonData;
  List<String> questionsOutputsList;
  PageController pageController;
  DtoPaid4Entity dtoPaid4Entity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoPaid4Entity = DtoPaid4Entity();
    pageController = PageController();
    questionsOutputsList = [];
    jsonData = Utils.loadFromAsset('paid4.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoPaid4EntityFromJson(dtoPaid4Entity, json);
            return Container(
                child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, position) {
                return Paid4ScreenQuestionnaire(
                  dtoPaid4Questionnaire: dtoPaid4Entity.questionnaire[position],
                  callback: (outputList) {
                    widget.progressCallback(
                        (100 / dtoPaid4Entity.questionnaire.length) *
                            (position + 1));
                    questionsOutputsList.addAll(outputList);
                    if (position == dtoPaid4Entity.questionnaire.length - 1) {
                      widget.finalOutput(questionsOutputsList);
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                );
              },
              itemCount: dtoPaid4Entity.questionnaire.length, // Can be null
            ));
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        });
  }
}
