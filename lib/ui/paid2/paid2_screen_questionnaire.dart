import 'package:flutter/material.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/dto/paid2/dto_paid2_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid2ScreenQuestionnaire extends StatefulWidget {
  final DtoPaid2Questionnaire dtoPaid2Questionnaire;

  final Function(int, String, String) callback;

  const Paid2ScreenQuestionnaire(
      {Key key, this.dtoPaid2Questionnaire, this.callback})
      : super(key: key);

  @override
  _Paid2ScreenQuestionnaireState createState() =>
      new _Paid2ScreenQuestionnaireState();
}

class _Paid2ScreenQuestionnaireState extends State<Paid2ScreenQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _questionnaireLayout()),
    ));
  }

  List<Widget> _questionnaireLayout() {
    List<Widget> widgets = [];
    widgets.add(UiUtils.getLabel(S.of(context).paid2_questionnaire_static_text));
    widgets.add(SizedBox(height: 10));
    widgets.add(UiUtils.getLabel(widget.dtoPaid2Questionnaire.classification));
    widgets.add(SizedBox(height: 10));
    widget.dtoPaid2Questionnaire.answers.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    widgets.add(SizedBox(height: 30));
    widgets.add(_nextButton());
    return widgets;
  }

  Widget _singleQuestionItem(DtoPaid2QuestionnaireAnswer question) {
    return Container(
        child: Column(
      children: [
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Text(question.statement,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: HexColor.fromHex(
                              Constants.COLOR_APP_PROGRESS_BAR_BG)))),
              SizedBox(width: 5),
              _getRadioButton(question)
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
        SizedBox(height: 10),
        Divider(
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG),
            height: 2)
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ));
  }

  Widget _getRadioButton(DtoPaid2QuestionnaireAnswer answer) {
    double dimen = 30;
    Color color = HexColor.fromHex(Constants.COLOR_APP_RED);

    return InkWell(
        customBorder: new CircleBorder(),
        onTap: () {
          setState(() {
            widget.dtoPaid2Questionnaire.selectedAnswer = answer;
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
                color: widget.dtoPaid2Questionnaire.selectedAnswer == answer
                    ? color
                    : Colors.transparent,
                shape: BoxShape.circle)));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).next, () {
      if (isValid()) {
        widget.callback(calculateScore(), getOutputResult(),
            widget.dtoPaid2Questionnaire.classification);
      }
    });
  }

  bool isValid() {
    return widget.dtoPaid2Questionnaire.selectedAnswer != null;
  }

  int calculateScore() {
    return widget.dtoPaid2Questionnaire.selectedAnswer.points;
  }

  String getOutputResult() {
    return widget.dtoPaid2Questionnaire.selectedAnswer.result;
  }
}
