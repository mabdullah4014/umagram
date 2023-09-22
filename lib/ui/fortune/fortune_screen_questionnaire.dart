import 'package:flutter/material.dart';
import 'package:umagram/dto/fortune/dto_fortune_entity.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/dto/paid5/dto_paid5_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class FortuneScreenQuestionnaire extends StatefulWidget {
  final DtoFortuneEntity dtoFortuneEntity;

  final Function(DtoFortuneQuestionnaireOutput) callback;

  const FortuneScreenQuestionnaire(
      {Key key, this.dtoFortuneEntity, this.callback})
      : super(key: key);

  @override
  _FortuneScreenQuestionnaireState createState() =>
      new _FortuneScreenQuestionnaireState();
}

class _FortuneScreenQuestionnaireState
    extends State<FortuneScreenQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: _questionnaireLayout()),));
  }

  List<Widget> _questionnaireLayout() {
    List<Widget> widgets = [];
    widgets.add(SizedBox(height: 10));
    widgets.add(UiUtils.getLabel(S.of(context).fortune_questionnaire_static_text));
    widgets.add(SizedBox(height: 10));
    widgets.add(UiUtils.getLabel(S.of(context).fortune_screen_statement));
    widgets.add(SizedBox(height: 10));
    widget.dtoFortuneEntity.questions.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    widgets.add(SizedBox(height: 10));
    widgets.add(_nextButton());
    return widgets;
  }

  Widget _singleQuestionItem(DtoFortuneQuestion question) {
    return Container(
        padding: EdgeInsets.all(10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: question.answers.map((answer) {
                    return _getRadioButton(question, answer);
                  }).toList())),
          SizedBox(height: 10),
          Divider(color: Colors.black, height: 2)
        ]));
  }

  Widget _getRadioButton(
      DtoFortuneQuestion question, DtoFortuneQuestionsAnswer answer) {
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
    for (var element in widget.dtoFortuneEntity.questions) {
      if (element.selectedAnswer == null) {
        allQuestionsAnswered = false;
        break;
      }
    }
    return allQuestionsAnswered;
  }

  int calculateScore() {
    int score = 0;
    widget.dtoFortuneEntity.questions.forEach((element) {
      if (element.selectedAnswer.statement == element.originalAnswer) score++;
    });
    return score;
  }

  DtoFortuneQuestionnaireOutput getOutputResult(int score) {
    DtoFortuneQuestionnaireOutput result;
    for (var element in widget.dtoFortuneEntity.questionnaireOutput) {
      if (score >= element.min && score <= element.max) {
        result = element;
        break;
      }
    }
    return result;
  }
}
