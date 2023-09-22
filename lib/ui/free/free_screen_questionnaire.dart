import 'package:flutter/material.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class FreeScreenQuestionnaire extends StatefulWidget {
  final DtoFreeQuestionnaire dtoFreeQuestionnaire;

  final Function(double, String, String) callback;

  const FreeScreenQuestionnaire(
      {Key key, this.dtoFreeQuestionnaire, this.callback})
      : super(key: key);

  @override
  _FreeScreenQuestionnaireState createState() =>
      new _FreeScreenQuestionnaireState();
}

class _FreeScreenQuestionnaireState extends State<FreeScreenQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: _questionnaireLayout()));
  }

  List<Widget> _questionnaireLayout() {
    List<Widget> widgets = [];
    widget.dtoFreeQuestionnaire.questions.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    widgets.add(_nextButton());
    widgets.add(SizedBox(height: 10));
    return widgets;
  }

  Widget _singleQuestionItem(DtoFreeQuestionnaireQuestion question) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            question.statement,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG)),
          ),
          SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: question.answers.map((answer) {
                return Column(
                  children: [
                    _getRadioButton(question, answer),
                    SizedBox(height: 5),
                    Text(
                      answer.statement,
                      style: TextStyle(
                          color: getRadioButtonColor(answer.type),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    )
                  ],
                );
              }).toList()),
          SizedBox(height: 10),
          Divider(color: Colors.black, height: 2)
        ]));
  }

  Widget _getRadioButton(DtoFreeQuestionnaireQuestion question,
      DtoFreeQuestionnaireQuestionsAnswer answer) {
    double dimen = getRadioButtonDimen(answer.type);
    Color color = getRadioButtonColor(answer.type);

    return InkWell(
        customBorder: new CircleBorder(),
        onTap: () {
          setState(() {
            question.selectedAnswer = answer;
          });
        },
        child: Container(
            width: dimen,
            height: dimen,
            decoration: new BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: color,
                  style: BorderStyle.solid,
                ),
                color: question.selectedAnswer == answer
                    ? color
                    : Colors.transparent,
                shape: BoxShape.circle)));
  }

  Color getRadioButtonColor(String type) {
    if (type == "Y") {
      return Colors.blue;
    } else if (type == "N") {
      return HexColor.fromHex(Constants.COLOR_APP_RED);
    } else {
      return Colors.grey;
    }
  }

  double getRadioButtonDimen(String type) {
    if (type == "Y") {
      return 50;
    } else if (type == "N") {
      return 50;
    } else {
      return 30;
    }
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).next, () {
      if (isValid()) {
        double score = calculateScore();
        widget.callback(score, getOutputSymbol(score),
            widget.dtoFreeQuestionnaire.classification);
      }
    });
  }

  bool isValid() {
    bool allQuestionsAnswered = true;
    for (var element in widget.dtoFreeQuestionnaire.questions) {
      if (element.selectedAnswer == null) {
        allQuestionsAnswered = false;
        break;
      }
    }
    return allQuestionsAnswered;
  }

  double calculateScore() {
    double score = 0;
    widget.dtoFreeQuestionnaire.questions.forEach((element) {
      score = score + element.selectedAnswer.points;
    });
    return score;
  }

  String getOutputSymbol(double score) {
    String symbol;
    for (var element in widget.dtoFreeQuestionnaire.questionOutput) {
      if (score >= element.min && score <= element.max) {
        symbol = element.symbol;
        break;
      }
    }
    return symbol;
  }
}
