import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stockhauz/gen/colors.gen.dart';
import 'package:stockhauz/src/common/providers/bottom_navbar_provider.dart';

class BottomNavbarWidget extends ConsumerWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beamer = Beamer.of(context);

    return SalomonBottomBar(
      currentIndex: ref.watch(bottomNavbarProvider),
      onTap: (index) {
        beamer.update();
        ref.read(bottomNavbarProvider.notifier).shift(index);
      },
      items: [
        SalomonBottomBarItem(
          title: const Text('Dashboard'),
          selectedColor: AppColor.primary,
          icon: const FaIcon(FontAwesomeIcons.lightGaugeMax),
          activeIcon: const FaIcon(FontAwesomeIcons.solidGaugeMax),
        ),
        SalomonBottomBarItem(
          title: const Text('Product'),
          selectedColor: AppColor.primary,
          icon: const FaIcon(FontAwesomeIcons.lightBox),
          activeIcon: const FaIcon(FontAwesomeIcons.solidBox),
        ),
      ],
    );
  }
}
