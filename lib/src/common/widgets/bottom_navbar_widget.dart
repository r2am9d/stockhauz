import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stockhauz/gen/colors.gen.dart';
import 'package:stockhauz/src/common/bloc/bottom_navbar/bottom_navbar_bloc.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
      builder: (
        BuildContext btmNavbarContext,
        BottomNavbarState btmNavbarState,
      ) {
        final btmNavbarBloc = btmNavbarContext.read<BottomNavbarBloc>();
        final btmNavbarLoadedState =
            btmNavbarBloc.states<BottomNavbarLoaded>()!;

        return SalomonBottomBar(
          currentIndex: btmNavbarLoadedState.index,
          onTap: (index) {
            btmNavbarBloc.add(BottomNavbarShift(index: index));
          },
          items: [
            SalomonBottomBarItem(
              title: const Text('Dashboard'),
              selectedColor: AppColor.primary,
              icon: const FaIcon(FontAwesomeIcons.lightScroll),
              activeIcon: const FaIcon(FontAwesomeIcons.solidScroll),
            ),
            SalomonBottomBarItem(
              title: const Text('Product'),
              selectedColor: AppColor.primary,
              icon: const FaIcon(FontAwesomeIcons.lightHatChef),
              activeIcon: const FaIcon(FontAwesomeIcons.solidHatChef),
            ),
          ],
        );
      },
    );
  }
}
