import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:umagram/dto/paid3/dto_paid3_entity.dart';
import 'package:umagram/generated/json/dto_paid3_entity_helper.dart';
import 'package:umagram/ui/paid2/paid2_screen_questionnaire.dart';
import 'package:umagram/ui/paid3/paid3_screen_questionnaire.dart';
import 'package:umagram/utils/utils.dart';

class Paid3ScreenPagerView extends StatefulWidget {
  final Function(double) progressCallback;
  final Function(String) finalOutput;

  const Paid3ScreenPagerView({Key key, this.progressCallback, this.finalOutput})
      : super(key: key);

  @override
  _Paid3ScreenPagerViewState createState() => new _Paid3ScreenPagerViewState();
}

class _Paid3ScreenPagerViewState extends State<Paid3ScreenPagerView> {
  Future<String> jsonData;
  Paid3QuestionOutput paid3questionOutput;
  PageController pageController;
  DtoPaid3Entity dtoPaid3Entity;

  int pagerCount = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoPaid3Entity = DtoPaid3Entity();
    pageController = PageController();
    paid3questionOutput = Paid3QuestionOutput();
    jsonData = Utils.loadFromAsset('paid3.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoPaid3EntityFromJson(dtoPaid3Entity, json);
            return Container(
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, position) {
                      return Paid3ScreenQuestionnaire(
                          position: position,
                          dtoPaid3QuestionnaireList:
                              dtoPaid3Entity.questionnaire,
                          callback: (questionnaireList) {
                            widget.progressCallback(
                                (100 / pagerCount) * (position + 1));
                            if (position == 0) {
                              paid3questionOutput.list1 = questionnaireList;
                            } else {
                              paid3questionOutput.list2 = questionnaireList;
                            }
                            if (position == pagerCount - 1) {
                              widget.finalOutput(_getClassificationOutput());
                            } else {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          });
                    },
                    itemCount: pagerCount));
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        });
  }

  String _getClassificationOutput() {
    String output;
    double score = 0;
    for (var i = 0; i < dtoPaid3Entity.questionnaire.length; i++) {
      if (paid3questionOutput.list1[i].isSelected &&
          paid3questionOutput.list2[i].isSelected) score++;
    }
    for (var element in dtoPaid3Entity.questionnaireOutput) {
      if (score >= element.min && score <= element.max) {
        output = element.output;
        break;
      }
    }
    return output;
  }
}

class Paid3QuestionOutput {
  List<DtoPaid3Questionnaire> list1;
  List<DtoPaid3Questionnaire> list2;
}
