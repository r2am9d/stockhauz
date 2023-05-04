import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:stockhauz/src/pages/index_page.dart';
import 'package:stockhauz/src/pages/permission/permission_page.dart';
import 'package:stockhauz/src/router/app_router.dart';

import 'package:stockhauz/src/utils/log_util.dart';
import 'package:stockhauz/src/common/bloc/permission/permission_bloc.dart';
import 'package:stockhauz/src/common/bloc/bottom_navbar/bottom_navbar_bloc.dart';

class App extends StatelessWidget {
  const App({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavbarBloc(),
        ),
        BlocProvider(
          create: (context) => PermissionBloc()
            ..add(const PermissionInitialize())
            ..add(const PermissionValidate()),
        ),
      ],
      child: _Root(theme: theme),
    );
  }
}

class _Root extends StatefulWidget {
  const _Root({required this.theme});

  final ThemeData theme;

  @override
  State<_Root> createState() => _RootState();
}

class _RootState extends State<_Root> with WidgetsBindingObserver {
  final BeamerDelegate _routerDelegate = BeamerDelegate(
    initialPath: AppRouter.indexRoute,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) {
          return IndexPage();
        },
        '/permission': (context, state, data) {
          return const BeamPage(
            title: 'Permission',
            key: ValueKey('permission'),
            child: PermissionPage(),
          );
        },
      },
    ).call,
    guards: [
      BeamGuard(
        guardNonMatching: true,
        pathPatterns: ['/permission'],
        check: (BuildContext context, BeamLocation state) {
          final permLoadedState = context.watch<PermissionLoaded>();
          return permLoadedState.status == PermissionStatus.granted;
        },
        beamToNamed: (origin, target) => '/permission',
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final permissionBloc = BlocProvider.of<PermissionBloc>(context);

    if (state == AppLifecycleState.resumed) {
      permissionBloc.add(const PermissionValidate());
      _routerDelegate.beamToNamed(AppRouter.indexRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: widget.theme,
      routerDelegate: _routerDelegate,
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: _routerDelegate,
      ),
    );
  }
}
