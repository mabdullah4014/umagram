import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/drawer_event.dart';
import 'package:umagram/drawer/drawer_widget.dart';
import 'package:umagram/drawer/nav_drawer_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/ui/fortune/fortune_result_screen.dart';
import 'package:umagram/ui/fortune/fortune_screen.dart';
import 'package:umagram/ui/free/free_result_screen.dart';
import 'package:umagram/ui/free/free_screen.dart';
import 'package:umagram/ui/info_display_screen.dart';
import 'package:umagram/ui/intro_screen.dart';
import 'package:umagram/ui/paid2/paid2_result_screen.dart';
import 'package:umagram/ui/paid2/paid2_screen.dart';
import 'package:umagram/ui/paid3/paid3_result_screen.dart';
import 'package:umagram/ui/paid3/paid3_screen.dart';
import 'package:umagram/ui/paid4/paid4_result_screen.dart';
import 'package:umagram/ui/paid4/paid4_screen.dart';
import 'package:umagram/ui/paid5/paid5_result_screen.dart';
import 'package:umagram/ui/paid5/paid5_screen.dart';
import 'package:umagram/ui/paid6/paid6_result_screen.dart';
import 'package:umagram/ui/paid6/paid6_screen.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/ui_utils.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // ignore: close_sinks
  NavDrawerBloc _bloc;
  Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc =
        NavDrawerBloc(NavDrawerState(NavItemClass(NavItem.introScreen, null)));
    _content = _getContentForState(_bloc.state.selectedItem);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                    content: new Text(S.of(context).exit),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: new Text(S.of(context).yes)),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: new Text(S.of(context).no))
                    ]))) ??
        false;
  }

  @override
  Widget build(BuildContext context) => BlocProvider<NavDrawerBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocListener<NavDrawerBloc, NavDrawerState>(
          listener: (BuildContext context, NavDrawerState state) {
            setState(() {
              _content = _getContentForState(state.selectedItem);
            });
          },
          child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
              builder: (BuildContext context, NavDrawerState state) =>
                  WillPopScope(
                      onWillPop: _onWillPop,
                      child: SafeArea(
                          child: Scaffold(
                              endDrawer: NavDrawerWidget(),
                              appBar: PreferredSize(
                                  preferredSize:
                                      Size.fromHeight(Constants.APP_BAR_HEIGHT),
                                  child: AppBar(
                                      centerTitle: false,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0,
                                      title: InkWell(
                                          onTap: () {
                                            BlocProvider.of<NavDrawerBloc>(
                                                    context)
                                                .add(NavigateTo(NavItemClass(
                                                    NavItem.introScreen,
                                                    null)));
                                          },
                                          child: UiUtils.getAppName()))),
                              resizeToAvoidBottomInset: true,
                              body: AnimatedSwitcher(
                                  switchInCurve: Curves.easeInExpo,
                                  switchOutCurve: Curves.easeOutExpo,
                                  duration: Duration(milliseconds: 300),
                                  child: _content)))))));

  _getContentForState(NavItemClass navItemClass) {
    switch (navItemClass.type) {
      case NavItem.introScreen:
        return IntroScreen();
      case NavItem.freeScreen:
        return FreeScreen();
      case NavItem.freeScreenResult:
        return FreeResultScreen(
            freeQuestionnaireOutput: navItemClass.arguments);
      case NavItem.paid2:
        return Paid2Screen();
      case NavItem.paid2ScreenResult:
        return Paid2ResultScreen(
            paid2QuestionnaireOutput: navItemClass.arguments);
      case NavItem.paid3:
        return Paid3Screen();
      case NavItem.paid3ScreenResult:
        return Paid3ResultScreen(outputString: navItemClass.arguments);
      case NavItem.paid4:
        return Paid4Screen();
      case NavItem.paid4ScreenResult:
        return Paid4ResultScreen(outputList: navItemClass.arguments);
      case NavItem.paid5:
        return Paid5Screen();
      case NavItem.paid5ScreenResult:
        return Paid5ResultScreen(outputString: navItemClass.arguments);
      case NavItem.paid6:
        return Paid6Screen();
      case NavItem.paid6ScreenResult:
        return Paid6ResultScreen(outputString: navItemClass.arguments);
      case NavItem.fortune:
        return FortuneScreen();
      case NavItem.fortuneScreenResult:
        return FortuneResultScreen(dtoFortuneOutput: navItemClass.arguments);
      case NavItem.termsAndConditions:
        return InfoDisplayScreen(
            title: S.of(context).t_and_c,
            url: "http://equable-step.surge.sh/index.html",
            text: S.of(context).t_and_c_text);
      case NavItem.privacyPolicy:
        return InfoDisplayScreen(
            title: S.of(context).privacy_policy,
            url: "http://equable-step.surge.sh/About.html",
            text: S.of(context).privacy_policy_text);
      default:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}
