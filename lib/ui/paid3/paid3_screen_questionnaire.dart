import 'package:flutter/material.dart';
import 'package:umagram/dto/paid3/dto_paid3_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class Paid3ScreenQuestionnaire extends StatefulWidget {
  final List<DtoPaid3Questionnaire> dtoPaid3QuestionnaireList;

  final Function(List<DtoPaid3Questionnaire>) callback;

  final int position;

  const Paid3ScreenQuestionnaire(
      {Key key, this.position, this.dtoPaid3QuestionnaireList, this.callback})
      : super(key: key);

  @override
  _Paid3ScreenQuestionnaireState createState() =>
      new _Paid3ScreenQuestionnaireState();
}

class _Paid3ScreenQuestionnaireState extends State<Paid3ScreenQuestionnaire> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _questionnaireLayout()),
    );
  }

  List<Widget> _questionnaireLayout() {
    List<Widget> widgets = [];
    widgets.add(UiUtils.getLabel(widget.position == 0
        ? S.of(context).paid3_statement_page1
        : S.of(context).paid3_statement_page2));
    widgets.add(SizedBox(height: 10));
    widgets.add(_expandedLayout());
    widgets.add(SizedBox(height: 10));
    widgets.add(_nextButton());
    return widgets;
  }

  Widget _expandedLayout() {
    List<Widget> widgets = [];
    widget.dtoPaid3QuestionnaireList.forEach((element) {
      widgets.add(_singleQuestionItem(element));
    });
    return Expanded(
        child: SingleChildScrollView(child: Column(children: widgets)));
  }

  Widget _singleQuestionItem(DtoPaid3Questionnaire question) {
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

  Widget _getCheckbox(DtoPaid3Questionnaire answer) {
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
        widget.callback(widget.dtoPaid3QuestionnaireList);
      }
    });
  }

  bool isValid() {
    bool isAnyItemSelected = false;
    for (DtoPaid3Questionnaire itemSelected
        in widget.dtoPaid3QuestionnaireList) {
      if (itemSelected.isSelected) {
        isAnyItemSelected = true;
        break;
      }
    }
    return isAnyItemSelected;
  }
}
