// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shared_preferences/shared_preferences.dart';

class Setting {
  bool useDarkTheme;
  bool hasInitialized;
  Setting({
    this.useDarkTheme = false,
    this.hasInitialized = false,
  });

  static Future<Setting> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return Setting(
        useDarkTheme: prefs.getBool('useDarkTheme') ?? false,
        hasInitialized: true);
  }

  static setSetting(Setting setting) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("useDarkTheme", setting.useDarkTheme);
  }
}
