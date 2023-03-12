import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:stockhauz/app.dart';
import 'package:stockhauz/src/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appTheme = await AppTheme.instance;
  runApp(ProviderScope(child: App(theme: appTheme.theme)));
}
