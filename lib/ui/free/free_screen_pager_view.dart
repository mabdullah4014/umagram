import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/generated/json/dto_free_entity_helper.dart';
import 'package:umagram/ui/free/free_screen_questionnaire.dart';
import 'package:umagram/utils/utils.dart';

class FreeScreenPagerView extends StatefulWidget {
  final Function(double) progressCallback;
  final Function(FreeQuestionnaireOutput) finalOutput;

  const FreeScreenPagerView({Key key, this.progressCallback, this.finalOutput})
      : super(key: key);

  @override
  _FreeScreenPagerViewState createState() => new _FreeScreenPagerViewState();
}

class _FreeScreenPagerViewState extends State<FreeScreenPagerView> {
  Future<String> jsonData;
  List<QuestionOutputs> questionsOutputsList;
  PageController pageController;
  DtoFreeEntity dtoFreeEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dtoFreeEntity = DtoFreeEntity();
    pageController = PageController();
    questionsOutputsList = [];
    jsonData = Utils.loadFromAsset('free.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jsonData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> json = jsonDecode(snapshot.data);
            dtoFreeEntityFromJson(dtoFreeEntity, json);
            return Container(
                child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, position) {
                return FreeScreenQuestionnaire(
                  dtoFreeQuestionnaire: dtoFreeEntity.questionnaire[position],
                  callback: (score, output, classification) {
                    widget.progressCallback(
                        (100 / dtoFreeEntity.questionnaire.length) *
                            (position + 1));
                    questionsOutputsList
                        .add(QuestionOutputs(score, output, classification));
                    if (position == dtoFreeEntity.questionnaire.length - 1) {
                      widget.finalOutput(FreeQuestionnaireOutput(
                          questionsOutputsList,
                          _getClassificationOutput(),
                          score.toInt()));
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }
                  },
                );
              },
              itemCount: dtoFreeEntity.questionnaire.length, // Can be null
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
    for (var element in dtoFreeEntity.questionnaireOutput) {
      if (score >= element.min && score <= element.max) {
        output = element.symbol;
        break;
      }
    }
    return output;
  }
}

class FreeQuestionnaireOutput {
  final List<QuestionOutputs> questionOutputsList;
  final String mainOutputString;
  final int finalScore;

  FreeQuestionnaireOutput(
      this.questionOutputsList, this.mainOutputString, this.finalScore);
}

class QuestionOutputs {
  final double score;
  final String outputSymbol;
  final String classificationStatement;

  QuestionOutputs(this.score, this.outputSymbol, this.classificationStatement);
}
