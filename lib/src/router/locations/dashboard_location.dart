import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:stockhauz/src/router/app_router.dart';
import 'package:stockhauz/src/pages/dashboard/dashboard_page.dart';

class DashboardLocation extends BeamLocation<BeamState> {
  DashboardLocation(super.routeInformation);

  @override
  List<String> get pathPatterns {
    return [
      AppRouter.dashboardRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('dashboard'),
        title: 'Dashboard',
        child: DashboardPage(),
        type: BeamPageType.noTransition,
      ),
    ];
  }
}
