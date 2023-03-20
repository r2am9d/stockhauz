import 'package:flutter/material.dart';

class AppColor {
  factory AppColor() => _instance;

  AppColor._internal();

  static final AppColor _instance = AppColor._internal();

  Color get primary => const Color(0xff155575);
  Color get secondary => const Color(0xff9c1246);

  Color get black => const Color(0xff000000);
  Color get white => const Color(0xfffbfbfb);
  Color get dirtyWhite => const Color(0xfff3f3f6);
}
