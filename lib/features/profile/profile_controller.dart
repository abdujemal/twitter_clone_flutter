// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:twitter_clone/features/profile/profile_repo.dart';

import '../../core/constants/constants.dart';
import '../../core/utils.dart';
import '../../models/user.dart';
import '../../theme/pallete.dart';
import '../auth/auth_controller.dart';

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, bool>((ref) {
  return ProfileNotifier(ref: ref, profileRepo: ref.read(profileRepoProvider));
});

class ProfileNotifier extends StateNotifier<bool> {
  final Ref ref;
  final ProfileRepo profileRepo;
  ProfileNotifier({
    required this.ref,
    required this.profileRepo,
  }) : super(false);

  addUser(User user, File profile, File bg, BuildContext context) async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final res = await profileRepo.addUser(user, profile, bg);

    res.fold((l) {
      ref.read(loadingProvider.notifier).update((state) => false);

      toast(l.message, Pallete.favColor);

      print(l.message);
    }, (r) {
      ref.read(userProvider.notifier).update((state) => r);

      ref.read(loadingProvider.notifier).update((state) => false);

      context.go(RouteConst.mainPage);
    });
  }
}
