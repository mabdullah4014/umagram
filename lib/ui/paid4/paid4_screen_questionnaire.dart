import 'package:flutter/material.dart';
import 'package:umagram/dto/free/dto_free_entity.dart';
import 'package:umagram/dto/paid2/dto_paid2_entity.dart';
import 'package:umagram/dto/paid4/dto_paid4_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid4ScreenQuestionnaire extends StatefulWidget {
  final List<DtoPaid4Questionnaire> dtoPaid4Questionnaire;

  final Function(List<String>) callback;

  const Paid4ScreenQuestionnaire(
      {Key key, this.dtoPaid4Questionnaire, this.callback})
      : super(key: key);

  @override
  _Paid4ScreenQuestionnaireState createState() =>
      new _Paid4ScreenQuestionnaireState();
}

class _Paid4ScreenQuestionnaireState extends State<Paid4ScreenQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _questionnaireLayout()),
    );
  }

  List<Widget> _questionnaireLayout() {
    List<Widget> widgets = [];
    widgets.add(UiUtils.getLabel(S.of(context).paid4_statement));
    widgets.add(SizedBox(height: 10));
    widgets.add(_expandedLayout());
    widgets.add(SizedBox(height: 10));
    widgets.add(_nextButton());
    return widgets;
  }

  Widget _expandedLayout() {
    List<Widget> widgets = [];
    widget.dtoPaid4Questionnaire.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    return Expanded(
        child: SingleChildScrollView(child: Column(children: widgets)));
  }

  Widget _singleQuestionItem(DtoPaid4Questionnaire question) {
    return Container(
        child: Column(
      children: [
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(children: [
              Flexible(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(question.option1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: HexColor.fromHex(
                                    Constants.COLOR_APP_PROGRESS_BAR_BG))),
                        SizedBox(height: 5),
                        _getRadioButton(question, question.option1, Colors.blue)
                      ])),
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(question.option2,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: HexColor.fromHex(
                                  Constants.COLOR_APP_PROGRESS_BAR_BG))),
                      SizedBox(height: 5),
                      _getRadioButton(question, question.option2,
                          HexColor.fromHex(Constants.COLOR_APP_RED))
                    ],
                  ))
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
        SizedBox(height: 10),
        Divider(
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG),
            height: 2)
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ));
  }

  Widget _getRadioButton(
      DtoPaid4Questionnaire question, String option, Color color) {
    double dimen = 30;

    return InkWell(
        customBorder: new CircleBorder(),
        onTap: () {
          setState(() {
            question.selectedOption = option;
          });
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: dimen,
            height: dimen,
            decoration: new BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: color,
                  style: BorderStyle.solid,
                ),
                color: question.selectedOption == option
                    ? color
                    : Colors.transparent,
                shape: BoxShape.circle)));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).next, () {
      if (isValid()) {
        widget.callback(getOutputList());
      }
    });
  }

  bool isValid() {
    bool allOptionsSelected = true;
    for (DtoPaid4Questionnaire dtoPaid4Questionnaire
        in widget.dtoPaid4Questionnaire) {
      if (dtoPaid4Questionnaire.selectedOption == null) {
        allOptionsSelected = false;
        break;
      }
    }
    return allOptionsSelected;
  }

  List<String> getOutputList() {
    List<String> outputList = [];
    for (DtoPaid4Questionnaire questionnaire in widget.dtoPaid4Questionnaire) {
      outputList.add(questionnaire.getOutputString());
    }
    return outputList;
  }
}
