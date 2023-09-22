import 'package:flutter/material.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid2/paid2_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:umagram/utils/utils.dart';

class Paid3ResultScreen extends StatefulWidget {
  final String outputString;

  const Paid3ResultScreen({Key key, this.outputString}) : super(key: key);

  @override
  _Paid3ResultScreenState createState() => new _Paid3ResultScreenState();
}

class _Paid3ResultScreenState extends State<Paid3ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      UiUtils.mainHeader(S.of(context).paid3_screen_title),
      SizedBox(height: 10),
      UiUtils.getLabel(S.of(context).paid3_screen_result_title),
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
                    fontSize: 20,
                    color: HexColor.fromHex(
                        Constants.COLOR_APP_INTRO_TEXT_COLOR)))));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(context, S.of(context).paid3_screen_result_button,
        () {
      Utils.purchaseProduct(context, NavItem.paid4);
    });
  }
}
