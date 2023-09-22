import 'package:flutter/material.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid2/paid2_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class Paid5ResultScreen extends StatefulWidget {
  final String outputString;

  const Paid5ResultScreen({Key key, this.outputString}) : super(key: key);

  @override
  _Paid5ResultScreenState createState() => new _Paid5ResultScreenState();
}

class _Paid5ResultScreenState extends State<Paid5ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      UiUtils.mainHeader(S.of(context).paid5_screen_result_title),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: UiUtils.getLabel(S.of(context).paid5_screen_result_statement)),
      Expanded(child: _mainOutput(widget.outputString)),
      _nextButton()
    ])));
  }

  Widget _mainOutput(String mainOutputString) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Text(mainOutputString,
                style: TextStyle(
                    fontSize: 25,
                    color: HexColor.fromHex(
                        Constants.COLOR_APP_INTRO_TEXT_COLOR)))));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(
        context, S.of(context).paid5_screen_result_button, () {
      Utils.purchaseProduct(context, NavItem.paid6);
    });
  }
}
