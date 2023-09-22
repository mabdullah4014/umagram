import 'package:flutter/material.dart';
import 'package:umagram/dto/paid6/dto_paid6_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid6ScreenQuestionnaire extends StatefulWidget {
  final DtoPaid6Entity dtoPaid6Entity;

  final Function(String) callback;

  const Paid6ScreenQuestionnaire({Key key, this.dtoPaid6Entity, this.callback})
      : super(key: key);

  @override
  _Paid6ScreenQuestionnaireState createState() =>
      new _Paid6ScreenQuestionnaireState();
}

class _Paid6ScreenQuestionnaireState extends State<Paid6ScreenQuestionnaire> {
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
    widgets.add(UiUtils.getLabel(S.of(context).paid6_screen_statement));
    widgets.add(SizedBox(height: 10));
    widget.dtoPaid6Entity.questionnaire.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    widgets.add(SizedBox(height: 20));
    widgets.add(_nextButton());
    return widgets;
  }

  Widget _singleQuestionItem(DtoPaid6Questionnaire question) {
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
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: HexColor.fromHex(
                              Constants.COLOR_APP_PROGRESS_BAR_BG)))),
              _getCheckbox(question)
            ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
        SizedBox(height: 10),
        Divider(
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG),
            height: 2)
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ));
  }

  Widget _getCheckbox(DtoPaid6Questionnaire answer) {
    double dimen = 30;
    Color color = HexColor.fromHex(Constants.COLOR_APP_RED);

    return InkWell(
        customBorder: new CircleBorder(),
        onTap: () {
          setState(() {
            answer.isSelected = !answer.isSelected;
          });
        },
        child: Container(
          width: dimen,
          height: dimen,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: color,
                style: BorderStyle.solid,
              )),
          child: Center(
            child: answer.isSelected
                ? Icon(
                    Icons.check,
                    size: 15,
                    color: color,
                  )
                : Icon(
                    null,
                    size: 15,
                    color: Colors.grey,
                  ),
          ),
        ));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).next, () {
      if (isValid()) {
        widget.callback(outputResult());
      }
    });
  }

  bool isValid() {
    bool isAnyItemSelected = false;
    for (DtoPaid6Questionnaire itemSelected
        in widget.dtoPaid6Entity.questionnaire) {
      if (itemSelected.isSelected) {
        isAnyItemSelected = true;
        break;
      }
    }
    return isAnyItemSelected;
  }

  String outputResult() {
    String output;
    int count = 0;
    for (DtoPaid6Questionnaire itemSelected
        in widget.dtoPaid6Entity.questionnaire) {
      if (itemSelected.isSelected) {
        count++;
      }
    }

    for (var element in widget.dtoPaid6Entity.questionnaireOutput) {
      if (count >= element.min && count <= element.max) {
        output = element.output;
        break;
      }
    }

    return output;
  }
}
