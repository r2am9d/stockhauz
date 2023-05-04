import 'package:beamer/beamer.dart';

import 'package:stockhauz/src/router/locations/dashboard_location.dart';
import 'package:stockhauz/src/router/locations/product_location.dart';

class AppRouter {
  AppRouter._internal();

  // Named Routes
  static String get indexRoute => '/index';

  static String get dashboardRoute => '/dashboard';

  static String get productRoute => '/product';
  static String get productViewRoute => '/product/view/:id';

  static String get permissionRoute => '/permission';

  // Route Locations
  static List<BeamerDelegate> get routerDelegates {
    return [
      BeamerDelegate(
        initialPath: dashboardRoute,
        locationBuilder: (routeInformation, _) {
          if (routeInformation.location!.contains(dashboardRoute)) {
            return DashboardLocation(routeInformation);
          }
          return NotFound(path: routeInformation.location!);
        },
      ),
      BeamerDelegate(
        initialPath: productRoute,
        locationBuilder: (routeInformation, _) {
          if (routeInformation.location!.contains(productRoute)) {
            return ProductLocation(routeInformation);
          }
          return NotFound(path: routeInformation.location!);
        },
      ),
    ];
  }
}
