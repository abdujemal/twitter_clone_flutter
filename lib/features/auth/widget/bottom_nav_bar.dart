import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/theme/pallete.dart';

import 'bottomNavItem.dart';

final navIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  var nav;

  @override
  void initState() {
    nav = ref.read(navIndexProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(navIndexProvider);
    return Container(
      color: Pallete.whiteColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: AppIcon.home,
              isActive: index == 0,
              activeIcon: AppIcon.homeFill,
              onTap: () {
                nav.update((state) => 0);
              },
            ),
            BottomNavItem(
              icon: AppIcon.search,
              isActive: index == 1,
              activeIcon: AppIcon.searchFill,
              onTap: () {
                nav.update((state) => 1);
              },
            ),
            BottomNavItem(
              icon: AppIcon.notification,
              isActive: index == 2,
              activeIcon: AppIcon.notificationFill,
              onTap: () {
                nav.update((state) => 2);
              },
            ),
            BottomNavItem(
              icon: AppIcon.messageEmpty,
              isActive: index == 3,
              activeIcon: AppIcon.messageFill,
              onTap: () {
                nav.update((state) => 3);
              },
            )
          ],
        ),
      ),
    );
  }
}
