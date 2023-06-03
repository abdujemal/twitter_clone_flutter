import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/auth_repo.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../core/provider/appwrite_provider.dart';
import '../../core/utils.dart';
import '../../models/user.dart';

final userProvider = StateProvider<User?>((ref) {
  return null;
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(authRepo: ref.read(authRepoProvider), ref: ref);
});

final loadingProvider = StateProvider<bool>((ref) => false);

class AuthNotifier extends StateNotifier<bool> {
  final AuthRepo authRepo;
  final Ref ref;
  AuthNotifier({required this.authRepo, required this.ref}) : super(false);

  getUser(String id, BuildContext context) async {
    final res = await authRepo.getCurrentUser(id);

    res.fold((l) {
      toast(l.message, Pallete.orangeColor);
      context.go('/editprofilepage/Ethiopia');
    }, (r) {
      ref.read(userProvider.notifier).update((state) => r);
      context.go(RouteConst.mainPage);
    });
  }

  signUpWEmail(
    String email,
    String password,
    String name,
    BuildContext context,
  ) async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final user = await authRepo.signUpWEmail(email, password, name);

    user.fold(
      (l) {
        ref.read(loadingProvider.notifier).update((state) => false);
        toast(l.message, Pallete.favColor);
      },
      (r) {
        signInWEmail(email, password, context);
      },
    );
  }

  signInWEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final user = await authRepo.signInWEmail(email, password);

    user.fold(
      (l) {
        ref.read(loadingProvider.notifier).update((state) => false);
        toast(l.message, Pallete.favColor);
      },
      (r) {
        authRepo.getCurrentUser(r.userId).then((res) {
          res.fold((l) {
            ref.read(loadingProvider.notifier).update((state) => false);
            context.go('/editprofilepage/:${r.countryName}');
          }, (r) {
            ref.read(loadingProvider.notifier).update((state) => false);
            ref.read(userProvider.notifier).update((state) => r);
            context.go(RouteConst.mainPage);
          });
        });
      },
    );
  }

  signInWithGoogle(BuildContext context) async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final user = await authRepo.googleSignIn();

    user.fold(
      (l) {
        ref.read(loadingProvider.notifier).update((state) => false);
        toast(l.message, Pallete.favColor);
      },
      (r) {
        print(r);
        // authRepo.getCurrentUser(r.userId).then((res) {
        //   res.fold((l) {
        //     ref.read(loadingProvider.notifier).update((state) => false);
        //     context.go('/editprofilepage/:${r.countryName}');
        //   }, (r) {
        //     ref.read(loadingProvider.notifier).update((state) => false);
        //     ref.read(userProvider.notifier).update((state) => r);
        //     context.go(RouteConst.mainPage);
        //   });
        // });
      },
    );
  }

  signOut(BuildContext context) async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final res = await authRepo.signOut();

    res.fold(
      (l) {
        ref.read(loadingProvider.notifier).update((state) => false);

        toast(l.message, Pallete.favColor);
      },
      (r) {
        ref.read(loadingProvider.notifier).update((state) => false);

        context.go(RouteConst.welcomePage);
      },
    );
  }
}
