import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/screen/forget_password_page.dart';
import 'package:twitter_clone/features/auth/screen/login_page.dart';
import 'package:twitter_clone/features/auth/screen/main_page.dart';
import 'package:twitter_clone/features/auth/screen/signup_page.dart';
import 'package:twitter_clone/features/auth/screen/welcome_page.dart';
import 'package:twitter_clone/features/createTweet/create_tweet_page.dart';
import 'package:twitter_clone/features/profile/screens/edit_profile_page.dart';
import 'package:twitter_clone/features/profile/screens/profile_page.dart';
import 'package:twitter_clone/features/settings/settings_page.dart';
import 'package:twitter_clone/features/tweetDetail/tweet_detail_page.dart';

import 'features/auth/screen/splash_page.dart';

CustomTransitionPage navWithTransition(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Change the opacity of the screen using a Curve based on the the animation's
      // value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: RouteConst.splashPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const SplashPage(),
      ),
    ),
    GoRoute(
      path: RouteConst.welcomePage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const WelcomPage(),
      ),
    ),
    GoRoute(
      path: RouteConst.signupPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const SignUpPage(),
      ),
    ),
    GoRoute(
      path: RouteConst.loginPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const LoginPage(),
      ),
    ),
    GoRoute(
      path: RouteConst.forgetPasswordPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const ForgetPasswordPage(),
      ),
    ),
    GoRoute(
      path: RouteConst.mainPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const MainPage(),
      ),
    ),
    GoRoute(
      path: RouteConst.createTweetPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        CreateTweetPage(
          tweetType: state.queryParameters['tweetType']!,
          tweetId: state.queryParameters['tweetId'],
        ),
      ),
    ),
    GoRoute(
      path: RouteConst.profilePage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const ProfilePage(),
      ),
    ),
    GoRoute(
      path: RouteConst.editProfilePage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        EditProfilePage(
          country: state.pathParameters['country'],
        ),
      ),
    ),
    GoRoute(
      path: RouteConst.tweetDetail,
      pageBuilder: (context, state) => navWithTransition(
        state,
        TweetDetailPage(id: state.pathParameters["id"]!),
      ),
    ),
    GoRoute(
      path: RouteConst.settingsPage,
      pageBuilder: (context, state) => navWithTransition(
        state,
        const SettingsPage(),
      ),
    ),
  ],
);
