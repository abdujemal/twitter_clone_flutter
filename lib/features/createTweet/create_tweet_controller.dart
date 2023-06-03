// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/core/utils.dart';

import 'package:twitter_clone/features/auth/auth_controller.dart';
import 'package:twitter_clone/features/createTweet/create_tweet_repo.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../models/tweet.dart';

final createTweetLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final createTweetNotifierProvider =
    StateNotifierProvider<CreateTweetNotifier, bool>((ref) {
  return CreateTweetNotifier(
      ref: ref, createTweetRepo: ref.read(createTweetProvider));
});

class CreateTweetNotifier extends StateNotifier<bool> {
  final Ref ref;
  final CreateTweetRepo createTweetRepo;
  CreateTweetNotifier({
    required this.ref,
    required this.createTweetRepo,
  }) : super(false);

  createTweet(Tweet tweet, String? filePath, BuildContext context) async {
    ref.read(createTweetLoadingProvider.notifier).update((state) => true);
    final res = await createTweetRepo.createTweet(tweet, filePath);

    res.fold((l) {
      ref.read(createTweetLoadingProvider.notifier).update((state) => false);
      toast(l.message, Pallete.favColor);
      print(l.message);
    }, (r) {
      ref.read(createTweetLoadingProvider.notifier).update((state) => false);
      context.pop();
    });
  }
}
