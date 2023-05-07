import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:stockhauz/src/pages/index_page.dart';
import 'package:stockhauz/src/router/app_router.dart';
import 'package:stockhauz/src/pages/permission/permission_page.dart';

class AppLocation extends BeamLocation<BeamState> {
  AppLocation(super.routeInformation);

  @override
  List<String> get pathPatterns {
    return [
      AppRouter.indexRoute,
      AppRouter.permissionRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (!state.uri.pathSegments.contains('permission'))
        BeamPage(
          key: const ValueKey('index'),
          title: 'Index',
          child: IndexPage(),
        ),
      if (state.uri.pathSegments.contains('permission'))
        const BeamPage(
          key: ValueKey('permission'),
          title: 'Permission',
          child: PermissionPage(),
        ),
    ];
  }
}
