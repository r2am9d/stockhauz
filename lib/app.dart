import 'package:flutter/material.dart';

import 'package:stockhauz/src/pages/permission/permission_page.dart';

class App extends StatelessWidget {
  const App({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const PermissionPage(),
    );
  }
}
