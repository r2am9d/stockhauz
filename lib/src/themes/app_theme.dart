import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import 'package:stockhauz/gen/assets.gen.dart';

class AppTheme {
  AppTheme._internal();

  static Future<AppTheme> get instance async {
    _themeString = await rootBundle.loadString(Assets.themes.appTheme);
    _theme = ThemeDecoder.decodeThemeData(jsonDecode(_themeString))!;

    return _instance;
  }

  static late final ThemeData _theme;
  static late final String _themeString;
  static final AppTheme _instance = AppTheme._internal();

  ThemeData get theme => _theme;
}
