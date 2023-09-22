import 'package:flutter/material.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/free/free_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class FreeResultScreen extends StatefulWidget {
  final FreeQuestionnaireOutput freeQuestionnaireOutput;

  const FreeResultScreen({Key key, this.freeQuestionnaireOutput})
      : super(key: key);

  @override
  _FreeResultScreenState createState() => new _FreeResultScreenState();
}

class _FreeResultScreenState extends State<FreeResultScreen> {
  // TODO: add state variables and methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
      UiUtils.mainHeader(S.of(context).free_screen_result_title),
      SizedBox(height: 5),
      UiUtils.getLabel(
          "あなたのモテ度は${widget.freeQuestionnaireOutput.finalScore}点です。"),
      _mainOutput(widget.freeQuestionnaireOutput.mainOutputString),
      _questionsOutput(widget.freeQuestionnaireOutput.questionOutputsList),
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
    widgets.add(SizedBox(height: 5));
    widgets.add(UiUtils.getLabel(S.of(context).free_result_screen_static_text));
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
        "${questionOutputs.outputSymbol} ${questionOutputs.classificationStatement}",
        style: TextStyle(
            fontSize: 15,
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG)),
      ),
      SizedBox(height: 15),
      Divider(color: Colors.black, height: 1)
    ]));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).free_screen_result_button,
        () {
      Utils.purchaseProduct(context, NavItem.paid2);
    });
  }
}
