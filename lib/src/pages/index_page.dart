import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stockhauz/src/router/app_router.dart';
import 'package:stockhauz/src/common/widgets/bottom_navbar_widget.dart';
import 'package:stockhauz/src/common/bloc/bottom_navbar/bottom_navbar_bloc.dart';

class IndexPage extends StatelessWidget {
  IndexPage({super.key});

  final routerDelegates = AppRouter.routerDelegates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
        builder: (
          BuildContext btmNavbarContext,
          BottomNavbarState btmNavbarState,
        ) {
          final btmNavbarBloc = btmNavbarContext.read<BottomNavbarBloc>();
          final btmNavbarLoadedState =
              btmNavbarBloc.states<BottomNavbarLoaded>()!;

          return IndexedStack(
            index: btmNavbarLoadedState.index,
            children: [
              Beamer(
                routerDelegate: routerDelegates[0],
              ),
              Beamer(
                routerDelegate: routerDelegates[1],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
