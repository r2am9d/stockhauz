import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:stockhauz/app.dart';
import 'package:stockhauz/src/utils/db_util.dart';
import 'package:stockhauz/src/utils/log_util.dart';
import 'package:stockhauz/src/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LogUtil.initialize();
  await DbUtil.initialize();

  final appTheme = await AppTheme.instance;
  runApp(ProviderScope(child: App(theme: appTheme.theme)));
}
