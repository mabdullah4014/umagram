import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/dto/paid2/dto_paid2_entity.dart';
import 'package:umagram/generated/json/dto_free_entity_helper.dart';
import 'package:umagram/generated/json/dto_paid2_entity_helper.dart';
import 'package:umagram/ui/free/free_screen_questionnaire.dart';
import 'package:umagram/ui/paid2/paid2_screen_questionnaire.dart';
import 'package:umagram/utils/utils.dart';

class Paid2ScreenPagerView extends StatefulWidget {
  final Function(double) progressCallback;
  final Function(Paid2QuestionnaireOutput) finalOutput;

  const Paid2ScreenPagerView({Key key, this.progressCallback, this.finalOutput})
      : super(key: key);

  @override
  _Paid2ScreenPagerViewState createState() => new _Paid2ScreenPagerViewState();
}

class _Paid2ScreenPagerViewState extends State<Paid2ScreenPagerView> {
  Future<String> jsonData;
  List<QuestionOutputs> questionsOutputsList;
  PageController pageController;
  DtoPaid2Entity dtoPaid2Entity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoPaid2Entity = DtoPaid2Entity();
    pageController = PageController();
    questionsOutputsList = [];
    jsonData = Utils.loadFromAsset('paid2.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoPaid2EntityFromJson(dtoPaid2Entity, json);
            return Container(
                child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, position) {
                return Paid2ScreenQuestionnaire(
                  dtoPaid2Questionnaire: dtoPaid2Entity.questionnaire[position],
                  callback: (score, output, classification) {
                    widget.progressCallback(
                        (100 / dtoPaid2Entity.questionnaire.length) *
                            (position + 1));
                    questionsOutputsList
                        .add(QuestionOutputs(score, output, classification));
                    if (position == dtoPaid2Entity.questionnaire.length - 1) {
                      widget.finalOutput(Paid2QuestionnaireOutput(
                          questionsOutputsList, _getClassificationOutput()));
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                );
              },
              itemCount: dtoPaid2Entity.questionnaire.length, // Can be null
            ));
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        });
  }

  String _getClassificationOutput() {
    String output;
    double score = 0;
    questionsOutputsList.forEach((element) {
      score = score + element.score;
    });
    for (var element in dtoPaid2Entity.questionnaireOutput) {
      if (score >= element.min && score <= element.max) {
        output = element.output;
        break;
      }
    }
    return output;
  }
}

class Paid2QuestionnaireOutput {
  final List<QuestionOutputs> questionOutputsList;
  final String mainOutputString;

  Paid2QuestionnaireOutput(this.questionOutputsList, this.mainOutputString);
}

class QuestionOutputs {
  final int score;
  final String outputResult;
  final String classificationStatement;

  QuestionOutputs(this.score, this.outputResult, this.classificationStatement);
}
