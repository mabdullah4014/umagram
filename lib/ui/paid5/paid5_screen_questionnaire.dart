import 'package:flutter/material.dart';
import 'package:umagram/dto/paid5/dto_paid5_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid5ScreenQuestionnaire extends StatefulWidget {
  final DtoPaid5Entity dtoPaid5Entity;

  final Function(String) callback;

  const Paid5ScreenQuestionnaire({Key key, this.dtoPaid5Entity, this.callback})
      : super(key: key);

  @override
  _Paid5ScreenQuestionnaireState createState() =>
      new _Paid5ScreenQuestionnaireState();
}

class _Paid5ScreenQuestionnaireState extends State<Paid5ScreenQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: _questionnaireLayout()));
  }

  List<Widget> _questionnaireLayout() {
    List<Widget> widgets = [];
    widget.dtoPaid5Entity.questions.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    widgets.add(SizedBox(height: 10));
    widgets.add(_nextButton());
    return widgets;
  }

  Widget _singleQuestionItem(DtoPaid5Question question) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            question.statement,
            style: TextStyle(
                fontSize: 15,
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

  Widget _getRadioButton(
      DtoPaid5Question question, DtoPaid5QuestionsAnswer answer) {
    double dimen = 40;
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
    } else
      return HexColor.fromHex(Constants.COLOR_APP_RED);
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).next, () {
      if (isValid()) {
        widget.callback(getOutputResult(calculateScore()));
      }
    });
  }

  bool isValid() {
    bool allQuestionsAnswered = true;
    for (var element in widget.dtoPaid5Entity.questions) {
      if (element.selectedAnswer == null) {
        allQuestionsAnswered = false;
        break;
      }
    }
    return allQuestionsAnswered;
  }

  int calculateScore() {
    int score = 0;
    widget.dtoPaid5Entity.questions.forEach((element) {
      score = score + element.selectedAnswer.points;
    });
    return score;
  }

  String getOutputResult(int score) {
    String result;
    for (var element in widget.dtoPaid5Entity.questionnaireOutput) {
      if (score == element.score) {
        result = element.symbol;
        break;
      }
    }
    return result;
  }
}
