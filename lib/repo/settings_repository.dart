
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:umagram/utils/pref_util.dart';

// ValueNotifier<Setting> setting = new ValueNotifier(new Setting());

/*Future<Setting> initSettings() async {
  final String url =
      '${GlobalConfiguration().get('base_url')}configs';
  final response = await http.get(url);
  ApiResponse<Setting> setting = AppUtils.getResponseObject(response);
  return setting.data;
}*/

void setBrightness(Brightness brightness) async {
  brightness == Brightness.dark
      ? PreferenceUtils.setBool("isDark", true)
      : PreferenceUtils.setBool("isDark", false);
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    PreferenceUtils.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  return PreferenceUtils.getString('language', defaultLanguage);
}