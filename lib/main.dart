import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app_write_config.dart';
import 'package:twitter_clone/features/auth/screen/welcome_page.dart';
import 'package:twitter_clone/router.dart';
import 'package:twitter_clone/theme/pallete.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initAppWrite();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Twitter Clone',
      theme: Pallete.lightTheme,
    );
  }
}
