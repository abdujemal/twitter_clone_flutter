// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/provider/appwrite_provider.dart';
import 'package:twitter_clone/features/home/home_repo.dart';
import 'package:twitter_clone/models/tweet.dart';

import '../../app_write_config.dart';

final tweetsProvider = StateProvider<List<Tweet>>((ref) {
  return [];
});

final homeLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, bool>((ref) {
  return HomeNotifier(ref: ref, homeRepo: ref.read(homeProvider));
});

class HomeNotifier extends StateNotifier<bool> {
  final Ref ref;
  final HomeRepo homeRepo;
  HomeNotifier({
    required this.ref,
    required this.homeRepo,
  }) : super(false);

  
}
