import 'package:flutter/material.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class Paid4ResultScreen extends StatefulWidget {
  final List<String> outputList;

  const Paid4ResultScreen({Key key, this.outputList}) : super(key: key);

  @override
  _Paid4ResultScreenState createState() => new _Paid4ResultScreenState();
}

class _Paid4ResultScreenState extends State<Paid4ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      UiUtils.mainHeader(S.of(context).paid4_screen_result_title),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: UiUtils.getLabel(S.of(context).paid4_screen_result_statement)),
      _questionsOutput(),
      _nextButton()
    ]))));
  }

  Widget _questionsOutput() {
    List<Widget> widgets = [];
    widget.outputList.forEach((element) {
      widgets.add(_questionOutputItem(element));
      widgets.add(SizedBox(height: 10));
    });
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: widgets));
  }

  Widget _questionOutputItem(String output) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "$output 人",
        style: TextStyle(
            fontSize: 15,
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG)),
      ),
      SizedBox(height: 15),
      Divider(color: Colors.black, height: 2)
    ]));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).paid4_screen_result_button,
        () {
      Utils.purchaseProduct(context, NavItem.paid5);
    });
  }
}
