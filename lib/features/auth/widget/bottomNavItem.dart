import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class BottomNavItem extends StatelessWidget {
  final int icon;
  final int activeIcon;
  final bool isActive;
  final VoidCallback onTap;
  const BottomNavItem(
      {super.key,
      required this.icon,
      required this.isActive,
      required this.activeIcon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        IconData(
          isActive ? activeIcon : icon,
          fontFamily: "TwitterIcon",
        ),
        color: isActive ? Pallete.primaryColor : Pallete.textColor,
      ),
    );
  }
}
