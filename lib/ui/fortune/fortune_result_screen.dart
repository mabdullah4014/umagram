import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/dto/fortune/dto_fortune_entity.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/paid2/paid2_screen_pager_view.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';

class FortuneResultScreen extends StatefulWidget {
  final DtoFortuneQuestionnaireOutput dtoFortuneOutput;

  const FortuneResultScreen({Key key, this.dtoFortuneOutput}) : super(key: key);

  @override
  _FortuneResultScreenState createState() => new _FortuneResultScreenState();
}

class _FortuneResultScreenState extends State<FortuneResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      UiUtils.mainHeader(S.of(context).fortune_screen_result_title),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:
              UiUtils.getLabel(S.of(context).fortune_screen_result_statement)),
      Expanded(child: _mainOutput(widget.dtoFortuneOutput)),
      _nextButton()
    ])));
  }

  Widget _mainOutput(DtoFortuneQuestionnaireOutput mainOutput) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mainOutput.symbol,
                style: TextStyle(
                    fontSize: 30,
                    color: HexColor.fromHex(
                        Constants.COLOR_APP_INTRO_TEXT_COLOR))),
            SizedBox(height: 10),
            Text(mainOutput.comments,
                style: TextStyle(
                    fontSize: 30,
                    color:
                        HexColor.fromHex(Constants.COLOR_APP_INTRO_TEXT_COLOR)))
          ],
        )));
  }

  Widget _nextButton() {
    return UiUtils.nextButton(
        context, S.of(context).fortune_screen_result_button, () {
      BlocProvider.of<NavDrawerBloc>(context)
          .add(NavigateTo(NavItemClass(NavItem.introScreen, null)));
    });
  }
}
