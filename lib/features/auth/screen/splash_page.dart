import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../core/provider/appwrite_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      ref.read(sharedPrefProvider).then((pref) {
        final bool isLoggedIn = pref.getBool("isLoggedIn") ?? false;
        final String? uid = pref.getString("uid");

        if (isLoggedIn && uid != null) {
          ref.read(authNotifierProvider.notifier).getUser(uid, context);
        } else {
          context.go(RouteConst.welcomePage);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Center(
        child: Image.asset(
          AssetConst.icon400,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
