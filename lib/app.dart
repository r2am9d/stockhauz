import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stockhauz/src/common/models/permission_state.dart';
import 'package:stockhauz/src/common/providers/permission_provider.dart';

import 'package:stockhauz/src/router/app_router.dart';
import 'package:stockhauz/src/router/locations/app_location.dart';

class App extends StatefulHookConsumerWidget {
  const App({super.key, required this.theme});

  final ThemeData theme;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  final routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
        pathPatterns: [AppRouter.indexRoute],
        check: (BuildContext context, BeamLocation state) {
          final ref = ProviderScope.containerOf(context, listen: false);
          return ref.read(permissionProvider.select((status) => status)) ==
              PermissionStatus.granted;
        },
        beamToNamed: (_, __) => AppRouter.permissionRoute,
      ),
      BeamGuard(
        pathPatterns: [AppRouter.permissionRoute],
        check: (BuildContext context, BeamLocation state) {
          final ref = ProviderScope.containerOf(context, listen: false);
          return ref.read(permissionProvider.select((status) => status)) !=
              PermissionStatus.granted;
        },
        beamToNamed: (origin, target) => AppRouter.indexRoute,
      ),
    ],
    initialPath: AppRouter.permissionRoute,
    locationBuilder: (routeInformation, _) => AppLocation(routeInformation),
  );

  @override
  void initState() {
    super.initState();
    ref.read(permissionProvider.notifier).initialize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    await ref.read(permissionProvider.notifier).validate();
    routerDelegate.update();
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(permissionProvider);

    return BeamerProvider(
      routerDelegate: routerDelegate,
      child: MaterialApp.router(
        theme: widget.theme,
        routerDelegate: routerDelegate,
        debugShowCheckedModeBanner: false,
        routeInformationParser: BeamerParser(),
        backButtonDispatcher: BeamerBackButtonDispatcher(
          delegate: routerDelegate,
        ),
      ),
    );
  }
}
