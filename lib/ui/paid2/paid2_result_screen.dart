import 'package:flutter/material.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid2/paid2_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class Paid2ResultScreen extends StatefulWidget {
  final Paid2QuestionnaireOutput paid2QuestionnaireOutput;

  const Paid2ResultScreen({Key key, this.paid2QuestionnaireOutput})
      : super(key: key);

  @override
  _Paid2ResultScreenState createState() => new _Paid2ResultScreenState();
}

class _Paid2ResultScreenState extends State<Paid2ResultScreen> {
  // TODO: add state variables and methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
      UiUtils.mainHeader(S.of(context).paid2_screen_result_title),
      _mainOutput(widget.paid2QuestionnaireOutput.mainOutputString),
      _questionsOutput(widget.paid2QuestionnaireOutput.questionOutputsList),
      _nextButton()
    ]))));
  }

  Widget _mainOutput(String mainOutputString) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UiUtils.getLabel(S.of(context).overview),
          SizedBox(height: 5),
          Text(
            mainOutputString,
            style: TextStyle(
                fontSize: 20,
                color: HexColor.fromHex(Constants.COLOR_APP_INTRO_TEXT_COLOR)),
          )
        ]));
  }

  Widget _questionsOutput(List<QuestionOutputs> questionOutputsList) {
    List<Widget> widgets = [];
    widgets.add(UiUtils.getLabel(S.of(context).individual_items));
    widgets.add(SizedBox(height: 10));
    questionOutputsList.forEach((element) {
      widgets.add(_questionOutputItem(element));
      widgets.add(SizedBox(height: 10));
    });
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: widgets));
  }

  Widget _questionOutputItem(QuestionOutputs questionOutputs) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "${questionOutputs.classificationStatement.split("（")[0]} :\n ${questionOutputs.outputResult}",
        style: TextStyle(
            fontSize: 15,
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG)),
      ),
      SizedBox(height: 15),
      Divider(color: Colors.black, height: 2)
    ]));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).paid2_screen_result_button,
        () {
      Utils.purchaseProduct(context, NavItem.paid3);
    });
  }
}
