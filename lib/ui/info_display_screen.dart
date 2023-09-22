import 'package:flutter/material.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// This screen will be used for "Privacy Policy", "Terms & Conditions" and "About Us"

class InfoDisplayScreen extends StatelessWidget {
  final String title;
  final String text;
  final String url;

  const InfoDisplayScreen({Key key, this.title, this.text, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      children: [UiUtils.mainHeader(title), _url(), _content()],
    ))));
  }

  Widget _url() {
    return Container(
      padding: EdgeInsets.all(20),
      child: InkWell(
          child: Text(
            url,
            style: TextStyle(
                fontSize: 18,
                color: HexColor.fromHex(Constants.COLOR_APP_INTRO_TEXT_COLOR)),
          ),
          onTap: () async {
            bool b = await canLaunch(url);
            if (b) launch(url);
          }),
    );
  }

  Widget _content() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            color: HexColor.fromHex(Constants.COLOR_APP_INTRO_TEXT_COLOR)),
      ),
    );
  }
}
