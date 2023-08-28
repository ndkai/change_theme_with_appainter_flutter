import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:multi_theme_with_appainter/theme_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  late SharedPreferences preferences;
  late final lightTheme;
  late final darkTheme;

  Future<AppTheme> init() async {
    preferences = await SharedPreferences.getInstance();
    final lightThemStr = await rootBundle.loadString("assets/light_theme.json");
    final lightThemeJson = jsonDecode(lightThemStr);
    final darkThemeStr = await rootBundle.loadString("assets/dark_theme.json");
    final darkThemeJson = jsonDecode(darkThemeStr);
    lightTheme = ThemeDecoder.decodeThemeData(lightThemeJson);
    darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson);

    return this;
  }

  void saveTheme(ThemeType type) {
    preferences.setString("theme", type.name);
  }

  ThemeType getTheme() {
    String? theme = preferences.getString("theme");
    if (theme == null) {
      return ThemeType.light;
    }
    if(theme == ThemeType.dark.name){
      return ThemeType.dark;
    }
    if(theme == ThemeType.light.name){
      return ThemeType.light;
    }
    return ThemeType.light;
  }
}
