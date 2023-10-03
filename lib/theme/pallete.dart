import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) => ThemeNotifier());

class Pallete {
  // colors
  static const bgColor = Color(0xfffafafa);
  static const whiteColor = Colors.white;
  static const primaryColor = Color(0xff1da2ef);
  static const greyColor = Color(0xffeeeeee);
  static const subtitleColor = Color(0xff757575);
  static const textColor = Color(0xff6f7e8a);
  static const fadeTextColor = Color(0xffaab8c1);
  static const favColor = Color(0xffe0245e);
  static const orangeColor = Color(0xffff9701);
  static const notificationBgColor = Color(0xffe7ecf0);
  static const settingTitle = Color(0xff6c7e8c);

  // themes
  static var lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: bgColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
        // centerTitle: true,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
    drawerTheme: const DrawerThemeData(
      backgroundColor: bgColor,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(background: bgColor).copyWith(
      secondary: textColor,
    ),
  );

  static var darkTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: bgColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        elevation: 0,
        titleTextStyle: TextStyle(color: primaryColor, fontSize: 20)),
    drawerTheme: const DrawerThemeData(
      backgroundColor: bgColor,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: bgColor),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(background: bgColor),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  final ThemeMode mode;
  ThemeNotifier({this.mode = ThemeMode.dark}) : super(ThemeData.dark());
}
