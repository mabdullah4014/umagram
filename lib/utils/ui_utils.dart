import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';

class UiUtils {
  static Widget getAppName({double fontSize = 20}) {
    return RichText(
        text: TextSpan(
            text: 'ウマ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: HexColor.fromHex(Constants.COLOR_APP_RED),
                fontSize: fontSize),
            children: <TextSpan>[
          TextSpan(
              text: 'グラム',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor.fromHex(Constants.COLOR_APP_GREY),
                  fontSize: fontSize))
        ]));
  }

  static Widget getAppMainTitle({double fontSize = 18}) {
    return RichText(
        text: TextSpan(
            text: 'あなた',
            style: TextStyle(
                color: HexColor.fromHex(Constants.COLOR_APP_GREY),
                fontSize: fontSize),
            children: <TextSpan>[
          TextSpan(
              text: 'の個性は宝物',
              style: TextStyle(
                  color: HexColor.fromHex(Constants.COLOR_APP_RED),
                  fontSize: fontSize))
        ]));
  }

  static Widget getAppDesc({double fontSize = 18}) {
    return RichText(
        text: TextSpan(
            text: 'モテる自分',
            style: TextStyle(
                color: HexColor.fromHex(Constants.COLOR_APP_RED),
                fontSize: fontSize),
            children: <TextSpan>[
          TextSpan(
              text: 'に気がつこう',
              style: TextStyle(
                  color: HexColor.fromHex(Constants.COLOR_APP_GREY),
                  fontSize: fontSize))
        ]));
  }

  static Widget getSubtitle({double fontSize = 18}) {
    return RichText(
        text: TextSpan(
            text: '*自分の魅力診断アプリ',
            style: TextStyle(
                color: HexColor.fromHex(Constants.COLOR_APP_BLUE),
                fontSize: fontSize)));
  }

  static Widget mainHeader(String title) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        color: HexColor.fromHex(Constants.COLOR_APP_RED),
        child: Center(
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32))));
  }

  static Widget getLabel(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG)));
  }

  static Widget progressBarLayout(double progress) {
    return Container(
        padding: EdgeInsets.all(10),
        color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("${progress.ceil()} %",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(width: 10),
          Flexible(
              child: LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(
                HexColor.fromHex(Constants.COLOR_APP_RED)),
          ))
        ]));
  }

  static ButtonStyle _nextButtonStyle = ElevatedButton.styleFrom(
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0)),
    primary: HexColor.fromHex(Constants.COLOR_APP_RED), // background
  );

  static TextStyle _nextButtonTextStyle = TextStyle(fontSize: 24);

  static Widget _nextButtonText(BuildContext context, String text) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          text,
          style: _nextButtonTextStyle,
        ));
  }

  static Widget nextButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              style: _nextButtonStyle,
              child: _nextButtonText(context, title),
              onPressed: onPressed),
        ));
  }
}
