import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:stockhauz/src/router/app_router.dart';
import 'package:stockhauz/src/common/widgets/bottom_navbar_widget.dart';
import 'package:stockhauz/src/common/providers/bottom_navbar_provider.dart';

class IndexPage extends ConsumerWidget {
  IndexPage({super.key});

  final routerDelegates = AppRouter.routerDelegates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(bottomNavbarProvider),
        children: [
          Beamer(
            routerDelegate: routerDelegates[0],
          ),
          Beamer(
            routerDelegate: routerDelegates[1],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
